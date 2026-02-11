import 'package:flutter/material.dart';
import '../widgets/calendar_widget.dart';
import '../widgets/comment_dialog.dart';
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

  @override
  void initState() {
    super.initState();
    _loadConceptionDate();
  }

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
          : CalendarWidget(
        conceptionDate: _conceptionDate!,
        selectedDay: _selectedDay,
        onDaySelected: _handleDaySelected,
        dataSource: _dataSource,
      ),
    );
  }
}