import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopping_app/core/common/screens/under_maintenance_screen.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/core/storage_helper/shared_pref.dart';
import 'package:shopping_app/features/onboarding/repo/repo/onboarding_repo_interface.dart';
import 'package:shopping_app/shopping_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  ErrorWidget.builder = (FlutterErrorDetails details) =>
      UnderMaintenanceScreen();
  ErrorWidget.builder = (FlutterErrorDetails details) =>
      UnderMaintenanceScreen();
  await SharedPref.init();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]).then((_) => runApp(const ShoppingApp()));
  print(getIt.isRegistered<OnboardingRepoInterface>());
}
