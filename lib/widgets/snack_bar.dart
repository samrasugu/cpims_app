import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      backgroundColor: Colors.deepPurple,
      behavior: SnackBarBehavior.floating,
      elevation: 2.0,
    ),
  );
}
