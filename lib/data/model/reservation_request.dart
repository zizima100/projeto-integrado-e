import 'dart:convert';

class ReservationRequest {
  final DateTime date;
  final int seatId;
  final String employeeEmail;

  ReservationRequest({
    required this.date,
    required this.seatId,
    required this.employeeEmail,
  });

  Map<String, dynamic> toMap() {
    return {
      'reservationDate': date.toIso8601String(),
      'seatId': seatId,
      'userEmail': employeeEmail,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'ReservationRequest(date: $date, seatId: $seatId, employeeEmail: $employeeEmail)';
}
