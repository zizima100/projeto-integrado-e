import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:thespot/store/query/query_state.dart';
import 'package:thespot/store/query/query_store.dart';
import 'package:thespot/ui/colors.dart';
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'RESERVA ATIVA',
          style: TheSpotTextStyle.title.copyWith(
            color: TheSpotColors.blue,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: context.layoutHeight(5),
        ),
        Text(
          'Data: $date',
          style: TheSpotTextStyle.defaultStyle,
        ),
        SizedBox(
          height: context.layoutHeight(3),
        ),
        Text(
          'Assento: $seat',
          style: TheSpotTextStyle.defaultStyle,
        ),
      ],
    );
  }
}
