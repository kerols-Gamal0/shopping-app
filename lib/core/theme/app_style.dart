import 'package:flutter/material.dart';

abstract class AppStyles {
  static const BoxShadow kOrangeShadowSmall = BoxShadow(color: Color(0x4DFF9900), offset: Offset(0, 4), blurRadius: 12, spreadRadius: 0);

  static const BoxShadow kOrangeShadowMedium = BoxShadow(color: Color(0x59FF9900), offset: Offset(0, 4), blurRadius: 16, spreadRadius: 0);

  static const BoxShadow kOrangeShadowLarge = BoxShadow(
    color: Color(0x59FF9900), // 35% opacity
    offset: Offset(0, 4),
    blurRadius: 12,
    spreadRadius: 0,
  );
}
