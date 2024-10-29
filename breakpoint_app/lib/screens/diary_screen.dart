// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:breakpoint_app/model/DiaryEntry.dart';
import 'package:breakpoint_app/widgets/diary_form.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class Diary extends StatefulWidget {
  final List<DiaryEntry> entries;

  Diary({super.key})
      : entries = [/*
          DiaryEntry(
            body: 'Passei na frente do bar, foi difícil mas consegui resistir.',
            date: DateTime(2024, 10, 1),
          ),
          DiaryEntry(
            body:
                'Hoje perdi de novo. Estava com um pressentimento de que iria ganhar dessa vez, mas não foi assim. Me sinto meio culpado, mas, ao mesmo tempo, tudo o que penso é em como posso melhorar minha próxima aposta. Acendi um cigarro logo que saí da casa de apostas. O gosto nem me agrada mais, mas ajuda a acalmar o nervosismo. Devo uns R\$500 agora.',
            date: DateTime(2024, 10, 5),
          ),
          DiaryEntry(
            body: 'Passei na frente do bar, foi difícil mas consegui resistir.',
            date: DateTime(2024, 10, 10),
          ),
          DiaryEntry(
            body: 'Passei na frente do bar, foi difícil mas consegui resistir.',
            date: DateTime(2024, 10, 15),
          ),
          DiaryEntry(
            body: 'Passei na frente do bar, foi difícil mas consegui resistir.',
            date: DateTime(2024, 10, 20),
          ),
          DiaryEntry(
            body: 'Passei na frente do bar, foi difícil mas consegui resistir.',
            date: DateTime(2024, 10, 25),
          ),*/
        ];

  @override
  State<Diary> createState() => _DiaryState();
}

class _DiaryState extends State<Diary> {
  void _addEntry(String body) {
    widget.entries.add(DiaryEntry(body: body));

    setState(() {
      widget.entries;
    });

    Navigator.of(context).pop();
  }

  void _openDiaryForm() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SingleChildScrollView(child: DiaryForm(onSubmit: _addEntry)),
          );
        });
  }

  void _removeEntry(DiaryEntry entry) {
    widget.entries.remove(entry);

    setState(() {
      widget.entries;
    });
  }

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
                _removeEntry(entry);
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.entries.isEmpty
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
              itemCount: widget.entries.length,
              itemBuilder: (BuildContext context, int index) {
                return Card.filled(
                    color: Color.fromRGBO(128, 196, 233, 0.46),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 6, 6, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                DateFormat('dd/MM/yyyy')
                                    .format(widget.entries[index].date),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Color.fromRGBO(30, 30, 30, 1),
                                ),
                                onPressed: () => _openConfirmationModel(
                                    widget.entries[index]),
                              ),
                            ],
                          ),
                          Text(widget.entries[index].body),
                        ],
                      ),
                    ));
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 8),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openDiaryForm,
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF134B70),
        foregroundColor: Colors.white,
      ),
    );
  }
}
