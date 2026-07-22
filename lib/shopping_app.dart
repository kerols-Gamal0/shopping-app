import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/app_strings.dart';
import 'package:shopping_app/core/routing/app_router.dart';
import 'package:shopping_app/core/routing/app_routes.dart';

class ShoppingApp extends StatelessWidget {
  const ShoppingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: AppStrings.appFontFamily, primaryColor: Color(0xffFF9900)),
      themeAnimationDuration: Duration.zero,
      themeAnimationCurve: Curves.linear,
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: AppRoutes.homeRoute,
    );
  }
}
