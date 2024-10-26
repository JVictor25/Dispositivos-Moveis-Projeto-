import 'package:breakpoint_app/model/User.dart';
import 'package:breakpoint_app/screens/home_screen.dart';
import 'package:breakpoint_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:breakpoint_app/screens/wellcome_screen.dart';

class AppRoutes {
  static const WELLCOME = 'wellcome';
  static const LOGINSCREEN = 'login';
  static const HOMESCREEN = 'home';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case WELLCOME:
        return MaterialPageRoute(builder: (context) => const Wellcome());

      case LOGINSCREEN:
        return MaterialPageRoute(builder: (context) => const Loginscreen());

      case HOMESCREEN:
        // Verifique se o argumento é uma instância da classe `User`
        if (settings.arguments is User) {
          final user = settings.arguments as User;
          return MaterialPageRoute(
            builder: (context) => Homescreen(activeUser: user),
          );
        }
        return _errorRoute();

      default:
        return _errorRoute();
    }
  }

    static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(title: Text('Erro')),
        body: Center(child: Text('Rota não encontrada ou argumentos inválidos!')),
      ),
    );
  }

}