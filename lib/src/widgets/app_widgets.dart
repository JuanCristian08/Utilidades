import 'package:flutter/material.dart';
import 'package:utilidades/src/app/app_routes.dart';

class AppWidgets extends StatelessWidget {
  const AppWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Utilidades',
      initialRoute: '/home',
      routes: generateRoutes(),
    );  
  }
}