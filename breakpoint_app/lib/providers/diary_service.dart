import 'dart:convert';

import 'package:breakpoint_app/model/DiaryEntry.dart';
import 'package:http/http.dart' as http;

class DiaryService {
  final String _baseUrl = "https://breakpoint.onrender.com";
  final String _bearerToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJCcmVha3BvaW50IiwiZXhwIjoxNzMzNTMwMTMyLCJzdWIiOiI2OTUxMjBiMi0yZWVmLTRmYjUtODVjZi0zNmRjYTE2MjI3MWMifQ.f0WJKa6Ak8od0KGUtsA5chslzdqskQwy8fCUs9jQuWc";

  Map<String, String> get _headers => {
    "Content-Type": "application/json",
    "Authorization": 'Bearer $_bearerToken',
  };

  Future<List<DiaryEntry>> fetchDiaryEntries() async {
    try {
      final response = await http.get(
        Uri.parse("$_baseUrl/user/diary/"),
        headers: _headers,
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

  Future<void> addDiaryEntry(DiaryEntry diaryEntry) async {
    try {
      final response = await http.post(
        Uri.parse("$_baseUrl/user/diary/"),
        headers: _headers,
        body: json.encode(diaryEntry.toJson()),
      );
      if (response.statusCode != 200) {
        throw Exception("Failed to add diary entry");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeDiaryEntry(DiaryEntry diaryEntry) async {
    try {
      final response = await http.delete(
        Uri.parse("$_baseUrl/user/diary/${diaryEntry.id}"),
        headers: _headers,
      );
      if (response.statusCode != 200) {
        throw Exception("Failed to remove diary entry");
      }
    } catch (e) {
      rethrow;
    }
  }
}