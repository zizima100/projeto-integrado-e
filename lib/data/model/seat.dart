import 'dart:convert';

class Seat {
  final int id;
  SeatStatus status;

  Seat({
    required this.id,
    required this.status,
  });

  void select() {
    status = SeatStatus.selected;
  }

  void unselect() {
    status = SeatStatus.available;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'status': status.toJson,
    };
  }

  factory Seat.fromMap(Map<String, dynamic> map) {
    return Seat(
      id: map['id'] as int,
      status: SeatStatusParser.parse(map['status'] as String),
    );
  }

  static int idFromGridViewIndex(int index) => index + 1;

  @override
  String toString() => 'Seat(id: $id, status: $status)';
}

enum SeatStatus {
  available,
  unavailable,
  selected,
}

extension SeatStatusParser on SeatStatus {
  String get toJson => name.toUpperCase();
  bool get isAvailable => index == SeatStatus.available.index;
  bool get isUnavailable => index == SeatStatus.unavailable.index;
  bool get isSelected => index == SeatStatus.selected.index;
  static SeatStatus parse(String value) {
    return SeatStatus.values.firstWhere((SeatStatus element) => element.name.toUpperCase() == value.toUpperCase());
  }
}

class SeatIndexes {
  int dayIndex;
  int? seatIndex;

  SeatIndexes({
    required this.dayIndex,
    this.seatIndex,
  });

  void resetSeat() => seatIndex = null;
}
