import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType keyboardType;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: theme.textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
        prefixIcon: Icon(icon, color: colorScheme.primary),
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.35),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colorScheme.outlineVariant, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
        ),
      ),
    );
  }
}
