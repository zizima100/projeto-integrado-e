import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:thespot/store/reserve/reserve_state.dart';
import 'package:thespot/store/reserve/reserve_store.dart';
import 'package:thespot/ui/colors.dart';
import 'package:thespot/ui/components/buttons.dart';
import 'package:thespot/ui/extensions/ui_extensions.dart';
import 'package:thespot/ui/text_style.dart';

class ReserveScreen extends StatelessWidget {
  const ReserveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        var state = context.watch<ReserveStore>().state;
        debugPrint('ReserveScreen state => $state');
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (state is ReserveStateInitial) const _StartReservationWidget(),
            if (state is ReserveStateChooseDateAndSeat)
              const _ChooseDateAndSeatWidget(),
            if (state is ReserveStateConfirmation)
              _ConfirmReservationWidget(date: state.date, seat: state.seat),
            if (state is ReserveStateSuccess) const _SuccessReservationWidget(),
          ],
        );
      },
    );
  }
}

class _StartReservationWidget extends StatelessWidget {
  const _StartReservationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _ReservationDefaultContainer(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Você ainda não reservou nenhum lugar. Deseja reservar?',
            textAlign: TextAlign.center,
            style: TheSpotTextStyle.title,
          ),
          SizedBox(height: context.layoutHeight(6.5)),
          SvgPicture.asset('assets/girl_seated.svg'),
        ],
      ),
      buttonStyle: _ButtonStyle(text: 'Reservar Lugar'),
      onButtonTap: () =>
          Provider.of<ReserveStore>(context, listen: false).start(),
    );
  }
}

class _ChooseDateAndSeatWidget extends StatelessWidget {
  const _ChooseDateAndSeatWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _ReservationBackButtonContainer(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(),
        ],
      ),
      buttonStyle: _ButtonStyle(text: 'Reservar Lugar'),
      onButtonTap: () =>
          Provider.of<ReserveStore>(context, listen: false).chooseSeat(),
      backButtonText: 'Selecione uma data e um lugar',
    );
  }
}

class _ConfirmReservationWidget extends StatelessWidget {
  final String date;
  final String seat;

  const _ConfirmReservationWidget(
      {Key? key, required this.date, required this.seat})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _ReservationBackButtonContainer(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
              style: TheSpotTextStyle.defaultStyle
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          RichText(
            text: TextSpan(
              text: '\u2022 Assento: ',
              children: [
                TextSpan(
                  text: seat,
                  style: TheSpotTextStyle.defaultStyle,
                )
              ],
              style: TheSpotTextStyle.defaultStyle
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      buttonStyle:
          _ButtonStyle(text: 'Confirmar Reserva', color: TheSpotColors.green),
      onButtonTap: () =>
          Provider.of<ReserveStore>(context, listen: false).confirm(),
      backButtonText: 'Confirme sua reserva',
    );
  }
}

class _SuccessReservationWidget extends StatelessWidget {
  const _SuccessReservationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _ReservationDefaultContainer(
      buttonStyle: _ButtonStyle(text: 'OK'),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Reserva feita com sucesso!',
            style: TheSpotTextStyle.defaultStyle.copyWith(
              fontSize: 20,
              color: TheSpotColors.green,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: context.layoutHeight(3)),
          Text(
            'Te enviamos um email com todas as informações para você não esquecer.',
            style: TheSpotTextStyle.defaultStyle,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: context.layoutHeight(5)),
          SvgPicture.asset('assets/email_sent.svg'),
        ],
      ),
      onButtonTap: () {},
    );
  }
}

class _ReservationBackButtonContainer extends StatelessWidget {
  final Widget content;
  final String backButtonText;
  final _ButtonStyle buttonStyle;
  final VoidCallback onButtonTap;

  const _ReservationBackButtonContainer({
    Key? key,
    required this.content,
    required this.buttonStyle,
    required this.onButtonTap,
    required this.backButtonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _ReservationDefaultContainer(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: context.layoutHeight(2.5),
          ),
          _BackButtonText(
            text: backButtonText,
            onButtonTap: () =>
                Provider.of<ReserveStore>(context, listen: false).backState(),
          ),
          Expanded(child: content)
        ],
      ),
      buttonStyle: buttonStyle,
      onButtonTap: onButtonTap,
    );
  }
}

class _ReservationDefaultContainer extends StatelessWidget {
  final Widget content;
  final _ButtonStyle buttonStyle;
  final VoidCallback onButtonTap;

  const _ReservationDefaultContainer({
    Key? key,
    required this.content,
    required this.buttonStyle,
    required this.onButtonTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: context.layoutWidth(5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(child: content),
            Padding(
              padding: EdgeInsets.only(bottom: context.layoutHeight(10)),
              child: LargeButton(
                onPressed: () => onButtonTap(),
                text: buttonStyle.text,
                buttonColor: buttonStyle.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackButtonText extends StatelessWidget {
  final String text;
  final VoidCallback onButtonTap;

  const _BackButtonText({
    Key? key,
    required this.text,
    required this.onButtonTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double _iconSize = 10;

    return Row(
      children: [
        Material(
          child: SizedBox(
            height: context.layoutWidth(_iconSize),
            width: context.layoutWidth(_iconSize),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: context.layoutWidth(9),
                color: TheSpotColors.blue,
              ),
              onPressed: () => onButtonTap(),
              padding: EdgeInsets.zero,
            ),
          ),
        ),
        Flexible(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.layoutWidth(18)),
            child: Text(
              text,
              style: TheSpotTextStyle.title,
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }
}

class _ButtonStyle {
  final Color? color;
  final String text;

  _ButtonStyle({this.color, required this.text});
}
