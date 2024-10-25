import 'package:flutter/material.dart';
import 'package:breakpoint_app/routes/app_routes.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 24,
          color: Color(0xFF3A1078),
        ),
        titleLarge: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 30,
          color: Colors.white,
        ),
        labelLarge: TextStyle(
          fontFamily: 'sans-serif',
          fontSize: 18,
          color: Colors.black
        ),
        labelMedium: TextStyle(
          fontFamily: 'sans-serif',
          fontSize: 14,
          color: Colors.white,
        ),
        labelSmall: TextStyle(
          fontFamily: 'sans-serif',
          fontSize: 10,
          color: Colors.grey
        ),
        displayMedium: TextStyle(
          fontFamily: 'Garamond',
          fontSize: 18,
          color: Colors.white,
        ), 
        displaySmall: TextStyle(
          fontFamily: 'sans-serif',
          fontSize: 14,
          color: Colors.black,
        ), 
      ),
    ),
    initialRoute: AppRoutes.HOMESCREEN,
    routes: AppRoutes.getRoutes(),
  ));
}