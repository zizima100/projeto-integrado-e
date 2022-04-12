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
      createdAt: map['created_at'],
      reservationDate: map['reservation_date'],
      status: map['status'],
      employeeEmail: map['employee_email'],
      idSeat: map['id_seat'],
    );
  }

  @override
  String toString() {
    return 'ReservationResponse(id: $id, createdAt: $createdAt, reservationDate: $reservationDate, status: $status, employeeEmail: $employeeEmail, idSeat: $idSeat)';
  }

  factory ReservationResponse.fromJson(String source) => ReservationResponse.fromMap(json.decode(source));
}
