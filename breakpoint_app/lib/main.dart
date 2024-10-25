import 'package:flutter/material.dart';
import 'package:breakpoint_app/routes/app_routes.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontFamily: 'PoppinsBlack',
          fontSize: 24,
          color: Color(0xFF3A1078),
        ),
        titleLarge: TextStyle(
          fontFamily: 'PoppinsBlack',
          fontSize: 30,
          color: Color(0xffF3F3E0),
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
          color: Color(0xffF3F3E0),
        ), 
        displaySmall: TextStyle(
          fontFamily: 'sans-serif',
          fontSize: 14,
          color: Colors.black,
        ),
        titleSmall: TextStyle(
          fontFamily: 'PoppinsBlack',
          fontSize: 14,
          color: Color(0xFF134B70)
        ),
        bodySmall: TextStyle(
          fontFamily: 'PoppinsLight',
          fontSize: 14,
          color: Color(0xFF134B70)
        ),
      ),
    ),
    initialRoute: AppRoutes.HOMESCREEN,
    routes: AppRoutes.getRoutes(),
  ));
}