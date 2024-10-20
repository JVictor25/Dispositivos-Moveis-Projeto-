import 'package:breakpoint_app/screens/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:breakpoint_app/screens/Wellcome.dart';

class AppRoutes {
  static const WELLCOME = 'wellcome';
  static const LOGINSCREEN = 'login';

  static Map<String, WidgetBuilder> getRoutes(){
    return{
      WELLCOME: (context) => Wellcome(),
      LOGINSCREEN: (context) => Loginscreen(),
    };
  }
}