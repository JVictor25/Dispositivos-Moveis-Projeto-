import 'package:breakpoint_app/screens/LoginScreen.dart';
import 'package:breakpoint_app/screens/RegisterScreen.dart';
import 'package:flutter/material.dart';
import 'package:breakpoint_app/screens/Wellcome.dart';

class AppRoutes {
  static const WELLCOME = 'wellcome';
  static const LOGINSCREEN = 'login';
  static const REGISTERSCREEN = 'register';

  static Map<String, WidgetBuilder> getRoutes(){
    return{
      WELLCOME: (context) => const Wellcome(),
      LOGINSCREEN: (context) => const Loginscreen(),
      REGISTERSCREEN: (context) => const Registerscreen(),
    };
  }
}