import 'package:flutter/cupertino.dart';
import 'package:thespot/ui/colors.dart';

class TheSpotTextStyle {
  TheSpotTextStyle._();

  static TextStyle get title => TheSpotTextStyle.defaultStyle
      .copyWith(fontSize: 20, color: TheSpotColors.blue);

  static TextStyle get defaultStyle => const TextStyle(
        color: TheSpotColors.lightGray,
        fontSize: 19,
        decoration: TextDecoration.none,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.normal,
      );
}
