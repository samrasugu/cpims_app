import 'package:flutter/widgets.dart';

SizedBox mediumVerticalSizedBox = const SizedBox(
  height: 20,
);

SizedBox size70VerticalSizedBox = const SizedBox(height: 70);

String capitalizeFirstLetter(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1);
}