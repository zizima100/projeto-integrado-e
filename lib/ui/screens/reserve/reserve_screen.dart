import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:thespot/store/reserve/reserve_state.dart';
import 'package:thespot/store/reserve/reserve_store.dart';
import 'package:thespot/ui/components/buttons.dart';
import 'package:thespot/ui/extensions/ui_extensions.dart';

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
              const _ConfirmReservationWidget(),
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
            style: _DefaultTextStyle.title,
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
    return _ReservationDefaultContainer(
      content: Text('Escolher data e lugar'),
      buttonStyle: _ButtonStyle(text: 'Reservar Lugar'),
      onButtonTap: () =>
          Provider.of<ReserveStore>(context, listen: false).chooseSeat(),
    );
  }
}

class _ConfirmReservationWidget extends StatefulWidget {
  const _ConfirmReservationWidget({Key? key}) : super(key: key);

  @override
  State<_ConfirmReservationWidget> createState() =>
      _ConfirmReservationWidgetState();
}

class _ConfirmReservationWidgetState extends State<_ConfirmReservationWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _SuccessReservationWidget extends StatelessWidget {
  const _SuccessReservationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
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

class _DefaultTextStyle {
  static get title => const TextStyle(
      fontSize: 20,
      color: Color(0xff4470E1),
      decoration: TextDecoration.none,
      fontFamily: 'Roboto');
}

class _ButtonStyle {
  final Color? color;
  final String text;

  _ButtonStyle({this.color, required this.text});
}
