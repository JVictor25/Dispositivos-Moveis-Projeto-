// ignore_for_file: prefer_const_constructors

import 'package:breakpoint_app/data/data.dart';
import 'package:breakpoint_app/model/DiaryEntry.dart';
import 'package:breakpoint_app/providers/diary_provider.dart';
import 'package:breakpoint_app/widgets/date_picker.dart';
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
    "Feliz": const Color.fromRGBO(255, 199, 55, 0.5),
    "Triste": const Color.fromRGBO(55, 175, 255, 0.5),
    "Raiva": const Color.fromRGBO(255, 41, 41, 0.5),
    "Ansioso": const Color.fromRGBO(242, 107, 15, 0.5),
    "Cansado": const Color.fromRGBO(75, 89, 69, 0.5),
  };

  final List<String> monthsInYear = [
    'Jan',
    'Fev',
    'Mar',
    'Abr',
    'Mai',
    'Jun',
    'Jul',
    'Ago',
    'Set',
    'Out',
    'Nov',
    'Dez'
  ];

  List<String> get months {
    int currentMonth = DateTime.now().month;
    List<String> months =
        monthsInYear.sublist(12 - currentMonth, monthsInYear.length);
    return months;
  }

  int selectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;

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

  Map<String, List<DiaryEntry>> groupEntriesByDate(List<DiaryEntry> entries) {
    Map<String, List<DiaryEntry>> groupedEntries = {};
    entries.forEach((entry) {
      final date = DateFormat('dd/MM/yyyy').format(entry.createdAt);
      if (groupedEntries.containsKey(date)) {
        groupedEntries[date]!.add(entry);
      } else {
        groupedEntries[date] = [entry];
      }
    });
    return groupedEntries;
  }

  List<DiaryEntry> getEntriesInSelectedMonth(
      List<DiaryEntry> entries, int selectedMonth, int selectedYear) {
    return entries.where((entry) {
      return entry.createdAt.month == selectedMonth &&
          entry.createdAt.year == selectedYear;
    }).toList();
  }

  Future<void> _openDatePickerDialog() {
    return showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Escolha a data"),
          content: MonthPicker(
            onDateSelected: (month, year) {
              setState(() {
                selectedMonth = month;
                selectedYear = year;
              });
            },
            endYear: 2025, 
            initialYear: 2025, 
            startYear: 2015, 
            month: 1,) 
        );
      }
    );
  }

  @override
  void initState() {
    super.initState();
    Provider.of<DiaryProvider>(context, listen: false).fetchEntries();
  }

  Widget _buildEntryCard(DiaryEntry entry) {
    // final entry = entries[index];
    final color = emotionColors[entry.emotion] ??
        const Color.fromARGB(150, 148, 148, 148);
    final emoji = emotionEmojis[entry.emotion] ?? "👤";
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
                      color: Color.fromRGBO(255, 255, 255, 0.801),
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
                  IconButton(
                    icon: Icon(
                      Icons.delete_outline,
                      color: Color.fromRGBO(255, 255, 255, 0.8),
                    ),
                    onPressed: () => _openConfirmationModel(entry),
                  ),
                ],
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.text,
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(30, 30, 30, 1),
                        ),
                      ),
                      SizedBox(height: 8),
                      if (entry.image != null) // Remover
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(entry.image!),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            DateFormat('HH:mm').format(entry.createdAt),
                            style: TextStyle(
                              fontSize: 12,
                              color: Color.fromRGBO(30, 30, 30, 1),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // SizedBox(
        //   height: 50,
        //   child: ListView.builder(
        //     scrollDirection: Axis.horizontal,
        //     itemCount: months.length,
        //     itemBuilder: (context, index) {
        //       final isSelected = index + 1 == selectedMonth;
        //       return Padding(
        //         padding: const EdgeInsets.symmetric(horizontal: 4),
        //         child: ChoiceChip(
        //             label: Text(
        //               months[index],
        //               style: TextStyle(
        //                 color: isSelected ? Colors.white : Color(0xFF134B70),
        //               ),
        //             ),
        //             selected: isSelected,
        //             onSelected: (selected) {
        //               setState(() {
        //                 selectedMonth = index + 1; // Atualiza o mês selecionado
        //               });
        //             },
        //             selectedColor: Color(0xFF134B70),
        //             backgroundColor: Color.fromARGB(96, 19, 75, 112)),
        //       );
        //     },
        //   ),
        // ),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${monthsInYear[selectedMonth - 1]} ${selectedYear}', 
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22
                ),
              ),
            ),
            IconButton(
              onPressed: _openDatePickerDialog, 
              icon: Icon(Icons.calendar_month, color: Colors.black87))
          ],
        ),
        Consumer<DiaryProvider>(builder: (context, diaryProvider, child) {
          if (diaryProvider.isLoading) {
            return Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          // final selected = months.length - (selectedMonth - 1);
          final entriesInSelectedMonth =
              getEntriesInSelectedMonth(diaryProvider.diaryEntries, selectedMonth, selectedYear);
          final groupedEntries = groupEntriesByDate(entriesInSelectedMonth);
          final List<String> dates = groupedEntries.keys.toList();
          return (entriesInSelectedMonth.isEmpty
              ? Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/empty-diary.png',
                            width: 150),
                        Text(
                          'Nenhum registro encontrado para este mês',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                )
              : Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: dates.length,
                    itemBuilder: (BuildContext context, int index) {
                      final date = dates[index];
                      final entries = groupedEntries[date]!;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                Icon(Icons.circle, size: 8, color: Colors.grey),
                                SizedBox(width: 8),
                                Text(
                                  date,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          ...entries
                              .map((entry) => _buildEntryCard(entry))
                              .toList(),
                        ],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 8),
                  ),
                ));
        }),
      ],
    );
  }
}
