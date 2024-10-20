import 'package:flutter/material.dart';
import 'package:breakpoint_app/routes/app_routes.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: AppRoutes.WELLCOME,
    routes: AppRoutes.getRoutes(),
  ));
}