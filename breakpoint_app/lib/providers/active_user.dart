import 'package:breakpoint_app/model/User.dart';
import 'package:flutter/material.dart';

class ActiveUser with ChangeNotifier{
  static final ActiveUser _instance = ActiveUser._internal();
  
  String? _currentUser;

  String? get currentUser => _currentUser;

  ActiveUser._internal();

  factory ActiveUser() {
    return _instance;
  }

  void setCurrentUser(String user){
    _currentUser = user;
  }

  void clear() {
    _currentUser = null;
  }

  bool get isLoggedIn => _currentUser != null;
}
