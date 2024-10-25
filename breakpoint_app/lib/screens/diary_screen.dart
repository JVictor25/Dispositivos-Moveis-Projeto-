import 'package:flutter/material.dart';
import 'package:breakpoint_app/model/diaryEntry.dart';
import 'package:breakpoint_app/widgets/diary_form.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class Diary extends StatelessWidget {
  final List<DiaryEntry> entries;

  Diary({super.key})
      : entries = [
          DiaryEntry(
              body:
                  'Passei na frente do bar, foi difícil mas consegui resistir.'),
          DiaryEntry(
              body:
                  'Hoje perdi de novo. Estava com um pressentimento de que iria ganhar dessa vez, mas não foi assim. Me sinto meio culpado, mas, ao mesmo tempo, tudo o que penso é em como posso melhorar minha próxima aposta. Acendi um cigarro logo que saí da casa de apostas. O gosto nem me agrada mais, mas ajuda a acalmar o nervosismo. Devo uns R\$500 agora.'),
          DiaryEntry(
              body:
                  'Passei na frente do bar, foi difícil mas consegui resistir.'),
          DiaryEntry(
              body:
                  'Passei na frente do bar, foi difícil mas consegui resistir.'),
          DiaryEntry(
              body:
                  'Passei na frente do bar, foi difícil mas consegui resistir.'),
          DiaryEntry(
              body:
                  'Passei na frente do bar, foi difícil mas consegui resistir.'),
        ];

  void _openDiaryForm(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Padding(
              padding: const EdgeInsets.fromLTRB(16, 60, 16, 16),
              child: DiaryForm(),
            );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
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
                          DateFormat('dd/MM/yyyy').format(entries[index].date),
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
                          onPressed: () {},
                        ),
                      ],
                    ),
                    Text(entries[index].body),
                  ],
                ),
              ));
        },
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: 8),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openDiaryForm(context),
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF134B70),
        foregroundColor: Colors.white,
      ),
    );
  }
}
