import 'package:thespot/data/model/reservation.dart';
import 'package:thespot/data/model/seat.dart';

abstract class IReservationRepository {
  Future<bool> hasReservation();
  Future<Reservation> getReservation();
  Future<bool> cancel(int id);
  Future<List<List<Seat>>> getSeatsInNext4Days();
}
