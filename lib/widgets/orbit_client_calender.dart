import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/helper/main_helper.dart';
import 'package:table_calendar/table_calendar.dart';

class OrbitClientCalender extends StatelessWidget {
  final Function(DateTime selectedDay, DateTime focusedDay) onDaySelected;
  final Function(DateTime? rangeStart, DateTime? rangeEnd, DateTime? focuesDay)
      onRangeSelected;
  final DateTime focusedDay;
  final DateTime selectedDate;
  final DateTime rangeStart;
  final DateTime rangeEnd;
  final RangeSelectionMode rangeSelectionMode;
  const OrbitClientCalender(
      {super.key,
      required this.onDaySelected,
      required this.selectedDate,
      this.rangeSelectionMode = RangeSelectionMode.enforced,
      required this.rangeStart,
      required this.rangeEnd,
      required this.focusedDay,
      required this.onRangeSelected});

  @override
  Widget build(BuildContext context) {
    final height = Get.find<MainHelper>().mScreenHeight * 0.5;
    final width = Get.find<MainHelper>().mScreenWidth * 0.5;

    return TableCalendar(
      onRangeSelected: onRangeSelected,
      rangeEndDay: rangeEnd,
      rangeStartDay: rangeStart,
      rangeSelectionMode: rangeSelectionMode,
      focusedDay: focusedDay,
      firstDay: DateTime(2020),
      lastDay: DateTime(2030),
      shouldFillViewport: false,
      onDaySelected: onDaySelected,
      selectedDayPredicate: (day) {
        return isSameDay(selectedDate, day);
      },
      enabledDayPredicate: (day) {
        return !day.isBefore(DateTime.now());
      },
      calendarFormat: CalendarFormat.month,
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
      },
      calendarStyle: const CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Colors.purple,
          shape: BoxShape.circle,
        ),
        weekendTextStyle: TextStyle(
          color: Colors.red,
        ),
        defaultTextStyle: TextStyle(
          color: Colors.black,
        ),
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        formatButtonVisible: true,
        formatButtonShowsNext: false,
        formatButtonDecoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(16.0),
        ),
        formatButtonTextStyle: const TextStyle(
          color: Colors.white,
        ),
      ),
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, focusedDay) {
          if (day.isBefore(DateTime.now())) {
            return Center(
              child: Text(
                day.day.toString(),
                style: const TextStyle(color: Colors.grey),
              ),
            );
          }
          return null;
        },
      ),
    );
  }
}
