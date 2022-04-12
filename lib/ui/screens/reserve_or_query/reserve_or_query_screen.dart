import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:thespot/data/model/reservation_response.dart';
import 'package:thespot/data/provider/reservation/reservation_provider.dart';
import 'package:thespot/store/reserve_or_query/reserve_or_query_state.dart';
import 'package:thespot/store/reserve_or_query/reserve_or_query_store.dart';

class ReserveOrQueryScreen extends StatelessWidget {
  const ReserveOrQueryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO replace message with actual widgets
    return Observer(builder: (_) {
      var state = context.watch<ReserveOrQueryStore>().state;
      var message = '';
      if (state is ReserveOrQueryQuerying) {
        message = 'Consulta';
      } else if (state is ReserveOrQueryReserving) {
        message = 'Reserva';
      }
      return FutureBuilder(
          future: ReservationProvider().getReservation(),
          builder: (context, snapshot) {
            return Stack(
              children: [
                Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          message,
                          style: const TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.white,
                          ),
                        ),
                        if (snapshot.connectionState == ConnectionState.done)
                          Text(
                            snapshot.data.toString(),
                            style: const TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                if (state is ReserveOrQueryLoading || snapshot.connectionState == ConnectionState.waiting)
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: LinearProgressIndicator(),
                  )
              ],
            );
          });
    });
  }
}
