import 'dart:convert';

class HasReservationResponse {
  final bool hasReservation;

  HasReservationResponse({
    required this.hasReservation,
  });

  factory HasReservationResponse.fromMap(Map<String, dynamic> map) {
    return HasReservationResponse(
      hasReservation: map['hasReservation'] ?? false,
    );
  }

  factory HasReservationResponse.fromJson(String source) => HasReservationResponse.fromMap(json.decode(source));

  @override
  String toString() => 'HasReservationResponse(hasReservation: $hasReservation)';
}
