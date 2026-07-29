import 'package:flutter/material.dart';

class CartThemeColors extends ThemeExtension<CartThemeColors> {
  const CartThemeColors({
    required this.screenBackground,
    required this.summaryBackground,
    required this.dividerColor,
  });

  final Color screenBackground;
  final Color summaryBackground;
  final Color dividerColor;

  @override
  CartThemeColors copyWith({
    Color? screenBackground,
    Color? summaryBackground,
    Color? dividerColor,
  }) {
    return CartThemeColors(
      screenBackground: screenBackground ?? this.screenBackground,
      summaryBackground: summaryBackground ?? this.summaryBackground,
      dividerColor: dividerColor ?? this.dividerColor,
    );
  }

  @override
  CartThemeColors lerp(ThemeExtension<CartThemeColors>? other, double t) {
    if (other is! CartThemeColors) {
      return this;
    }

    return CartThemeColors(
      screenBackground: Color.lerp(
        screenBackground,
        other.screenBackground,
        t,
      )!,
      summaryBackground: Color.lerp(
        summaryBackground,
        other.summaryBackground,
        t,
      )!,
      dividerColor: Color.lerp(dividerColor, other.dividerColor, t)!,
    );
  }
}
