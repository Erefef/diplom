import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart'; // инициализация локалей
import 'package:pregnancy_calendar/presentation/screens/main_screen.dart';
import 'utils/constants.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting(); // загружаем данные для всех локалей
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appTitle,

      // --- Добавляем локаль и поддержку локализации ---
      locale: const Locale('ru'), // фиксированная локаль (можно сделать системной)
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ru'),
        Locale('en'), // если нужен английский
      ],
      // -----------------------------------------------

      theme: ThemeData(
        primarySwatch: Colors.pink,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: AppConstants.primaryColor,
          unselectedItemColor: Colors.grey,
        ),
      ),
      home: const MainScreen(),
    );
  }
}