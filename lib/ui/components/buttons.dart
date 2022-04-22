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
    return SizedBox(
      height: context.layoutWidth(13),
      width: context.layoutWidth(70),
      child: ElevatedButton(
        onPressed: () => onPressed(),
        style: ElevatedButton.styleFrom(primary: buttonColor),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
