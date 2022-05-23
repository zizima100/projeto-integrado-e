import 'package:thespot/data/model/seat.dart';

abstract class ReserveState {}

class ReserveStateInitial implements ReserveState {}

class ReserveStateChooseDateAndSeat implements ReserveState {
  final bool isLoading;
  final int dayIndex;
  final List<Seat> seats;

  ReserveStateChooseDateAndSeat({
    required this.seats,
    required this.dayIndex,
    this.isLoading = false,
  });

  factory ReserveStateChooseDateAndSeat.loading() => ReserveStateChooseDateAndSeat(isLoading: true, seats: [], dayIndex: 0);
}

class ReserveStateConfirmation implements ReserveState {
  final String date;
  final String seat;
  final int indexSelected;

  ReserveStateConfirmation({
    required this.date,
    required this.seat,
    required this.indexSelected,
  });
}

class ReserveStateSuccess implements ReserveState {}

class ReserveStateFailure implements ReserveState {}

class ReserveStateQuerySeat implements ReserveState {}
