import 'package:flutter/material.dart';

class ConfirmationScreenArguments {
  final String text;
  final VoidCallback onYesTap;
  final VoidCallback onNoTap;

  const ConfirmationScreenArguments({
    Key? key,
    required this.onYesTap,
    required this.onNoTap,
    required this.text,
  });

  @override
  String toString() => 'ConfirmationScreenArguments(text: $text, onYesTap: $onYesTap, onNoTap: $onNoTap)';
}
