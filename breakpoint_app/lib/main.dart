// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Importa o pacote Provider
import 'package:breakpoint_app/routes/app_routes.dart';
import 'package:breakpoint_app/providers/vice_provider.dart'; // O provider para gerenciar os vícios

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ViceProvider(), // Gerencia o estado dos vícios
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        navigationBarTheme: NavigationBarThemeData(
          labelTextStyle: WidgetStateProperty.all(
            TextStyle(fontSize: 14),
          ),
        ),
        textTheme: const TextTheme(
          titleMedium: TextStyle(
            fontFamily: 'PoppinsBlack',
            fontSize: 20,
            color: Color(0xff133E87),
          ),
          labelLarge: TextStyle(
              fontFamily: 'PoppinsLight',
              fontSize: 18,
              color: Color(0xff133E87),
              fontWeight: FontWeight.bold),
          labelMedium: TextStyle(
            fontFamily: 'PoppinsLight',
            fontSize: 13,
            color: Color(0xffF3F3E0),
          ),
          titleSmall: TextStyle(
              fontFamily: 'PoppinsLight', fontSize: 14, color: Color(0xFF134B70)),
          bodySmall: TextStyle(
              fontFamily: 'PoppinsLight', fontSize: 14, color: Color(0xFF134B70)),
        ),
      ),
      initialRoute: AppRoutes.WELLCOME,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
