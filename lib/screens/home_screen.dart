import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.accessToken,
  });
  final String accessToken;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Column()),
    );
  }
}
