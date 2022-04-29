import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:thespot/store/query/query_state.dart';
import 'package:thespot/store/query/query_store.dart';
import 'package:thespot/ui/colors.dart';
import 'package:thespot/ui/components/buttons.dart';
import 'package:thespot/ui/components/text_span.dart';
import 'package:thespot/ui/extensions/ui_extensions.dart';
import 'package:thespot/ui/text_style.dart';

class QueryScreen extends StatelessWidget {
  const QueryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var queryStore = context.watch<QueryStore>();
    queryStore.query();

    return Observer(
      builder: (context) {
        var state = queryStore.state;
        debugPrint('QueryScreen state => $state');
        if (state is QueryStateQueried) {
          return _ReserveQuerySeat(
            date: state.date,
            seat: state.seat,
          );
        } else if (state is QueryStateDetailed) {
          return _ReserveDetailed(
            date: state.date,
            seat: state.seat,
          );
        }
        return Container();
      },
    );
  }
}

class _ReserveQuerySeat extends StatelessWidget {
  final String date;
  final String seat;

  const _ReserveQuerySeat({Key? key, required this.date, required this.seat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _DefaultContainer(
      children: [
        RichText(
          text: TextSpan(
            text: 'Data: ',
            children: [
              TextSpan(
                text: date,
                style: TheSpotTextStyle.defaultStyle,
              )
            ],
            style: TheSpotTextStyle.defaultStyle.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: context.layoutHeight(3),
        ),
        InfinityWidthButton(
          text: 'Visualizar Reserva',
          onPressed: () => Provider.of<QueryStore>(context, listen: false).detailedReservation(),
        ),
        SizedBox(
          height: context.layoutHeight(2),
        ),
        const DeactivatedInfinityWidthButton(text: 'Reservar Lugar'),
        SizedBox(height: context.layoutHeight(3)),
        const _WhyItCantReserve(),
      ],
    );
  }
}

class _WhyItCantReserve extends StatelessWidget {
  const _WhyItCantReserve({Key? key}) : super(key: key);

  get _defaultStyle => TheSpotTextStyle.defaultStyle.copyWith(
        fontSize: 12.5,
        color: TheSpotColors.blue,
      );
  get _boldStyle => _defaultStyle.copyWith(fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'Só é possível ter',
        style: _defaultStyle,
        children: [
          TextSpan(
            text: ' uma ',
            style: _boldStyle,
          ),
          const TextSpan(text: 'reserva ativa por vez. Se desejar realizar outra reserva, clique em'),
          TextSpan(
            text: '“Visualizar Reserva”',
            style: _boldStyle,
          ),
          const TextSpan(text: ' e depois selecione '),
          TextSpan(
            text: '“Cancelar Reserva”.',
            style: _boldStyle,
          ),
        ],
      ),
    );
  }
}

class _ReserveDetailed extends StatelessWidget {
  final String date;
  final String seat;

  const _ReserveDetailed({
    Key? key,
    required this.date,
    required this.seat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _DefaultContainer(
      children: [
        DateAndSitHighlighted(
          date: date,
          seat: seat,
        ),
      ],
    );
  }
}

class _DefaultContainer extends StatelessWidget {
  final List<Widget> children;

  const _DefaultContainer({
    Key? key,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: context.layoutHeight(5)),
        Text(
          'RESERVA ATIVA',
          style: TheSpotTextStyle.title.copyWith(
            color: TheSpotColors.blue,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: context.layoutHeight(3)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.layoutWidth(12)),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}
