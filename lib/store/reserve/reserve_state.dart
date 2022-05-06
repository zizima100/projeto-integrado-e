import 'package:thespot/data/model/seat.dart';

abstract class ReserveState {}

class ReserveStateInitial implements ReserveState {}

class ReserveStateChooseDateAndSeat implements ReserveState {
  final List<Seat> seats;

  ReserveStateChooseDateAndSeat({required this.seats});
}

class ReserveStateConfirmation implements ReserveState {
  final String date;
  final String seat;

  ReserveStateConfirmation({required this.date, required this.seat});
}

class ReserveStateSuccess implements ReserveState {}

class ReserveStateFailure implements ReserveState {}
