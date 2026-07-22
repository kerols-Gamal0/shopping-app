import 'package:flutter/material.dart';
import 'package:shopping_app/core/common/screens/error_404_screen.dart';
import 'package:shopping_app/core/routing/app_routes.dart';

class AppRouter {
  AppRouter._();

  static Route<dynamic>? onGenerateRoute(RouteSettings setting) {
    // final arguments = setting.arguments;
    switch (setting.name) {
      case AppRoutes.homeRoute: // final args = arguments;
        return MaterialPageRoute(
          builder: (context) => Error404Screen(),
          // Scaffold(body: Center(child: Text("Home_screen"))),
        );

      default:
        return MaterialPageRoute(builder: (context) => Error404Screen());
    }
  }
}
