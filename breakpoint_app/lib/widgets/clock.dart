// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:flutter/material.dart';

class Clock extends StatefulWidget {
  const Clock({super.key, required this.date});

  final DateTime date;

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  late Timer _timer;
  late String _currentTime;
  late DateTime _startDateTime;

  @override
  void initState() {
    super.initState();

    _startDateTime = widget.date;

    _currentTime = _formatTime(DateTime.now());
    _startClock();
  }

  @override
  void didUpdateWidget(Clock oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.date != oldWidget.date) {
      _resetClock();
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime(DateTime startDateTime) {
    DateTime now = DateTime.now().toUtc();
    DateTime nowWithoutMilliseconds = DateTime(
        now.year, now.month, now.day, now.hour, now.minute, now.second);
    final difference = nowWithoutMilliseconds.difference(startDateTime);

    int years = (difference.inDays / 365).floor();
    int months = ((difference.inDays % 365) / 30).floor();
    int days = difference.inDays % 30;
    int hours = difference.inHours % 24;
    int minutes = difference.inMinutes % 60;
    int seconds = difference.inSeconds % 60;

    if (years >= 1) {
      return "${years}a ${months}m ${days}d ${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
    } else if (months >= 1) {
      return "${months}m ${days}d ${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
    } else if (days >= 1) {
      return "${days}d ${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
    } else {
      return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
    }
  }

  void _startClock() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = _formatTime(_startDateTime);
      });
    });
  }

  void _resetClock() {
    _startDateTime = widget.date;
    _currentTime = _formatTime(_startDateTime);
    _timer.cancel();
    _startClock();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _currentTime,
      style: TextStyle(
          fontFamily: 'PoppinsRegular',
          fontSize: 14,
          color: Color(0xff133E87),
          fontWeight: FontWeight.bold),
    );
  }
}
