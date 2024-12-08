// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:breakpoint_app/model/Vice.dart';
import 'package:breakpoint_app/model/Medal.dart';

class MedalList extends StatelessWidget {
  final List<Vice> vicesList;

  const MedalList({
    super.key,
    required this.vicesList,
  });

  int _timeBetween(DateTime from, DateTime to) {
    return (to.year - from.year) * 12 + to.month - from.month;
  }

  Color _getMedalColor(int months) {
    if (months >= 24) {
      return const Color(0xff50C878);
    }
    if (months >= 12) {
      return const Color(0xFFFFD700);
    }
    if (months >= 6) {
      return const Color(0xFFC0C0C0);
    }
    if (months >= 3) {
      return const Color.fromARGB(255, 155, 86, 17);
    }
    return const Color(0xFFF08080);
  }

  String _formatSobrietyTime(int months) {
    if (months == 0){
      return "Parabéns pela iniciativa!!";
    }
    if (months >= 12) {
      int years = months ~/ 12;
      int remainingMonths = months % 12;

      if (remainingMonths == 0) {
        return '$years ${years == 1 ? 'ano' : 'anos'}';
      }
      return '$years ${years == 1 ? 'ano' : 'anos'} e $remainingMonths ${remainingMonths == 1 ? 'mês' : 'meses'}';
    }

    return '$months ${months == 1 ? 'mês' : 'meses'}';
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    if (vicesList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/mountain.png', width: 150),
            const Text(
              'Comece sua jornada rumo ao topo!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: vicesList.length,
      itemBuilder: (BuildContext context, int index) {
        final months = _timeBetween(vicesList[index].datesobriety, now);
        final medalColor = _getMedalColor(months);

        return Card(
          color: Color(0xffE6E6FA),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Medal(
                  color: medalColor,
                  size: 80,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        vicesList[index].viceType,
                        style: TextStyle(
                            fontFamily: 'PoppinsRegular',
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${_formatSobrietyTime(months)}',
                        style: TextStyle(
                            fontFamily: 'PoppinsRegular',
                            fontSize: 14,
                            color: Color(0xff133E87),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
