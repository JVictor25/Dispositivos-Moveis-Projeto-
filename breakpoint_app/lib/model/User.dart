import 'package:breakpoint_app/model/DiaryEntry.dart';
import 'package:breakpoint_app/model/Vice.dart';
import 'package:flutter/material.dart';

class User with ChangeNotifier{
  User({required this.username, required this.email, required this.password});

  String username;
  String email;
  String password;
}