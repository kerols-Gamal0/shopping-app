import 'package:flutter/material.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_style.dart';

class _AppButton extends StatelessWidget {
  const _AppButton({required this.onPressed, required this.child, required this.shadow});

  final VoidCallback? onPressed;
  final Widget child;
  final BoxShadow shadow;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(boxShadow: [shadow]),
      child: ElevatedButton(onPressed: onPressed, child: child),
    );
  }
}

class DefaultBtn extends StatelessWidget {
  const DefaultBtn({super.key, required this.onPressed, required this.child});

  final VoidCallback? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _AppButton(onPressed: onPressed, shadow: AppStyles.kOrangeShadowSmall, child: child);
  }
}

class PrimaryBtn extends StatelessWidget {
  const PrimaryBtn({super.key, required this.onPressed, required this.child});

  final VoidCallback? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: const LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [Color(0xFFFF9900), Color(0xFFFFB700)]),
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [AppStyles.kOrangeShadowMedium],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent, elevation: 0),
        child: child,
      ),
    );
  }
}

class SecondaryBtn extends StatelessWidget {
  const SecondaryBtn({super.key, required this.onPressed, required this.child});

  final VoidCallback? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(boxShadow: [AppStyles.kOrangeShadowLarge]),
      child: OutlinedButton(
        style: ElevatedButton.styleFrom(backgroundColor: AppColors.divider, shadowColor: Colors.transparent, elevation: 0),
        onPressed: onPressed,
        child: child,
      ),
    );

    // _AppButton(onPressed: onPressed, shadow: AppStyles.kOrangeShadowLarge, child: child);
  }
}
