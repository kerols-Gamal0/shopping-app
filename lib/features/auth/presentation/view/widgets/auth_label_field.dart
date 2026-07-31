import 'package:flutter/material.dart';

class AuthLabelField extends StatefulWidget {
  const AuthLabelField({
    super.key,
    required this.title,
    required this.controller,
    required this.hintText,
    required this.validator,
    required this.keyboardType,
    required this.textInputAction,
    this.obscureText = false,
  });

  final String title;
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?) validator;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool obscureText;

  @override
  State<AuthLabelField> createState() => _AuthLabelFieldState();
}

class _AuthLabelFieldState extends State<AuthLabelField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle(title: widget.title),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          obscureText: _obscureText,
          decoration: InputDecoration(
            hintText: widget.hintText,
            suffixIcon: widget.obscureText
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: Icon(_obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500));
  }
}
