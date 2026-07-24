import 'package:flutter/material.dart';
import 'package:shopping_app/core/common/screens/error_404_screen.dart';
import 'package:shopping_app/core/common/widgets/app_btns.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/routing/app_routes.dart';

import 'package:shopping_app/features/onboarding/presentation/view/screen/onboarding_screen.dart';
import 'package:shopping_app/test_screen.dart';

class AppRouter {
  AppRouter._();

  static Route<dynamic>? onGenerateRoute(RouteSettings setting) {
    // final arguments = setting.arguments;
    switch (setting.name) {
      case AppRoutes.homeRoute: // final args = arguments;
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.x2),
                child: Column(
                  spacing: AppSpacing.x1,
                  mainAxisAlignment: .center,
                  crossAxisAlignment: .center,
                  children: [
                    Text(
                      "Home_screen",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    verticalSpace(AppSpacing.x4),
                    DefaultBtn(onPressed: () {}, child: Text("DefaultBtn")),
                    PrimaryBtn(onPressed: () {}, child: Text("PrimaryBtn")),
                    SecondaryBtn(onPressed: () {}, child: Text("SecondaryBtn")),
                  ],
                ),
              ),
            ),
          ),
        );
      case AppRoutes.onboardingRoute:
        return MaterialPageRoute(builder: (context) => OnboardingScreen());
      case AppRoutes.testRoute:
        return MaterialPageRoute(builder: (context) => TestScreen());

      default:
        return MaterialPageRoute(builder: (context) => Error404Screen());
    }
  }
}
