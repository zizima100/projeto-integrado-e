import 'dart:math';

import 'package:thespot/data/model/has_reservation_response.dart';
import 'package:thespot/data/model/reservation.dart';
import 'package:thespot/data/model/reservation_response.dart';
import 'package:thespot/data/model/seat.dart';
import 'package:thespot/data/provider/constants.dart';
import 'package:thespot/data/provider/reservation/reservation_provider_interface.dart';
import 'package:thespot/repository/reservation/reservation_repository_interface.dart';

class ReservationRepository implements IReservationRepository {
  final IReservationProvider provider;

  const ReservationRepository({
    required this.provider,
  });

  @override
  Future<bool> hasReservation() async {
    HasReservationResponse hasReservationResponse =
        await provider.hasReservation();
    return hasReservationResponse.hasReservation;
  }

  @override
  Future<Reservation> getReservation() async {
    ReservationResponse response = await provider.getReservation();
    return Reservation.fromResponse(response);
  }

  @override
  Future<bool> cancel(int id) async {
    return await provider.cancel(id);
  }

  @override
  Future<List<Seat>> getSeatsInNext4Days() {
    return Future.value(List.generate(
      Constants.NUMBER_OF_SEATS,
      (index) => Seat(
        id: index,
        status: index < 10 ? SeatStatus.available : SeatStatus.unavailable,
      ),
    ));
  }
}
