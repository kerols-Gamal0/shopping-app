import 'package:flutter/material.dart';

abstract class AppSpacing {
  AppSpacing._();

  static const double x1 = 8.0;
  static const double x2 = 16.0;
  static const double x3 = 24.0;
  static const double x4 = 32.0;
  static const double x5 = 40.0;
  static const double x6 = 48.0;

  /// Horizontal Padding
  static const EdgeInsets horizontalX2 =
  EdgeInsets.symmetric(horizontal: x2);

  /// All Padding
  static const EdgeInsets allX2 =
  EdgeInsets.all(x2);

  /// Horizontal & Vertical Padding
  static const EdgeInsets horizontalVerticalX2 =
  EdgeInsets.symmetric(horizontal: x2, vertical: x1);
}

SizedBox verticalSpace(double height) => SizedBox(height: height);

SizedBox horizontalSpace(double width) => SizedBox(width: width);