import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class User with ChangeNotifier {
  final String _id;
  String _username;
  String _email;
  String _password;

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
  })   : _id = id,
        _username = username,
        _email = email,
        _password = password;

  User.fromUser(User _user)
      : _id = _user._id,
        _username = _user._username,
        _email = _user._email,
        _password = _user._password;

  factory User.fromJson(String id, Map<String, dynamic> json) {
    return User(
        id: id,
        username: json['name'],
        email: json['email'],
        password: json['password']);
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