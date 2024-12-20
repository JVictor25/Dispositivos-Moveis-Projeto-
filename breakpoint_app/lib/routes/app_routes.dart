import 'package:breakpoint_app/model/Vice.dart';
import 'package:breakpoint_app/screens/home_screen.dart';
import 'package:breakpoint_app/screens/login_screen.dart';
import 'package:breakpoint_app/screens/vice_detail.dart';
import 'package:flutter/material.dart';
import 'package:breakpoint_app/screens/wellcome_screen.dart';
import 'package:breakpoint_app/widgets/vice_form.dart';

class AppRoutes {
  static const WELLCOME = 'wellcome';
  static const LOGINSCREEN = 'login';
  static const HOMESCREEN = 'home';
  static const VICEDETAIL = 'vicedetail';
  static const VICEFORM = 'viceform'; // Adiciona a nova rota

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case WELLCOME:
        return MaterialPageRoute(builder: (context) => const Wellcome());

      case LOGINSCREEN:
        return MaterialPageRoute(builder: (context) => const Loginscreen());

      case HOMESCREEN:
        return MaterialPageRoute(builder: (context) => Homescreen());

      case VICEDETAIL:
        final Vice vice = settings.arguments as Vice;
        return MaterialPageRoute(
          builder: (context) => ViceDetail(vice: vice),
        );

      case VICEFORM:
        final Vice? args = settings.arguments as Vice?;

        return MaterialPageRoute(
          builder: (context) => ViceForm(
            existingVice: args,
          ),
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(title: const Text('Erro')),
        body: const Center(
            child: Text('Rota não encontrada ou argumentos inválidos!')),
      ),
    );
  }
}
