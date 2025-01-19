// ignore_for_file: prefer_const_constructors
import 'package:breakpoint_app/providers/active_user.dart';
import 'package:breakpoint_app/providers/diary_provider.dart';
import 'package:breakpoint_app/providers/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Importa o pacote Provider
import 'package:breakpoint_app/routes/app_routes.dart';
import 'package:breakpoint_app/providers/vice_provider.dart'; // O provider para gerenciar os vícios

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ViceProvider(),
        ),
        ChangeNotifierProvider(create: (context) => ActiveUser()),
        ChangeNotifierProvider(create: (context) => UserService()),
        ChangeNotifierProvider(create: (context) => DiaryProvider())
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
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
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
            fontFamily: 'PoppinsRegular',
            fontSize: 14,
            color: Color(0xffF3F3E0),
          ),
          titleSmall: TextStyle(
              fontFamily: 'PoppinsLight',
              fontSize: 14,
              color: Color(0xFF134B70)),
          bodySmall: TextStyle(
              fontFamily: 'PoppinsLight',
              fontSize: 14,
              color: Color(0xFF134B70)),
        ),
      ),
      initialRoute: AppRoutes.WELLCOME,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
