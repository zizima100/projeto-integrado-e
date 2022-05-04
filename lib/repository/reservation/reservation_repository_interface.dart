import 'package:thespot/data/model/reservation.dart';

abstract class IReservationRepository {
  Future<bool> hasReservation();
  Future<Reservation> getReservation();
  Future<void> cancel(int id);
}
