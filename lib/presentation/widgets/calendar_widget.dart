import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../data/local_data_source.dart';
import '../../utils/constants.dart';

class CalendarWidget extends StatelessWidget {
  final DateTime conceptionDate;
  final DateTime selectedDay;
  final Function(DateTime) onDaySelected;
  final LocalDataSource dataSource;

  const CalendarWidget({
    Key? key,
    required this.conceptionDate,
    required this.selectedDay,
    required this.onDaySelected,
    required this.dataSource,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: conceptionDate,
      lastDay: conceptionDate.add(Duration(days: AppConstants.pregnancyDuration)),
      focusedDay: selectedDay,
      selectedDayPredicate: (day) => isSameDay(selectedDay, day),
      onDaySelected: (day, _) => onDaySelected(day),
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, date, _) {
          return FutureBuilder<String?>(
            future: dataSource.getComment(date),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return _buildCommentIndicator();
              }
              return SizedBox.shrink();
            },
          );
        },
      ),
    );
  }

  Widget _buildCommentIndicator() {
    return Positioned(
      right: 1,
      bottom: 1,
      child: Container(
        decoration: BoxDecoration(
          color: AppConstants.primaryColor,
          shape: BoxShape.circle,
        ),
        width: 8,
        height: 8,
      ),
    );
  }
}