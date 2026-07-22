import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopping_app/core/common/screens/under_maintenance_screen.dart';
import 'package:shopping_app/shopping_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ErrorWidget.builder = (FlutterErrorDetails details) => UnderMaintenanceScreen();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]).then((_) => runApp(const ShoppingApp()));
}
