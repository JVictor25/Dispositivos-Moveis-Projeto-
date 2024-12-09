import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:breakpoint_app/model/Vice.dart';

class ViceService {
  final String _baseUrl = "https://breakpoint.onrender.com";

  Future<List<Vice>> fetchVices(String _bearerToken) async {
    try {
      final response = await http.get(
        Uri.parse("$_baseUrl/user/vice/"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer $_bearerToken',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((entry) => Vice.fromJson(entry)).toList();
      } else {
        throw Exception("Failed to load vices");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addVice(Vice vice, String _bearerToken) async {
    try {
      final response = await http.post(
        Uri.parse("$_baseUrl/user/vice/"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer $_bearerToken',
        },
        body: json.encode(vice.toJson()),
      );
      if (response.statusCode != 200) {
        throw Exception("Failed to add vice");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeVice(Vice vice, String _bearerToken) async {
    try {
      final response = await http.delete(
        Uri.parse("$_baseUrl/user/vice/${vice.id}"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer $_bearerToken',
        },
      );
      if (response.statusCode != 200) {
        throw Exception("Failed to remove vice");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateVice(Vice vice, String _bearerToken) async {
    try {
      final deleteResponse = await http.delete(
        Uri.parse("$_baseUrl/user/vice/${vice.id}"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer $_bearerToken',
        },
      );

      if (deleteResponse.statusCode != 200) {
        throw Exception("Failed to update vice");
      }

      final createResponse = await http.post(
        Uri.parse("$_baseUrl/user/vice/"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer $_bearerToken',
        },
        body: json.encode(vice.toJson()),
      );

      if (createResponse.statusCode != 200) {
        throw Exception("Failed to updated vice");
      }
    } catch (e) {
      print("Error updating vice by delete and create: $e");
      rethrow;
    }
  }
}
