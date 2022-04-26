import 'package:flutter/material.dart' show debugPrint;
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:thespot/data/model/reservation.dart';
import 'package:thespot/repository/reservation/reservation_repository_interface.dart';

import 'query_state.dart';

part 'query_store.g.dart';

class QueryStore extends _QueryStore with _$QueryStore {
  QueryStore({
    required IReservationRepository repository,
  }) {
    super._repository = repository;
  }
}

abstract class _QueryStore with Store {
  late IReservationRepository _repository;

  @observable
  QueryState _state = QueryStateLoading();

  @computed
  QueryState get state => _state;

  @action
  Future<void> query() async {
    try {
      Reservation reservation = await _repository.getReservation();
      debugPrint('reservation => $reservation');
      String dateFormatted = DateFormat('dd/MM/yyyy').format(reservation.date);
      debugPrint('reservation dateFormatted => $dateFormatted');
      _state = QueryStateQueried(date: dateFormatted, seat: 'Cadeira ${reservation.idSeat}');
    } catch (e) {
      debugPrint('Error on _query: $e');
      _state = QueryStateFailure();
    }
  }

  @action
  void resetState() {
    _state = QueryStateLoading();
  }
}
