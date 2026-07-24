import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});
  static const String routeName = '/test';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Test Screen')));
  }
}
