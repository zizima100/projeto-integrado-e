import 'package:thespot/data/model/reservation_response.dart';
import 'package:thespot/data/provider/reservation/reservation_provider_interface.dart';
import 'package:thespot/repository/reservation/reservation_repository_interface.dart';

class ReservationRepository implements IReservationRepository {
  final IReservationProvider provider;

  const ReservationRepository({
    required this.provider,
  });

  @override
  Future<bool> hasReservation() async {
    List<ReservationResponse> reservations = await provider.getReservations();
    return reservations.isNotEmpty;
  }
}
