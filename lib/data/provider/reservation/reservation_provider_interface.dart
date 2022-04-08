import 'package:thespot/data/model/reservation_response.dart';

abstract class IReservationProvider {
  Future<List<ReservationResponse>> getReservations();
}
