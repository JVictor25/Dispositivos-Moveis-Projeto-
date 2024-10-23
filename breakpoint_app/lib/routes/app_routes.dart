import 'package:breakpoint_app/screens/home_screen.dart';
import 'package:breakpoint_app/screens/login_screen.dart';
import 'package:breakpoint_app/widgets/register_user.dart';
import 'package:flutter/material.dart';
import 'package:breakpoint_app/screens/wellcome_screen.dart';

class AppRoutes {
  static const WELLCOME = 'wellcome';
  static const LOGINSCREEN = 'login';
  static const HOMESCREEN = 'home';

  static Map<String, WidgetBuilder> getRoutes(){
    return{
      WELLCOME: (context) => const Wellcome(),
      LOGINSCREEN: (context) => const Loginscreen(),
      HOMESCREEN: (context) => const Homescreen(),
    };
  }
}