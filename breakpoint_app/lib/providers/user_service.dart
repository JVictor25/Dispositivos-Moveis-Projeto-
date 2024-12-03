import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:breakpoint_app/providers/active_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:breakpoint_app/model/User.dart';
import 'package:provider/provider.dart';

class UserService with ChangeNotifier {
  final String baseUrl =
      "https://breakpoint-testes-default-rtdb.firebaseio.com/";

  Future<void> addUser(User user) async {
    try {
      registerAuthList(user.email, user.password);

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

  Future<User> fetchUser(String authToken) async {
    late User getUser;
    try{
      final response = await http.get(Uri.parse('$baseUrl/users.json?auth=$authToken'));
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);

        data.forEach((userId, userData) {
          User user = User.fromJson(userId, userData);
          getUser = user;
        });
        return getUser;
      }else{
        throw Exception("Erro ao acessar dados do usuário: ${response.body}");
      }
    }catch(e){
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

  Future<void> registerAuthList(String email, String password) async {
    final apiKey = "AIzaSyDZzyGnC-bH0AdJEqJ2_71qK49uenLIn7M";
    final url =
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$apiKey";

    try {
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        print("Usuário registrado com sucesso no Firebase Authentication!");
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(
            "Erro ao registrar usuário: ${errorData['error']['message']}");
      }
    } catch (e) {
      print("Erro de requisição: $e");
      return null;
    }
  }

  Future<Map<String, String>?> loginUser(Map<String, Object> formData) async {
    final apiKey = "AIzaSyDZzyGnC-bH0AdJEqJ2_71qK49uenLIn7M";
    final url =
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$apiKey";

    try {
      final email = formData['email'] as String;
      final password = formData['password'] as String;

      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        final uid = data['localId'];
        final token = data['idToken'];

        print("UID: $uid");
        print("ID Token: $token");
        return {
          'idToken': token,
          'uid': uid,
        };
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(
            "Erro ao autenticar usuário: ${errorData['error']['message']}");
      }
    } catch (e) {
      print("Erro de requisição: $e");
      return null;
    }
  }
}
