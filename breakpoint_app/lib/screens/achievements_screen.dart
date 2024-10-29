import 'package:breakpoint_app/model/Vice.dart';
import 'package:flutter/material.dart';
import '../widgets/medal.dart';
import './addiction_screen.dart';

class Achievements extends StatelessWidget{
  final List<Vice> viceList;
  
  const Achievements({
    super.key,
    required this.viceList,
  });
  
  int _timeBetween(DateTime from, DateTime to) {
    return (to.year - from.year) * 12 + to.month - from.month;
  }

  Color _getMedalColor(int months) {
    if(months >= 12) {
      return const Color(0xFFFFD700);
    }
    if(months >= 6) {
      return const Color(0xFFC0C0C0);
    }
    if(months >= 3) {
      return const Color(0xFFCD7F32);
    }
    
    return const Color(0xFFF08080);
  }

  String _formatSobrietyTime(int months) {
    if(months >= 12) {
      int years = months ~/ 12;
      int remainingMonths = months % 12;

      if(remainingMonths == 0) {
        return '$years ${years == 1 ? 'ano' : 'anos'}';
      }
      return '$years ${years == 1 ? 'ano' : 'anos'} e $remainingMonths ${remainingMonths == 1 ? 'mês' : 'meses'}';
    }

    return '$months ${months == 1 ? 'mês' : 'meses'}';
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: viceList.map((vice) {
            final months = _timeBetween(vice.datesobriety, now);
            final medalColor = _getMedalColor(months);

            return Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(16),
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
                          vice.typeofvice,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${_formatSobrietyTime(months)}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}