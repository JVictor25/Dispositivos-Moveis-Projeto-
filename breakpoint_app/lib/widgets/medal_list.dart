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
      return const Color(0xFFCD7F32);
    }
    return const Color(0xFFF08080);
  }

  String _formatSobrietyTime(int months) {
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

        return Card.filled(
          color: const Color(0x7580C4E9),
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
                        vicesList[index].typeofvice,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${_formatSobrietyTime(months)}',
                        style: Theme.of(context).textTheme.titleSmall,
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
