import 'package:flutter/material.dart';
import 'package:thespot/ui/text_style.dart';

class DateAndSitHighlighted extends StatelessWidget {
  final String date;
  final String seat;

  const DateAndSitHighlighted({
    Key? key,
    required this.date,
    required this.seat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: '\u2022 Data: ',
            children: [
              TextSpan(
                text: date,
                style: TheSpotTextStyle.defaultStyle,
              )
            ],
            style: TheSpotTextStyle.defaultStyle.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 5),
        RichText(
          text: TextSpan(
            text: '\u2022 Assento: ',
            children: [
              TextSpan(
                text: seat,
                style: TheSpotTextStyle.defaultStyle,
              )
            ],
            style: TheSpotTextStyle.defaultStyle.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
