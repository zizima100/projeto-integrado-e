abstract class ReserveState {}

class ReserveStateInitial implements ReserveState {}

class ReserveStateChooseDateAndSeat implements ReserveState {
  final bool isLoading;
  ReserveStateChooseDateAndSeat({required this.isLoading});
}

class ReserveStateConfirmation implements ReserveState {
  final String date;
  final String seat;

  ReserveStateConfirmation({required this.date, required this.seat});
}

class ReserveStateSuccess implements ReserveState {}
