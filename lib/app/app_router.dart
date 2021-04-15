import 'package:flutter/material.dart';
import 'package:listastic/home/home.dart';
import 'package:listastic/login/login.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    // final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => HomePage(),
        );

      case '/login':
        return MaterialPageRoute(
          builder: (_) => LoginPage(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => LoginPage(),
        );
    }
  }
}
