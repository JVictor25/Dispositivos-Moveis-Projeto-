import 'dart:io';

import 'package:breakpoint_app/model/DiaryEntry.dart';
import 'package:breakpoint_app/providers/diary_service.dart';
import 'package:flutter/material.dart';

class DiaryProvider with ChangeNotifier {
  DiaryService _diaryService = DiaryService();
  final List<DiaryEntry> _diaryEntries = [];
  bool _isLoading = false;

  //List<DiaryEntry> get diaryEntries => List.unmodifiable(_diaryEntries);

  List<DiaryEntry> get diaryEntries => _diaryEntries;
  bool get isLoading => _isLoading;

  Future<void> fetchEntries() async {
    try {
      final entries = await _diaryService.fetchDiaryEntries();
      _diaryEntries.clear();
      _diaryEntries.addAll(entries);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> addEntry(DiaryEntry diaryEntry) async {
    try {
      await _diaryService.addDiaryEntry(diaryEntry);
      _diaryEntries.add(diaryEntry);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> removeEntry(DiaryEntry diaryEntry) async {
    try {
      await _diaryService.removeDiaryEntry(diaryEntry);
      _diaryEntries.remove(diaryEntry);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}