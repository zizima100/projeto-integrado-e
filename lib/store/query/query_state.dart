abstract class QueryState {}

class QueryStateLoading implements QueryState {}

class QueryStateFailure implements QueryState {}

class QueryStateQueried implements QueryState {
  final String date;
  final String seat;

  QueryStateQueried({
    required this.date,
    required this.seat,
  });
}
