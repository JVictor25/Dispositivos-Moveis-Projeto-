import 'package:flutter/cupertino.dart';

class User with ChangeNotifier {
  final String? _id;
  String _username;
  String _email;
  String _password;
  final DateTime? _createdAt;
  DateTime? _updatedAt;

  String get id => _id ?? ''; // Garantir que o id nunca seja nulo.
  String get username => _username;
  set username(String value) => _username = value;

  String get email => _email;
  set email(String value) => _email = value;

  String get password => _password;
  set password(String value) => _password = value;

  User({
    String? id,
    required String username,
    required String email,
    required String password,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : _id = id,
        _username = username,
        _email = email,
        _password = password,
        _createdAt = createdAt,
        _updatedAt = updatedAt;

  User.fromUser(User _user)
      : _id = _user._id,
        _username = _user._username,
        _email = _user._email,
        _password = _user._password,
        _createdAt = _user._createdAt,
        _updatedAt = _user._updatedAt;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': _id,
      'username': _username,
      'email': _email,
      'password': _password,
      'createdAt': _createdAt?.toIso8601String(),
      'updatedAt': _updatedAt?.toIso8601String(),
    };
    return data;
  }
}
