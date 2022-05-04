import 'package:thespot/data/model/reservation_response.dart';

class Reservation {
  final int id;
  final DateTime date;
  final int idSeat;

  Reservation({
    required this.id,
    required this.date,
    required this.idSeat,
  });

  factory Reservation.fromResponse(ReservationResponse response) => Reservation(
        id: response.id,
        date: DateTime.parse(response.reservationDate),
        idSeat: response.idSeat,
      );

  @override
  String toString() => 'Reservation(date: $date, idSeat: $idSeat)';
}
