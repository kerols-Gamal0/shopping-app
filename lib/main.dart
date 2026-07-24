import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/common/screens/under_maintenance_screen.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/core/storage_helper/shared_pref.dart';
import 'package:shopping_app/core/utils/app_bloc_observer.dart';
import 'package:shopping_app/features/onboarding/repo/repo/onboarding_repo_interface.dart';
import 'package:shopping_app/shopping_app.dart';

void main() async {
  // Todo: split at util-fun -> 
  WidgetsFlutterBinding.ensureInitialized();
  ErrorWidget.builder = (FlutterErrorDetails details) => UnderMaintenanceScreen();
  await SharedPref.init();
  await configureDependencies();
  Bloc.observer = AppBlocObserver();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]).then((_) => runApp(const ShoppingApp()));
  print(serviceLocator.isRegistered<OnboardingRepoInterface>());
}
