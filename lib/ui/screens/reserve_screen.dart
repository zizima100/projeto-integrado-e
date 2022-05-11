import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:thespot/data/model/seat.dart';
import 'package:thespot/data/provider/constants.dart';
import 'package:thespot/store/reserve/reserve_state.dart';
import 'package:thespot/store/reserve/reserve_store.dart';
import 'package:thespot/ui/colors.dart';
import 'package:thespot/ui/components/buttons.dart';
import 'package:thespot/ui/components/seats_widget.dart';
import 'package:thespot/ui/components/text_span.dart';
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
              _ChooseDateAndSeatWidget(
                seats: state.seats,
              ),
            if (state is ReserveStateConfirmation)
              _ConfirmReservationWidget(
                date: state.date,
                seat: state.seat,
                seats: state.seats,
              ),
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
      onButtonTap: () => Provider.of<ReserveStore>(context, listen: false).start(),
    );
  }
}

class _ChooseDateAndSeatWidget extends StatelessWidget {
  final List<Seat> seats;
  const _ChooseDateAndSeatWidget({
    Key? key,
    required this.seats,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _ReservationBackButtonContainer(
      content: Column(
        children: [
          SizedBox(height: context.layoutHeight(3)),
          const Flexible(
            flex: 1,
            child: _ChooseDateWidget(),
          ),
          SizedBox(height: context.layoutHeight(1.5)),
          Flexible(
            flex: 5,
            child: SeatsWidget(interactive: true, seats: seats),
          ),
        ],
      ),
      buttonStyle: _ButtonStyle(text: 'Reservar Lugar'),
      onButtonTap: () => Provider.of<ReserveStore>(context, listen: false).chooseSeat(),
      backButtonText: 'Selecione uma data e um lugar',
    );
  }
}

class _ChooseDateWidget extends StatelessWidget {
  const _ChooseDateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        Constants.NUMBER_OF_CHOOSEN_DAYS,
        (dayIndex) => Observer(
          builder: (context) {
            var state = context.watch<ReserveStore>().state;
            var isSelected = false;
            if (state is ReserveStateChooseDateAndSeat) {
              isSelected = state.dayIndex == dayIndex;
            }
            return TheSpotButton(
              text: DateFormat(Constants.DD_MM).format(DateTime.now().add(
                Duration(days: dayIndex),
              )),
              height: context.layoutWidth(12),
              width: context.layoutWidth(18),
              onPressed: () {
                Provider.of<ReserveStore>(context, listen: false).onDayTap(dayIndex);
              },
              textColor: isSelected ? Colors.white : Colors.black,
              buttonColor: isSelected ? TheSpotColors.blue : TheSpotColors.veryLightGray,
              fontSize: 13,
            );
          },
        ),
      ),
    );
  }
}

class _ConfirmReservationWidget extends StatelessWidget {
  final String date;
  final String seat;
  final List<Seat> seats;

  const _ConfirmReservationWidget({
    Key? key,
    required this.date,
    required this.seat,
    required this.seats,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _ReservationBackButtonContainer(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: context.layoutHeight(2.5)),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: DateAndSitHighlighted(date: date, seat: seat),
          ),
          SizedBox(height: context.layoutHeight(2)),
          Flexible(
            flex: 4,
            child: SeatsWidget(interactive: false, seats: seats),
          ),
        ],
      ),
      buttonStyle: _ButtonStyle(text: 'Confirmar Reserva', color: TheSpotColors.green),
      onButtonTap: () => Provider.of<ReserveStore>(context, listen: false).confirm(),
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
            onButtonTap: () => Provider.of<ReserveStore>(
              context,
              listen: false,
            ).backState(),
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
              padding: EdgeInsets.only(bottom: context.layoutHeight(5)),
              child: DefaultLargeButton(
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
