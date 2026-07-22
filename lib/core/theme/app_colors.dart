import 'package:flutter/material.dart';

abstract final class AppColors {
  AppColors._();

  static const primary = Color(0xFFFF9800);
  static const primaryLight = Color(0xFFFFB700);
  static const primaryDark = Color(0xFFC97A00);
  static const background = Color(0xFFFAFAFA);
  static const surface = Colors.white;
  static const heading = Color(0xFF1E1B32);
  static const body = Color(0xFF5F6368);
  static const border = Color(0xFFE9ECEF);
  static const divider = Color(0xFFF1F3F5);
  static const disabled = Color(0xFFECEEF2);

  static const success = Color(0xFF22C55E);
  static const warning = Color(0xFFFFB700);
  static const error = Color(0xFFFF5A5F);
  static const info = Color(0xFF3B82F6);

  static const onPrimary = Colors.white;
  static const onSurface = heading;
}