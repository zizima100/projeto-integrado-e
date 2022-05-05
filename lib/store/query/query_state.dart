import 'package:thespot/data/model/reservation.dart';
import 'package:intl/intl.dart';

abstract class QueryState {}

class QueryStateLoading implements QueryState {}

class QueryStateFailure implements QueryState {}

class QueryStateQueried implements QueryState {
  final Reservation _reservation;

  const QueryStateQueried(this._reservation);

  String get seat => 'Cadeira ${_reservation.idSeat}';
  String get date => DateFormat('dd/MM/yyyy').format(_reservation.date);
  String get reservationJson => _reservation.toJson();
}

class QueryStateDetailed implements QueryState {
  final Reservation _reservation;

  const QueryStateDetailed(this._reservation);

  String get seat => 'Cadeira ${_reservation.idSeat}';
  String get date => DateFormat('dd/MM/yyyy').format(_reservation.date);
  String get reservationJson => _reservation.toJson();
}

class QueryStateConfirmCancellation implements QueryState {}

class QueryStateReservationCancelled implements QueryState {}
