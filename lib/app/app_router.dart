import 'package:flutter/material.dart';
import 'package:listastic/home/home_page.dart';
import 'package:listastic/login/view/login_page.dart';
import 'package:listastic/shoppinglist_details/view/shoppinglist_details_page.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => HomePage(),
        );

      case '/login':
        return MaterialPageRoute(
          builder: (_) => LoginPage(),
        );

      case 'shoppinglist-details':
        final shoppinglistId = args as String;

        return MaterialPageRoute(builder: (context) {
          return ShoppinglistDetailsPage(
            shoppinglistId: shoppinglistId,
          );
        });

      default:
        return MaterialPageRoute(
          builder: (_) => LoginPage(),
        );
    }
  }
}
