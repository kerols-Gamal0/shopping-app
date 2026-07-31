import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AuthFooter extends StatelessWidget {
  const AuthFooter({
    super.key,
    required this.text,
    required this.actionText,
    required this.onPressed,
  });

  final String text;
  final String actionText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.only(bottom: 16),
      child: Center(
        child: RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xff6E6A7C),
            ),
            children: [
              TextSpan(text: text),
              TextSpan(
                text: actionText,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xff212121),
                  fontWeight: FontWeight.w600,
                ),
                recognizer: TapGestureRecognizer()..onTap = onPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}