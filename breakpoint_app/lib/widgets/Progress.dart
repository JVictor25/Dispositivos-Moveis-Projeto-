// ignore_for_file: prefer_const_constructors

import 'package:breakpoint_app/model/Vice.dart';
import 'package:flutter/material.dart';

class Progress extends StatefulWidget {
  const Progress({super.key, required this.date});

  final DateTime date;

  @override
  State<Progress> createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
  final double maxProgressValue = 100;

  double calculateProgress(DateTime targetDate) {
    final now = DateTime.now();
    final difference = now.difference(targetDate);

    if (difference.inMinutes <= 10080) {
      return (difference.inMinutes) / 10080 * maxProgressValue;
    } else if (difference.inMinutes <= 20160) {
      return (difference.inMinutes) / 20160 * maxProgressValue;
    } else if (difference.inDays <= 30) {
      return (difference.inDays) / 30 * maxProgressValue;
    } else if (difference.inDays <= 90) {
      return (difference.inDays) / 90 * maxProgressValue;
    } else if (difference.inDays <= 180) {
      return (difference.inDays) / 180 * maxProgressValue;
    } else if (difference.inDays <= 365) {
      return (difference.inDays) / 365 * maxProgressValue;
    } else if (difference.inDays <= 730) {
      return (difference.inDays) / 730 * maxProgressValue;
    } else if (difference.inDays <= 1095) {
      return (difference.inDays) / 1095 * maxProgressValue;
    } else if (difference.inDays <= 1825) {
      return (difference.inDays) / 1825 * maxProgressValue;
    }

    return 0; // Retorna 0 para datas passadas ou atuais
  }

  String nextMilestone(DateTime targetDate) {
    final now = DateTime.now();
    final difference = now.difference(targetDate);

    if (difference.inMinutes <= 10080) {
      return "1 Semana";
    } else if (difference.inMinutes <= 20160) {
      return "2 Semanas";
    } else if (difference.inDays <= 30) {
      return "1 Mês";
    } else if (difference.inDays <= 90) {
      return "3 Meses";
    } else if (difference.inDays <= 180) {
      return "6 Meses";
    } else if (difference.inDays <= 365) {
      return "1 Ano";
    } else if (difference.inDays <= 730) {
      return "2 Anos";
    } else if (difference.inDays <= 1095) {
      return "3 Anos";
    } else if (difference.inDays <= 1825) {
      return "5 Anos";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    final progress = calculateProgress(widget.date);
    final milestone = nextMilestone(widget.date);
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 70,
              height: 70,
              child: CircularProgressIndicator(
                value: progress / 100,
                backgroundColor: Colors.grey[200],
                color: Color.fromRGBO(19, 75, 112, 1),
                strokeWidth: 7,
              ),
            ),
            Center(
              child: Text(
                '${progress.round()}%',
                style: TextStyle(color: Color(0xff133E87), fontSize: 24, fontFamily: 'PoppinsRegular'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          milestone,
          style: TextStyle(
              fontFamily: 'PoppinsRegular',
              fontSize: 14,
              color: Color(0xff133E87)),
        ),
      ],
    );
  }
}
