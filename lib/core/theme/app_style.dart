import 'package:flutter/material.dart';

abstract class AppStyles {
  static const BoxShadow kOrangeShadowSmall = BoxShadow(
    color: Color(0x4DFF9900),
    offset: Offset(0, 4),
    blurRadius: 12,
    spreadRadius: 0,
  );

  static const BoxShadow kOrangeShadowMedium = BoxShadow(
    color: Color(0x59FF9900),
    offset: Offset(0, 4),
    blurRadius: 16,
    spreadRadius: 0,
  );

  static const BoxShadow kOrangeShadowLarge = BoxShadow(
    color: Color(0x59FF9900), // 35% opacity
    offset: Offset(0, 4),
    blurRadius: 12,
    spreadRadius: 0,
  );
  static BoxShadow kBlackShadowSmall = BoxShadow(
    color: Colors.black.withValues(alpha: .15),
    blurRadius: 10,
    offset: const Offset(0, 6),
  );
}
