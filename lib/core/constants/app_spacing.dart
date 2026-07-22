import 'package:flutter/material.dart';

abstract class AppSpacing {
  AppSpacing._();
  static double x1 = 8.0;
  static double x2 = 16.0;
  static double x3 = 24.0;
  static double x4 = 32.0;
  static double x5 = 40.0;
  static double x6 = 48.0;

}

SizedBox verticalSpace(double height) => SizedBox(height: height);
SizedBox horizontalSpace(double width) => SizedBox(width: width);
