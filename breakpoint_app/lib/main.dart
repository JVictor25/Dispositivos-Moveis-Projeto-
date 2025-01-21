// ignore_for_file: prefer_const_constructors
import 'package:breakpoint_app/components/notification.dart';
import 'package:breakpoint_app/providers/active_user.dart';
import 'package:breakpoint_app/providers/diary_provider.dart';
import 'package:breakpoint_app/providers/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Importa o pacote Provider
import 'package:breakpoint_app/routes/app_routes.dart';
import 'package:breakpoint_app/providers/vice_provider.dart'; // O provider para gerenciar os vícios

import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyDHeYOcxcAxHeV7dLhtDQ5Xxy5MMhb9Too",
    appId: '1:686694015678:android:734d58510bf8f917b5f4ef',
    messagingSenderId: '686694015678',
    projectId: 'breakpoint-4a869',
    storageBucket: 'breakpoint-4a869.firebasestorage.app',
  ));

  final firebaseApi = FirebaseApi();
  await firebaseApi.initNotification();

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
