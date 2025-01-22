import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:breakpoint_app/model/User.dart';
import 'package:uuid/uuid.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

class UserService with ChangeNotifier {
  final String _baseUrl = "https://breakpoint.onrender.com";
  final String _bearerToken =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJCcmVha3BvaW50IiwiZXhwIjoxNzMzNTMwMTMyLCJzdWIiOiI2OTUxMjBiMi0yZWVmLTRmYjUtODVjZi0zNmRjYTE2MjI3MWMifQ.f0WJKa6Ak8od0KGUtsA5chslzdqskQwy8fCUs9jQuWc";
  final _auth = LocalAuthentication();
  final _secureStorage = FlutterSecureStorage();

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
      print(response.statusCode);
      if (response.statusCode != 200) {
        throw Exception('Error creating user: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error in addUser: $e');
      rethrow;
    }
  }

  Future<void> updateUser(Map<String, dynamic> user, String tokenJWT) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/user/'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer $tokenJWT',
        },
        body: jsonEncode(user),
      );

      if (response.statusCode != 200) {
        throw Exception('Error updating user: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchUser(String tokenJWT) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/user/'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer $tokenJWT',
        },
      );

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          final data = jsonDecode(response.body) as Map<String, dynamic>;

          if (data.containsKey('name') &&
              data.containsKey('email') &&
              data.containsKey('createdAt')) {
            return data;
          } else {
            throw Exception('Missing required fields in response');
          }
        } else {
          throw Exception('Response body is empty');
        }
      } else {
        throw Exception('Error fetching user: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error in fetchUser: $e');
      rethrow;
    }
  }

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
    final user = User(
      username: data['username'] as String,
      email: data['email'] as String,
      password: data['password'] as String,
    );

    await addUser(user);
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
        await _secureStorage.write(key: 'email', value: email);
        await _secureStorage.write(key: 'password', value: password);
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

  Future<String?> loginWithBiometrics() async {
    try {
      final isAvailable = await _auth.canCheckBiometrics;
      if (!isAvailable) {
        print('Biometria não está disponível.');
        throw Exception('Biometria não está disponível.');
      }

      final authenticated = await _auth.authenticate(
        localizedReason: 'Use sua biometria para fazer login',
        options: const AuthenticationOptions(
          stickyAuth: true,
          useErrorDialogs: true,
        ),
      );
      print('Authenticated: $authenticated');

      if (authenticated) {
        final email = await _secureStorage.read(key: 'email');
        final password = await _secureStorage.read(key: 'password');
        if (email == null || password == null) {
          throw Exception('Credenciais não encontradas.');
        }

        final token = await loginUser(email, password);
        if (token != null) {
          print('Token obtido: $token');
          return token;
        } else {
          throw Exception('Falha ao autenticar com biometria.');
        }
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }
}
