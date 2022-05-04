import 'package:flutter/material.dart';
import 'package:thespot/ui/colors.dart';
import 'package:thespot/ui/extensions/ui_extensions.dart';

class DeactivatedInfinityWidthButton extends StatelessWidget {
  final String text;

  const DeactivatedInfinityWidthButton({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InfinityWidthButton(
      onPressed: null,
      text: text,
      buttonColor: TheSpotColors.veryLightGray,
      textColor: TheSpotColors.darkGray,
    );
  }
}

class InfinityWidthButton extends StatelessWidget {
  final Color? buttonColor;
  final String text;
  final Color textColor;
  final VoidCallback? onPressed;

  const InfinityWidthButton({
    Key? key,
    this.buttonColor = const Color(0xFF4470E1),
    required this.text,
    this.textColor = Colors.white,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TheSpotButton(
      onPressed: onPressed,
      text: text,
      buttonColor: buttonColor,
      textColor: textColor,
      height: context.layoutWidth(13),
      width: double.infinity,
    );
  }
}

class DefaultLargeButton extends StatelessWidget {
  final Color? buttonColor;
  final String text;
  final Color textColor;
  final VoidCallback? onPressed;

  const DefaultLargeButton({
    Key? key,
    this.buttonColor = const Color(0xFF4470E1),
    required this.text,
    this.textColor = Colors.white,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TheSpotButton(
      height: context.layoutWidth(13),
      width: context.layoutWidth(70),
      text: text,
      buttonColor: buttonColor,
      textColor: textColor,
      onPressed: onPressed,
    );
  }
}

class DefaultSmallButton extends StatelessWidget {
  final Color? buttonColor;
  final String text;
  final Color? textColor;
  final VoidCallback? onPressed;
  final Color? borderColor;

  const DefaultSmallButton({
    Key? key,
    this.buttonColor,
    required this.text,
    this.borderColor,
    this.textColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TheSpotButton(
      height: context.layoutWidth(11),
      width: context.layoutWidth(35),
      onPressed: onPressed,
      text: text,
      borderColor: borderColor,
      buttonColor: buttonColor,
      textColor: textColor,
      fontSize: 12,
    );
  }
}

class TheSpotButton extends StatelessWidget {
  final Color? buttonColor;
  final String text;
  final Color? textColor;
  final VoidCallback? onPressed;
  final double height;
  final double width;
  final Color? borderColor;
  final double? fontSize;

  const TheSpotButton({
    Key? key,
    this.buttonColor = TheSpotColors.blue,
    required this.text,
    this.borderColor,
    this.textColor = Colors.white,
    required this.onPressed,
    required this.height,
    required this.width,
    this.fontSize = 15,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed != null ? () => onPressed!() : null,
        style: ElevatedButton.styleFrom(
          primary: buttonColor,
          side: BorderSide(
            width: 2,
            color: borderColor ?? Colors.transparent,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
