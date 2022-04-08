import 'dart:convert';
import 'package:flutter/material.dart' show debugPrint;
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:thespot/data/model/auth_employee.dart';
import 'package:thespot/data/model/reservation_response.dart';
import 'package:thespot/data/provider/constants.dart';
import 'package:thespot/data/provider/reservation/reservation_provider_interface.dart';

class ReservationProvider implements IReservationProvider {
  late final Client client;

  ReservationProvider() {
    client = Client();
  }

  @override
  Future<List<ReservationResponse>> getReservations() async {
    final String email = GetIt.I<AuthEmployee>().email;
    Response response = await client.get(
      Uri.parse(Constants.API_URL + '/reservation?email=$email'),
    );
    debugPrint('response => ${response.body}');
    final reservationsJson = jsonDecode(response.body);
    List<ReservationResponse> reservations = [];
    for (final reservation in reservationsJson['reservations']) {
      reservations.add(ReservationResponse.fromMap(reservation));
    }
    debugPrint('reservations => $reservations');

    return reservations;
  }
}
