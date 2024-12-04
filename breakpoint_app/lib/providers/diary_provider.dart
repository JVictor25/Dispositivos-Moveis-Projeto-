
import 'package:breakpoint_app/model/DiaryEntry.dart';
import 'package:flutter/material.dart';

List<DiaryEntry> mockData = [
    DiaryEntry(
      title: "Primeiro dia de trabalho",
      text: "Hoje foi meu primeiro dia no novo emprego. Tudo correu bem!",
      emotion: "Feliz",
      createdAt: DateTime(2024, 12, 1, 10, 30),
    ),
    DiaryEntry(
      title: "Treino intenso",
      text: "O treino de hoje foi muito puxado, mas consegui superar meus limites.",
      emotion: "Triste",
      createdAt: DateTime(2024, 12, 2, 18, 15),
    ),
    DiaryEntry(
      title: "Caminhada na praia",
      text: "Caminhei pela praia ao entardecer. A vista era deslumbrante.",
      emotion: "Ansioso",
      createdAt: DateTime(2024, 12, 3, 17, 45),
    ),
    DiaryEntry(
      title: "Dia cansativo",
      text: "Hoje tive muitas reuniões, me sinto exausto.",
      emotion: "Raiva",
      createdAt: DateTime(2024, 12, 4, 20, 0),
    ),
    DiaryEntry(
      title: "Jantar com amigos",
      text: "Jantei com amigos antigos e foi ótimo relembrar velhas histórias.",
      emotion: "Cansado",
      createdAt: DateTime(2024, 12, 5, 21, 30),
    ),
  ];

class DiaryProvider with ChangeNotifier {
  final List<DiaryEntry> _diaryEntries = mockData;

  List<DiaryEntry> get diaryEntries => List.unmodifiable(_diaryEntries);

  void addEntry(DiaryEntry diaryEntry) {
    _diaryEntries.add(diaryEntry);
    notifyListeners();
  }

  void removeEntry(DiaryEntry diaryEntry) {
    _diaryEntries.remove(diaryEntry);
    notifyListeners();
  }
}