import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key, 
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        hintText: 'Search for your products',
      ),
      onChanged: onChanged,
    );
  }
}