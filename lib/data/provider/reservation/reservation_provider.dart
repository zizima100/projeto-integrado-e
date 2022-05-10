import 'dart:convert';

import 'package:flutter/material.dart' show debugPrint;
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:thespot/data/model/auth_employee.dart';
import 'package:thespot/data/model/has_reservation_response.dart';
import 'package:thespot/data/model/reservation_response.dart';
import 'package:thespot/data/model/seats_response.dart';
import 'package:thespot/data/provider/constants.dart';
import 'package:thespot/data/provider/reservation/reservation_provider_interface.dart';

class ReservationProvider implements IReservationProvider {
  late final Client _client;
  String? _email;
  static const _jsonHeader = {
    "Content-Type": "application/json"
  };

  ReservationProvider() {
    _client = Client();
  }

  @override
  Future<HasReservationResponse> hasReservation() async {
    _email = GetIt.I<AuthEmployee>().email;
    debugPrint('hasReservation email => $_email');
    Response response = await _client.get(
      Uri.parse(Constants.API_URL + '/hasReservation?email=$_email'),
    );
    debugPrint('hasReservation response => ${response.body}');
    return HasReservationResponse.fromJson(response.body);
  }

  @override
  Future<ReservationResponse> getReservation() async {
    Response response = await _client.get(
      Uri.parse(Constants.API_URL + '/reservation?email=$_email'),
    );
    debugPrint('response => ${response.body}');
    return ReservationResponse.fromMap(jsonDecode(response.body)['reservation']);
  }

  @override
  Future<bool> cancel(int id) async {
    debugPrint('cancelling $id');
    Map<String, dynamic> body = {
      ..._jsonHeader
    };
    body.addAll({
      'reservationId': id,
    });

    Response response = await _client.put(
      Uri.parse(Constants.API_URL + '/cancel-reservation'),
      body: jsonEncode({
        'reservationId': id,
      }),
      headers: _jsonHeader,
    );
    debugPrint('cancel response => ${response.body}');
    if (json.decode(response.body)['ok']) {
      return true;
    }
    return true;
  }

  @override
  Future<SeatsResponse> getSeatsInNext4Days() async {
    Response response = await _client.get(Uri.parse(
      Constants.API_URL + '/four-days-seats-data',
    ));
    return SeatsResponse.fromJson(response.body);
  }
}
