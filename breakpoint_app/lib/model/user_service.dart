import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:breakpoint_app/model/User.dart';

class UserService with ChangeNotifier {
  final String baseUrl = "";

  Future<void> addUser(User user) async {
    try {
      final response = await http.post(Uri.parse('$baseUrl/users.json'),
          body: jsonEncode(user.toJson()));

      if (response.statusCode != 200) {
        throw Exception('Erro ao criar usuário: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Atualizar um usuário existente
  Future<void> updateUser(User updatedUser) async {
    try {
      final response = await http.patch(
          Uri.parse('$baseUrl/users/${updatedUser.id}.json'),
          body: jsonEncode(updatedUser.toJson()));

      if (response.statusCode != 200) {
        throw Exception('Erro ao atualizar usuário: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<User> getUserById(String userId, String idToken) async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/users/$userId.json?auth=$idToken'));

      if (response.statusCode == 200) {
        final data = User.fromJson(userId, jsonDecode(response.body));
        print('Usuário encontrado: $data');
        return data;
      } else {
        throw Exception('Erro ao obter usuário: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Deletar um usuário
  Future<void> deleteUser(User user) async {
    try {
      final response =
          await http.delete(Uri.parse('$baseUrl/users/${user.id}.json'));

      if (response.statusCode != 200) {
        throw Exception('Erro ao deletar usuário: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> saveUserData(Map<String, Object> data) async {
    bool hasId = data['id'] != null;
    final user = User(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      username: data['username'] as String,
      email: data['email'] as String,
      password: data['password'] as String,
    );

    if (hasId) {
      return updateUser(user);
    } else {
      return addUser(user);
    }
  }

  /*Future<String?> loginUser(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/user.json'),
        body: jsonEncode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("Usuário autenticado com sucesso!");
        return data['id'];
      } else {
        throw Exception("Erro ao autenticar usuário: ${response.body}");
      }
    } catch (e) {
      rethrow;
    }
  }*/
}
