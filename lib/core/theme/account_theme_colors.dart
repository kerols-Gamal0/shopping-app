import 'package:flutter/material.dart';

class AccountThemeColors extends ThemeExtension<AccountThemeColors> {
  const AccountThemeColors({
    required this.screenBackground,
    required this.cardBackground,
    required this.borderColor,
  });

  final Color screenBackground;
  final Color cardBackground;
  final Color borderColor;

  @override
  AccountThemeColors copyWith({
    Color? screenBackground,
    Color? cardBackground,
    Color? borderColor,
  }) {
    return AccountThemeColors(
      screenBackground: screenBackground ?? this.screenBackground,
      cardBackground: cardBackground ?? this.cardBackground,
      borderColor: borderColor ?? this.borderColor,
    );
  }

  @override
  AccountThemeColors lerp(ThemeExtension<AccountThemeColors>? other, double t) {
    if (other is! AccountThemeColors) {
      return this;
    }

    return AccountThemeColors(
      screenBackground: Color.lerp(
        screenBackground,
        other.screenBackground,
        t,
      )!,
      cardBackground: Color.lerp(cardBackground, other.cardBackground, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
    );
  }
}
