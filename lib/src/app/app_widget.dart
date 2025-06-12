import 'package:flutter/material.dart';
import 'package:utilidades/src/app/app_routes.dart';
import 'package:utilidades/src/services/auth_services.dart';
import 'package:utilidades/src/views/login_view.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Utilidades",
      initialRoute: AuthServices.isLogged ? "/Home" : "/login",
      routes: {
        "/login": (context) => LoginView(),
        ...generateRoutes(),
      },
    );
  }
}
