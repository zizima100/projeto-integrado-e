import 'package:flutter/material.dart';
import 'package:thespot/ui/extensions/ui_extensions.dart';

class LargeButton extends StatelessWidget {
  final Color? buttonColor;
  final String text;
  final Color textColor;
  final VoidCallback onPressed;

  const LargeButton({
    Key? key,
    this.buttonColor = const Color(0xFF4470E1),
    required this.text,
    this.textColor = Colors.white,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      style: ElevatedButton.styleFrom(
        primary: buttonColor,
        padding: EdgeInsets.symmetric(
          horizontal: context.layoutWidth(22),
          vertical: context.layoutWidth(4),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 15,
        ),
      ),
    );
  }
}
