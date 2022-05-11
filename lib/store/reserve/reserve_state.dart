import 'package:thespot/data/model/seat.dart';

abstract class ReserveState {}

class ReserveStateInitial implements ReserveState {}

class ReserveStateChooseDateAndSeat implements ReserveState {
  final int dayIndex;
  final List<Seat> seats;

  ReserveStateChooseDateAndSeat({
    required this.seats,
    required this.dayIndex,
  });
}

class ReserveStateConfirmation implements ReserveState {
  final String date;
  final String seat;
  final List<Seat> seats;

  ReserveStateConfirmation({required this.date, required this.seat, required this.seats});
}

class ReserveStateSuccess implements ReserveState {}

class ReserveStateFailure implements ReserveState {}
