import 'package:flutter/material.dart';
import 'package:breakpoint_app/routes/app_routes.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      textTheme: const TextTheme(
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
    initialRoute: AppRoutes.WELLCOME,
    routes: AppRoutes.getRoutes(),
  ));
}