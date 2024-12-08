import 'dart:convert';

import 'package:breakpoint_app/model/DiaryEntry.dart';
import 'package:http/http.dart' as http;

class DiaryService {
  final String _baseUrl = "https://breakpoint.onrender.com";

  Future<List<DiaryEntry>> fetchDiaryEntries(String token) async {
    try {
      final response = await http.get(
        Uri.parse("$_baseUrl/user/diary/"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((entry) => DiaryEntry.fromJson(entry)).toList();
      } else {
        throw Exception("Failed to load diary entries");
      } 
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addDiaryEntry(DiaryEntry diaryEntry, String token) async {
    try {
      final response = await http.post(
        Uri.parse("$_baseUrl/user/diary/"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer $token',
        },
        body: json.encode(diaryEntry.toJson()),
      );
      if (response.statusCode != 200) {
        throw Exception("Failed to add diary entry");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeDiaryEntry(DiaryEntry diaryEntry, String token) async {
    try {
      final response = await http.delete(
        Uri.parse("$_baseUrl/user/diary/${diaryEntry.id}"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer $token',
        },
      );
      if (response.statusCode != 200) {
        throw Exception("Failed to remove diary entry");
      }
    } catch (e) {
      rethrow;
    }
  }
}