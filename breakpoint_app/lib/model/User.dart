import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class User with ChangeNotifier {
  final String _id;
  String _username;
  String _email;
  String _password;
  final DateTime _createdAt;
  DateTime _updatedAt;
  

  String get id => _id;

  String get username => _username;

  set username(String value) {
    _username = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  User({
    required String id,
    required String username,
    required String email,
    required String password,
    required DateTime createdAt,
    DateTime? updatedAt,
  })  : _id = id,
        _username = username,
        _email = email,
        _password = password, // Define valor padrão para password se for null
        _createdAt = createdAt,
        _updatedAt = updatedAt ?? DateTime.now(); // Define valor padrão para updatedAt

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
    username: json['name'],
    email: json['email'],
    createdAt: DateTime.parse(json['createdAt']),
    updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    password: json['password'],
  );
}


  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = {
      'name': _username,
      'email' : _email,
      'password' : _password,
    };
    
    return data;
  }
}