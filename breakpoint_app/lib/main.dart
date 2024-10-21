import 'package:flutter/material.dart';
import 'package:breakpoint_app/routes/app_routes.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          fontFamily: 'Garamond',
          fontSize: 30,
          color: Color(0xFF37474F),
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Garamond',
          fontSize: 18,
          color: Color(0xFF37474F)
        ),
        bodySmall: TextStyle(
          fontFamily: 'Garamond',
          fontSize: 14,
          color:  Color(0xFF37474F),
        )
      ),
    ),
    initialRoute: AppRoutes.WELLCOME,
    routes: AppRoutes.getRoutes(),
  ));
}