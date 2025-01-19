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

    if (response.statusCode != 200) {
      throw Exception("Failed to load vices");
    }


    final List<dynamic> data = json.decode(response.body);
    final basicVices = data.map((entry) => Vice.fromJson(entry)).toList();

    final List<Vice> completeVices = [];
    for (final vice in basicVices) {
      final detailResponse = await http.get(
        Uri.parse("$_baseUrl/user/vice/${vice.id}"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer $_bearerToken',
        },
      );

      if (detailResponse.statusCode == 200) {
        final detailData = json.decode(detailResponse.body);
        completeVices.add(Vice.fromJson(detailData));
      } else {
        throw Exception("Failed to load details for vice with ID: ${vice.id}");
      }
    }

    return completeVices;
  } catch (e) {
    print("Erro ao buscar vices completos: $e");
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
        body: json.encode(vice.toJsonAdd()),
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

  Future<void> updateVice(Map<String, dynamic> vice, String _bearerToken) async {
    try {
      final response = await http.put(
        Uri.parse("$_baseUrl/user/vice/${vice['id']}/update"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer $_bearerToken',
        },
        body: json.encode(vice),
      );
      if (response.statusCode != 200) {
        throw Exception("Failed to updated vice");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> resetViceTime(String id, String _bearerToken)async {
    try {
      final response = await http.put(
        Uri.parse("$_baseUrl/user/vice/${id}/reset"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer $_bearerToken',
        },
      );
      if (response.statusCode != 200) {
        throw Exception("Failed to updated vice");
      }
    } catch (e) {
      rethrow;
    }
  }
}
