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

  bool isMarked(DateTime day) {
  DateTime now = DateTime.now();

  if (day.year == now.year && day.month == now.month && day.day == now.day) {
    return false;
  }
  return day.isAfter(widget.dateCreation.subtract(Duration(days: 1))) &&
      day.isBefore(now.add(Duration(days: 1)));
}

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: widget.dateCreation,
      lastDay: DateTime.now(),
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) => isMarked(day), // Chama a função para marcar os dias
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, focusedDay) {
          if (isMarked(day)) {
            return Container(
              margin: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                day.day.toString(),
                style: TextStyle(color: Colors.white),
              ),
            );
          }
          return null; // Usa o estilo padrão para os outros dias
        },
      ),
      calendarStyle: CalendarStyle(
        selectedDecoration: BoxDecoration(
          color: Color(0xffA8DADC),
          shape: BoxShape.circle,
        ),
        todayDecoration: BoxDecoration(
          color: Color(0xff133E87),
          shape: BoxShape.circle,
        ),
      ),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
      ),
    );
  }
}
