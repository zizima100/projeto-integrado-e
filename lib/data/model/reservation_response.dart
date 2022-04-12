import 'dart:convert';

class ReservationResponse {
  final int id;
  final String createdAt;
  final String reservationDate;
  final String status;
  final String employeeEmail;
  final int idSeat;

  ReservationResponse({
    required this.id,
    required this.createdAt,
    required this.reservationDate,
    required this.status,
    required this.employeeEmail,
    required this.idSeat,
  });

  factory ReservationResponse.fromMap(Map<String, dynamic> map) {
    return ReservationResponse(
      id: map['id'],
      createdAt: map['createdAt'],
      reservationDate: map['reservationDate'],
      status: map['status'],
      employeeEmail: map['employeeEmail'],
      idSeat: map['idSeat'],
    );
  }

  @override
  String toString() {
    return 'ReservationResponse(id: $id, createdAt: $createdAt, reservationDate: $reservationDate, status: $status, employeeEmail: $employeeEmail, idSeat: $idSeat)';
  }

  factory ReservationResponse.fromJson(String source) => ReservationResponse.fromMap(json.decode(source));
}
