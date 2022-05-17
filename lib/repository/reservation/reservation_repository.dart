import 'package:get_it/get_it.dart';
import 'package:thespot/data/model/auth_employee.dart';
import 'package:thespot/data/model/has_reservation_response.dart';
import 'package:thespot/data/model/reservation.dart';
import 'package:thespot/data/model/reservation_request.dart';
import 'package:thespot/data/model/reservation_response.dart';
import 'package:thespot/data/model/seat.dart';
import 'package:thespot/data/provider/reservation/reservation_provider_interface.dart';
import 'package:thespot/repository/reservation/reservation_repository_interface.dart';

class ReservationRepository implements IReservationRepository {
  final IReservationProvider provider;

  const ReservationRepository({
    required this.provider,
  });

  @override
  Future<bool> hasReservation() async {
    HasReservationResponse hasReservationResponse = await provider.hasReservation();
    return hasReservationResponse.hasReservation;
  }

  @override
  Future<Reservation> getReservation() async {
    ReservationResponse response = await provider.getReservation();
    return Reservation.fromResponse(response);
  }

  @override
  Future<bool> cancel(int id) async {
    return await provider.cancel(id);
  }

  @override
  Future<List<List<Seat>>> getSeatsInNext4Days() async {
    return (await provider.getSeatsInNext4Days()).seats;
  }

  @override
  Future<void> reserve(DateTime date, int seatId) async {
    await provider.reserve(
      ReservationRequest(
        date: date,
        seatId: seatId,
        employeeEmail: GetIt.I<AuthEmployee>().email,
      ),
    );
  }
}
