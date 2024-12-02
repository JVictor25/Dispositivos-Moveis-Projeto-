// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:breakpoint_app/model/Vice.dart';
import 'package:flutter/material.dart';

class Clock extends StatefulWidget {
  const Clock({super.key, required this.vice});

  final Vice vice;

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

    _startDateTime = widget.vice.datesobriety;

    _currentTime = _formatTime(DateTime.now());
    _startClock();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime(DateTime startDateTime) {
    DateTime now = DateTime.now();
    Duration difference = now.difference(startDateTime);

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
