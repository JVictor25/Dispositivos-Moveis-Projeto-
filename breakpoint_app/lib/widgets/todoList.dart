import '../model/Vice.dart';
import 'package:flutter/material.dart';


class TodoList extends StatefulWidget {
  final List<Vice> listaVices;

  const TodoList({
    super.key,
    required this.listaVices,
  });

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<Vice> _listaVices = [];

  final double maxProgressValue = 100; // Defina o valor má

  @override
  void initState() {
    super.initState();
    _listaVices =
        widget.listaVices; // Inicializamos a lista com os dados do widget pai
  }

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
    if (_listaVices.isEmpty) {
      return Center(
        child: Text(
          "Nenhum vicío cadastrado",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      );
    }

    return Container(
        height: 300,
        child: Column(children: [
          // ListView.builder para exibir as tarefas
          Expanded(
            child: ListView.builder(
                itemCount: _listaVices.length,
                itemBuilder: (context, index) {
                  final progress =
                      calculateProgress(_listaVices[index].datesobriety);
                  final milestone =
                      nextMilestone(_listaVices[index].datesobriety);
                  return Card(
                    margin: EdgeInsets.all(8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.local_drink,
                                        color: const Color.fromARGB(
                                            255, 37, 0, 44)),
                                    SizedBox(width: 8),
                                    Text(
                                      _listaVices[index].typeofvice,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                Text(
                                  _calculateTimeDifference(
                                      _listaVices[index].datesobriety),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                    height: 10), // Espacamento acima da barra
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 100, // Ajuste conforme necessário
                                      height: 100, // Ajuste conforme necessário
                                      child: CircularProgressIndicator(
                                        value: progress / 100,
                                        backgroundColor: Colors.grey[200],
                                        color: const Color.fromARGB(
                                            255, 58, 2, 68),
                                        strokeWidth: 7,
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Center(
                                        child: Text(
                                          '${progress.round()}%',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 58, 2, 68),
                                              fontSize: 24),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(
                                    height: 10), // Espacamento abaixo da barra
                                Text(
                                  milestone,
                                  style: Theme.of(context).textTheme.bodySmall,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ]));
  }
}
