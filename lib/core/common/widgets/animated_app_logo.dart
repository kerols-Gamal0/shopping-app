import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/app_assets.dart';

class AnimatedAppLogo extends StatefulWidget {
  const AnimatedAppLogo({
    super.key,
    this.height = 120,
    this.duration = const Duration(seconds: 2),
    this.curve = Curves.easeOutBack,
  });

  final double height;
  final Duration duration;
  final Curve curve;

  @override
  State<AnimatedAppLogo> createState() => _AnimatedAppLogoState();
}

class _AnimatedAppLogoState extends State<AnimatedAppLogo> {
  double _rightPosition = -200;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _rightPosition = MediaQuery.of(context).size.width / 2 - widget.height / 2;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: widget.duration,
          curve: widget.curve,
          right: _rightPosition,
          top: 0,
          child: Image.asset(AppAssets.appIcon, height: widget.height, fit: BoxFit.contain),
        ),
      ],
    );
  }
}
