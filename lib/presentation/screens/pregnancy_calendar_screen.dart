import 'package:flutter/material.dart';
import '../widgets/calendar_widget.dart';
import '../widgets/comment_dialog.dart';
import '../widgets/pregnancy_info_card.dart';
import '../../data/local_data_source.dart';
import '../../utils/constants.dart';

class PregnancyCalendarScreen extends StatefulWidget {
  const PregnancyCalendarScreen({Key? key}) : super(key: key);

  @override
  PregnancyCalendarScreenState createState() => PregnancyCalendarScreenState();
}

class PregnancyCalendarScreenState extends State<PregnancyCalendarScreen> {
  final LocalDataSource _dataSource = LocalDataSource();
  DateTime? _conceptionDate;
  DateTime _selectedDay = DateTime.now();

  // Ключ для доступа к состоянию PregnancyInfoCard
  final GlobalKey<PregnancyInfoCardState> _infoCardKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _loadConceptionDate();
  } //здесь я возвращаю значение оператора состояния из списка и
    //присваеваю эту переменную переменной календаря
    //для изменения данных внутри

  Future<void> _loadConceptionDate() async {
    final date = await _dataSource.getConceptionDate();
    setState(() => _conceptionDate = date);
  }

  Future<void> _selectConceptionDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      await _dataSource.saveConceptionDate(selectedDate);
      setState(() => _conceptionDate = selectedDate);
      _infoCardKey.currentState?.refresh();
    }
  }

  void _handleDaySelected(DateTime day) {
    if (_isValidPregnancyDay(day)) {
      setState(() => _selectedDay = day);
      _showCommentDialog(day);
    }
  }

  bool _isValidPregnancyDay(DateTime day) {
    if (_conceptionDate == null) return false;
    final dueDate = _conceptionDate!.add(const Duration(days: AppConstants.pregnancyDuration));
    return !day.isBefore(_conceptionDate!) && !day.isAfter(dueDate);
  }

  Future<void> _showCommentDialog(DateTime day) async {
    await showDialog(
      context: context,
      builder: (context) => CommentDialog(
        day: day,
        dataSource: _dataSource,
        onCommentSaved: () => setState(() {}),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppConstants.appTitle)),
      body: _conceptionDate == null
          ? Center(
        child: ElevatedButton(
          onPressed: _selectConceptionDate,
          child: const Text(AppConstants.selectDateButton),
        ),
      )
          : Column(
        children: [
          // Новая карточка с информацией о беременности
          PregnancyInfoCard(key: _infoCardKey),
          // Существующий календарь
          Expanded(
            child: CalendarWidget(
              conceptionDate: _conceptionDate!,
              selectedDay: _selectedDay,
              onDaySelected: _handleDaySelected,
              dataSource: _dataSource,
            ),
          ),
        ],
      ),
    );
  }
}