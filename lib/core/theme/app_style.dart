import 'package:flutter/material.dart';
import 'package:shopping_app/core/theme/app_colors.dart';

abstract final class AppStyles {
  static const BoxShadow defaultShadow = BoxShadow(color: Color(0x4DFF9900), offset: Offset(0, 4), blurRadius: 8);

  static const BoxShadow primaryShadow = BoxShadow(color: Color(0x59FF9900), offset: Offset(0, 4), blurRadius: 10);

  static const BoxShadow secondaryShadow = BoxShadow(color: Color(0x59FF9900), offset: Offset(0, 4), blurRadius: 6);
  static final ButtonStyle defaultStyle = ElevatedButton.styleFrom();

  static final ButtonStyle primaryStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent,
    shadowColor: Colors.transparent,
    elevation: 0,
  );

  static final ButtonStyle secondaryStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.onPrimary,
    foregroundColor: AppColors.primary,
    shadowColor: Colors.transparent,
    elevation: 0,
    side: BorderSide(color: AppColors.primary),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.5)),
  );

  static BoxDecoration primaryDecoration = BoxDecoration(
    gradient: const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [Color(0xFFFF9900), Color(0xFFFFB700)],
    ),
    borderRadius: BorderRadius.circular(8),
    boxShadow: const [AppStyles.primaryShadow],
  );

  static BoxDecoration secondaryDecoration = BoxDecoration(
    gradient: const LinearGradient(colors: [Color(0xFFFF9900), Color(0xFFFFB700)]),
    borderRadius: BorderRadius.circular(12),
    boxShadow: const [AppStyles.secondaryShadow],
  );
}
