import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:breakpoint_app/model/User.dart';
import 'package:uuid/uuid.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class UserService with ChangeNotifier {
  final String _baseUrl = "https://breakpoint.onrender.com";
  final String _bearerToken =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJCcmVha3BvaW50IiwiZXhwIjoxNzMzNTMwMTMyLCJzdWIiOiI2OTUxMjBiMi0yZWVmLTRmYjUtODVjZi0zNmRjYTE2MjI3MWMifQ.f0WJKa6Ak8od0KGUtsA5chslzdqskQwy8fCUs9jQuWc";

  Map<String, String> get _headers => {
        "Content-Type": "application/json",
        "Authorization": 'Bearer $_bearerToken',
      };

  Future<void> addUser(User user) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/user/'),
        headers: _headers,
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Error creating user: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error in addUser: $e');
      rethrow;
    }
  }

  Future<void> updateUser(User updatedUser) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/user/${updatedUser.id}'),
        headers: _headers,
        body: jsonEncode(updatedUser.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Error updating user: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error in updateUser: $e');
      rethrow;
    }
  }

  /*Future<User> fetchUser(String tokenJWT) async {
    try {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(tokenJWT);
      String? userId = decodedToken['sub'];

      final response = await http.get(
        Uri.parse('$_baseUrl/user/$userId'),
        headers: _headers
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return User.fromJson(data['id'], data);
      } else {
        throw Exception('Error fetching user: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error in fetchUser: $e');
      rethrow;
    }
  }
  */
  
  Future<void> deleteUser(String userId) async {
    try {
      final response = await http.delete(
        Uri.parse('$_baseUrl/user/$userId'),
        headers: _headers,
      );

      if (response.statusCode != 200) {
        throw Exception('Error deleting user: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error in deleteUser: $e');
      rethrow;
    }
  }

  // Save or update user data
  Future<void> saveUserData(Map<String, dynamic> data) async {
    bool hasId = data['id'] != null;
    final user = User(
      id: data['id'] ?? Uuid().v4(),
      username: data['username'] as String,
      email: data['email'] as String,
      password: data['password'] as String,
    );

    if (hasId) {
      await updateUser(user);
    } else {
      await addUser(user);
    }
  }

  // User login
  Future<String?> loginUser(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/auth/user'),
        headers: _headers,
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return response.body;
      } else {
        final error = jsonDecode(response.body);
        throw Exception('Error authenticating user: ${error['message']}');
      }
    } catch (e) {
      debugPrint('Error in loginUser: $e');
      return null;
    }
  }
}
