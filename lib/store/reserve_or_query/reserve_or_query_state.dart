abstract class ReserveOrQueryState {}

class ReserveOrQueryReserving implements ReserveOrQueryState {}

class ReserveOrQueryQuerying implements ReserveOrQueryState {}

class ReserveOrQueryLoading implements ReserveOrQueryState {}

class ReserveOrQueryFailure implements ReserveOrQueryState {}
