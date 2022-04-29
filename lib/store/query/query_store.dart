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
  Reservation? _reservation;

  @observable
  QueryState _state = QueryStateLoading();

  @computed
  QueryState get state => _state;

  @action
  Future<void> query() async {
    try {
      _reservation = await _repository.getReservation();
      _state = QueryStateQueried(date: _formatDate, seat: _formatSeatId);
    } catch (e) {
      debugPrint('Error on _query: $e');
      _state = QueryStateFailure();
    }
  }

  @action
  void detailedReservation() {
    _state = QueryStateDetailed(date: _formatDate, seat: _formatSeatId);
  }

  @action
  void resetState() {
    _state = QueryStateLoading();
  }

  String get _formatSeatId => 'Cadeira ${_reservation!.idSeat}';

  String get _formatDate => DateFormat('dd/MM/yyyy').format(_reservation!.date);
}
