import 'package:flutter/material.dart';
import 'package:breakpoint_app/routes/app_routes.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
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
          fontWeight: FontWeight.bold
        ),
        labelMedium: TextStyle(
          fontFamily: 'PoppinsLight',
          fontSize: 13,
          color: Color(0xffF3F3E0),
        ), 
        titleSmall: TextStyle(
          fontFamily: 'PoppinsLight',
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
    initialRoute: AppRoutes.WELLCOME,
    onGenerateRoute: AppRoutes.onGenerateRoute,
  ));
}