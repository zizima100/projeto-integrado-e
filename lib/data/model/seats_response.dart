import 'dart:convert';

import 'package:thespot/data/model/seat.dart';

class SeatsResponse {
  final List<List<Seat>> seats;

  SeatsResponse(this.seats);

  factory SeatsResponse.fromMap(Map<String, dynamic> map) {
    final seats = map['seats'] as List<List<dynamic>>;
    print('seats = $seats');
    return SeatsResponse([
      []
    ]);
  }

  factory SeatsResponse.fromJson(String source) => SeatsResponse.fromMap(json.decode(source));
}
