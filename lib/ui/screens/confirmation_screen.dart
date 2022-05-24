import 'package:flutter/material.dart';
import 'package:thespot/ui/colors.dart';
import 'package:thespot/ui/components/buttons.dart';
import 'package:thespot/ui/extensions/ui_extensions.dart';
import 'package:thespot/ui/text_style.dart';

class ConfirmationScreen extends StatelessWidget {
  final String text;
  final VoidCallback onYesTap;
  final VoidCallback onNoTap;

  const ConfirmationScreen({
    Key? key,
    required this.onYesTap,
    required this.onNoTap,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        onNoTap();
        return Future.value(true);
      },
      child: Material(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(context.layoutWidth(9)),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () => onNoTap(),
                  icon: Icon(
                    Icons.close,
                    size: context.layoutWidth(9),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: TheSpotTextStyle.defaultStyle.copyWith(fontSize: 22),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DefaultSmallButton(
                        buttonColor: TheSpotColors.blue,
                        onPressed: () => onNoTap(),
                        text: 'Não',
                      ),
                      SizedBox(height: context.layoutHeight(10)),
                      DefaultSmallButton(
                        onPressed: () => onYesTap(),
                        text: 'Sim',
                        borderColor: TheSpotColors.blue,
                        textColor: TheSpotColors.blue,
                        buttonColor: Colors.white,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
