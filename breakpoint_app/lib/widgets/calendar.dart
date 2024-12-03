// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar(
      {super.key, required this.dateCreation, required this.datesobriety});

  final DateTime dateCreation;
  final DateTime datesobriety;

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late DateTime _selectedDate;
  late DateTime _focusedDay;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.datesobriety;
    _focusedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: widget.dateCreation,
      lastDay: DateTime.now(),
      focusedDay: _focusedDay,
      calendarStyle: CalendarStyle(
        selectedDecoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
        todayDecoration: BoxDecoration(
          color: Colors.orange,
          shape: BoxShape.circle,
        ),
      ),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
      ),
    );
  }
}
