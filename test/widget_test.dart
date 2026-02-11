import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:pregnancy_calendar/presentation/screens/main_screen.dart';
import 'package:pregnancy_calendar/utils/constants.dart';

void main() {
  testWidgets('MainScreen initial state test', (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(home: MainScreen())
    );

    expect(find.text(AppConstants.appTitle), findsOneWidget);
    expect(find.text(AppConstants.selectDateButton), findsOneWidget);
  });

  testWidgets('Date selection and calendar display test',
          (WidgetTester tester) async {
        await tester.pumpWidget(
            MaterialApp(home: MainScreen())
        );

        await tester.tap(find.text(AppConstants.selectDateButton));
        await tester.pumpAndSettle();

        await tester.tap(find.text('1'));
        await tester.tap(find.text('OK'));
        await tester.pumpAndSettle();

        expect(find.byType(TableCalendar), findsOneWidget);
      });
}