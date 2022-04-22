import 'package:intl/intl.dart';
import 'package:thespot/data/model/reservation_response.dart';
import 'package:thespot/repository/reservation/reservation_repository.dart';

class Reservation {
  final DateTime date;
  final int idSeat;

  Reservation({
    required this.date,
    required this.idSeat,
  });

  factory Reservation.fromResponse(ReservationResponse response) => Reservation(
      date: DateTime.parse(response.reservationDate), idSeat: response.idSeat);

  @override
  String toString() => 'Reservation(date: $date, idSeat: $idSeat)';
}
