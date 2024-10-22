import 'package:flutter/material.dart';
import 'package:breakpoint_app/routes/app_routes.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          fontFamily: 'Garamond',
          fontSize: 30,
          color: Colors.white,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Garamond',
          fontSize: 18,
          color: Colors.white
        ),
        bodySmall: TextStyle(
          fontFamily: 'Garamond',
          fontSize: 14,
          color:  Colors.white,
        )
      ),
    ),
    initialRoute: AppRoutes.WELLCOME,
    routes: AppRoutes.getRoutes(),
  ));
}