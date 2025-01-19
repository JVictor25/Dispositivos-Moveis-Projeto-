import 'dart:io';

import 'package:breakpoint_app/model/DiaryEntry.dart';
import 'package:breakpoint_app/providers/active_user.dart';
import 'package:breakpoint_app/providers/diary_service.dart';
import 'package:flutter/material.dart';

// (NOTE): Lembrar de remover o mockData depois 
final List<DiaryEntry> mockData = [
  DiaryEntry(
    title: "Diário de Bordo",
    createdAt: DateTime(2025, 1, 1),
    emotion: "Feliz",
    text: "Hoje foi um dia muito bom!",
    image: "https://i.pinimg.com/236x/80/16/7f/80167f524231208fe63cfaabc2579852.jpg"
  ),
  DiaryEntry(
    title: "Diário de Bordo",
    createdAt: DateTime(2025, 1, 1),
    emotion: "Triste",
    text: "Hoje foi um dia muito ruim!",
    image: "https://maladeaventuras.com/wp-content/uploads/2018/12/DSC7078.jpg"
  ),
  DiaryEntry(
    title: "Diário de Bordo",
    createdAt: DateTime(2024, 12, 1),
    emotion: "Raiva",
    text: "Hoje foi um dia muito irritante!",
  ),
  DiaryEntry(
    title: "Diário de Bordo",
    createdAt: DateTime(2021, 1, 1),
    emotion: "Ansioso",
    text: "Hoje foi um dia muito estressante!",
  ),
];

class DiaryProvider with ChangeNotifier {
  DiaryService _diaryService = DiaryService();
  ActiveUser _activeUser = ActiveUser();
  final List<DiaryEntry> _diaryEntries = [];
  bool _isLoading = false;

  List<DiaryEntry> get diaryEntries => _diaryEntries.reversed.toList();
  bool get isLoading => _isLoading;

  Future<void> fetchEntries() async {
    final bearerToken = _activeUser.currentUser;
    _isLoading = true;
    try {
      final entries = await _diaryService.fetchDiaryEntries(bearerToken!);
      print(entries);
      _diaryEntries.clear();
      // (NOTE): Lembrar de remover o mockData depois
      _diaryEntries.addAll(entries + mockData);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
      _isLoading = false;
    }
  }

  Future<void> addEntry(DiaryEntry diaryEntry) async {
    final bearerToken = _activeUser.currentUser;
    _isLoading = true;
    notifyListeners();
    try {
      await _diaryService.addDiaryEntry(diaryEntry, bearerToken!);
      _diaryEntries.add(diaryEntry);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> removeEntry(DiaryEntry diaryEntry) async {
    final bearerToken = _activeUser.currentUser;
    _isLoading = true;
    notifyListeners();
    try {
      await _diaryService.removeDiaryEntry(diaryEntry, bearerToken!);
      _diaryEntries.remove(diaryEntry);
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
      _isLoading = false;
      notifyListeners();
    }
  }
}