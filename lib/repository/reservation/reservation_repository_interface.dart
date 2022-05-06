import 'package:thespot/data/model/reservation.dart';
import 'package:thespot/data/model/seat.dart';
import 'package:thespot/data/model/seats_response.dart';

abstract class IReservationRepository {
  Future<bool> hasReservation();
  Future<Reservation> getReservation();
  Future<bool> cancel(int id);
  Future<List<Seat>> getSeatsInNext4Days();
}
