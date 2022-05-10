import 'dart:convert';

import 'package:thespot/data/model/seat.dart';

class SeatsResponse {
  final List<List<Seat>> seats;

  SeatsResponse(this.seats);

  factory SeatsResponse.fromMap(Map<String, dynamic> map) {
    final List<dynamic> dateSeatsDynamic = map['seats'] as List;
    print('dateSeatsDynamic -> $dateSeatsDynamic');
    final List<List<dynamic>> dateSeatsMap = dateSeatsDynamic.map((dynamic_) => dynamic_ as List).toList();

    List<List<Seat>> seats = [];

    for (List<dynamic> seatDayMap in dateSeatsMap) {
      List<Seat> seatDay = seatDayMap.map((map) {
        print('map ==> $map');
        return Seat.fromMap(map);
      }).toList();
      seats.add(seatDay);
      print('seatDay -> $seatDay');
    }

    return SeatsResponse(seats);
  }

  factory SeatsResponse.fromJson(String source) => SeatsResponse.fromMap(json.decode(source));
}
