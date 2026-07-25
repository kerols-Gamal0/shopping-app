import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/app_strings.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/core/routing/app_router.dart';
import 'package:shopping_app/core/routing/app_routes.dart';
import 'package:shopping_app/core/theme/app_theme.dart';
import 'package:shopping_app/features/onboarding/domain/repo/onboarding_repo_interface.dart';

class ShoppingApp extends StatelessWidget {
  const ShoppingApp({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = serviceLocator<OnboardingRepoInterface>();

    return MaterialApp(
      title: AppStrings.appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      themeAnimationDuration: Duration.zero,
      themeAnimationCurve: Curves.linear,
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: repo.isOnboardingSeen()
          ? AppRoutes.appSection
          : AppRoutes.onboardingRoute,
    );
  }
}
