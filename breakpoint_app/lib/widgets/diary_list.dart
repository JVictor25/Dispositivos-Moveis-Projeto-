import 'package:breakpoint_app/data/data.dart';
import 'package:breakpoint_app/model/DiaryEntry.dart';
import 'package:breakpoint_app/providers/diary_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DiaryList extends StatefulWidget {
  const DiaryList({super.key});

  @override
  State<DiaryList> createState() => _DiaryListState();
}

class _DiaryListState extends State<DiaryList> {

  final Map<String, Color> emotionColors = {
    "Feliz": Colors.yellow.shade300,
    "Triste": Colors.blue.shade300,
    "Raiva": Colors.red.shade300,
    "Ansioso": Colors.orange.shade300,
    "Cansado": Colors.grey.shade400,
  };

  // final Map<String, String> emotionEmojis = {
  //   "Feliz": "😊",
  //   "Triste": "😔",
  //   "Raiva": "😡",
  //   "Ansioso": "😖",
  //   "Cansado": "😩",
  // };

  void _openConfirmationModel(DiaryEntry entry) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Excluir entrada?'),
          content: Text('Tem certeza que deseja excluir esse registro?'),
          actions: [
            TextButton(
              onPressed: () {
                context.read<DiaryProvider>().removeEntry(entry);
                Navigator.of(context).pop();
              },
              child: Text('Excluir'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    Provider.of<DiaryProvider>(context, listen: false).fetchEntries();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DiaryProvider>(
      builder: (context, diaryProvider, child) {
          if (diaryProvider.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          // inverter lista
          final entries = diaryProvider.diaryEntries.reversed.toList();
          return (entries.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/empty-diary.png', width: 150),
                  Text(
                    'Nenhum registro no diário',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: entries.length,
              itemBuilder: (BuildContext context, int index) {
                final entry = diaryProvider.diaryEntries[index];
                final color = emotionColors[entry.emotion] ?? Colors.white;
                final emoji = emotionEmojis[entry.emotion] ?? "❓";
                return Card.filled(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    color: color,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(244, 246, 255, 1),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                  ),
                                ),
                                padding: EdgeInsets.all(4),
                                child: Text(
                                  emoji,
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              Text(
                                DateFormat('dd/MM/yyyy')
                                    .format(diaryProvider.diaryEntries[index].createdAt),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(32, 32, 32, 0.589),
                                  
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Color.fromRGBO(30, 30, 30, 1),
                                ),
                                onPressed: () => _openConfirmationModel(
                                    diaryProvider.diaryEntries[index]),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              diaryProvider.diaryEntries[index].text,
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(30, 30, 30, 1),
                              ),
                            )
                          ),
                        ],
                      ),
                    ));
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 8),
            ));}
      );
  }
}