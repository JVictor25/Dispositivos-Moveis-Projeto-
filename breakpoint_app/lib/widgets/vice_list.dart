// ignore_for_file: prefer_const_constructors

import '../model/Vice.dart';
import 'package:flutter/material.dart';

class ViceList extends StatefulWidget {
   final Function(Vice) onDelete;

  const ViceList({
    super.key,
    required List<Vice> vicesList,
    required this.onDelete,
  }) : _vicesList = vicesList;

  final List<Vice> _vicesList;

  @override
  State<ViceList> createState() => _ViceListState();
}

class _ViceListState extends State<ViceList> {
  final double maxProgressValue = 100; // Defina o valor má

  String _calculateTimeDifference(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 365) {
      return '${difference.inDays ~/ 365} anos, ${difference.inDays % 365 ~/ 30} meses e ${difference.inDays % 30} dias';
    } else if (difference.inDays > 30) {
      return '${difference.inDays ~/ 30} meses e ${difference.inDays % 30} dias';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} dias';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} horas';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutos';
    } else {
      return 'Hoje';
    }
  }
  

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
    if (widget._vicesList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/brokenchain.png', width: 150),
            const Text(
              'Busque o autocrontrole',
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
      itemCount: widget._vicesList.length,
      itemBuilder: (BuildContext context, int index) {
        final vice = widget._vicesList[index];
        final progress = calculateProgress(vice.datesobriety);
        final milestone = nextMilestone(vice.datesobriety);

        Map<String, IconData> iconMap = {
          'geral': Icons.add_box,
          'alcool': Icons.local_bar,
          'fumo': Icons.smoke_free_outlined,
          'jogos de azar': Icons.casino,
          'comida': Icons.restaurant,
          'drogas': Icons.local_pharmacy,
          'tecnologia': Icons.computer,
          'trabalho': Icons.work,
          'relacionamentos': Icons.person,
        };

        return Dismissible(
          key: Key(vice.typeofvice),
          direction: DismissDirection.endToStart,
          confirmDismiss: (direction) async {
            final result = await showDialog<bool>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Excluir hábito?"),
                  content: Text("Tem certeza que deseja excluir este hábito?"),
                  actions: <Widget>[
                    TextButton(
                      child: Text("Confirmar"),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                    ),
                    TextButton(
                      child: Text("Cancelar"),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                    ),
                  ],
                );
              },
            );
            return result ?? false; // Exclui apenas se confirmado
          },
          onDismissed: (direction) {
            widget.onDelete(vice); // Chama o callback para deletar
          },
          background: Container(
            alignment: Alignment.centerRight,
            color: Colors.red,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Icon(Icons.delete, color: Colors.white),
          ),
          child: Card.filled(
            color: Color(0x7580C4E9),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        iconMap[vice.viceType.toLowerCase()] ?? Icons.add_box,
                        size: 24,
                        color: Color.fromRGBO(19, 75, 112, 1),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        vice.typeofvice,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Tempo de abstinência:",
                              style: Theme.of(context).textTheme.bodySmall),
                          Text(
                            _calculateTimeDifference(vice.datesobriety),
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                      Column(
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
                                  color: const Color.fromRGBO(19, 75, 112, 1),
                                  strokeWidth: 7,
                                ),
                              ),
                              Center(
                                child: Text(
                                  '${progress.round()}%',
                                  style: const TextStyle(
                                      color: Color.fromRGBO(19, 75, 112, 1),
                                      fontSize: 24),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            milestone,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}