import 'package:thespot/data/model/has_reservation_response.dart';
import 'package:thespot/data/model/reservation_request.dart';
import 'package:thespot/data/model/reservation_response.dart';
import 'package:thespot/data/model/seats_response.dart';

abstract class IReservationProvider {
  Future<HasReservationResponse> hasReservation();
  Future<ReservationResponse> getReservation();
  Future<bool> cancel(int id);
  Future<SeatsResponse> getSeatsInNext4Days();
  Future<void> reserve(ReservationRequest request);
}
