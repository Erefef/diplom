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
    final firstDate = conceptionDate;
    final lastDate = conceptionDate.add(
      const Duration(days: AppConstants.pregnancyDuration),
    );

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        elevation: 8,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.blue.shade50,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.all(16),
          child: TableCalendar(
            firstDay: firstDate,
            lastDay: lastDate,
            focusedDay: selectedDay,
            locale: 'ru_RU',
            selectedDayPredicate: (day) => isSameDay(selectedDay, day),
            onDaySelected: (day, _) => onDaySelected(day),

            // ⚙️ НАСТРОЙКИ ВНЕШНЕГО ВИДА
            calendarStyle: CalendarStyle(
              // Выделенный день
              selectedDecoration: BoxDecoration(
                color: Colors.blue.shade300,
                shape: BoxShape.circle,
              ),
              selectedTextStyle: const TextStyle(color: Colors.white),

              // Сегодня
              todayDecoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.blue.shade300, width: 1.5),
              ),
              todayTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade900,
              ),

              // Выходные дни
              weekendTextStyle: TextStyle(color: Colors.grey.shade600),

              // Обычные дни
              defaultTextStyle: TextStyle(color: Colors.blueGrey.shade900),

              // Отключаем фон при нажатии
              markerDecoration: const BoxDecoration(),
              // Убираем лишние границы
              cellMargin: const EdgeInsets.all(0),
              tableBorder: TableBorder.symmetric(
                inside: BorderSide.none,
                outside: BorderSide.none,
              ),
            ),

            // 🗓 ЗАГОЛОВОК МЕСЯЦА
            headerStyle: HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
              titleTextStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.blueGrey.shade800,
              ),
              leftChevronIcon: Icon(
                Icons.chevron_left,
                color: Colors.blueGrey.shade600,
              ),
              rightChevronIcon: Icon(
                Icons.chevron_right,
                color: Colors.blueGrey.shade600,
              ),
            ),

            // 📆 ДНИ НЕДЕЛИ
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyle(color: Colors.grey.shade700),
              weekendStyle: TextStyle(color: Colors.grey.shade700),
            ),

            // 🔔 МАРКЕРЫ КОММЕНТАРИЕВ
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, date, _) {
                return FutureBuilder<String?>(
                  future: dataSource.getComment(date),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return _buildCommentIndicator();
                    }
                    return const SizedBox.shrink();
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCommentIndicator() {
    return Positioned(
      right: 1,
      bottom: 1,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue.shade300,
          shape: BoxShape.circle,
        ),
        width: 8,
        height: 8,
      ),
    );
  }
}