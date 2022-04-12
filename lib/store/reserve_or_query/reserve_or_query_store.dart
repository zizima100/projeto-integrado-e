import 'package:flutter/material.dart' show debugPrint;
import 'package:mobx/mobx.dart';
import 'package:thespot/repository/reservation/reservation_repository_interface.dart';

import 'reserve_or_query_state.dart';

part 'reserve_or_query_store.g.dart';

class ReserveOrQueryStore extends _ReserveOrQueryStore with _$ReserveOrQueryStore {
  ReserveOrQueryStore({
    required IReservationRepository repository,
  }) {
    super._repository = repository;
    super._reserveOrQuery();
  }
}

abstract class _ReserveOrQueryStore with Store {
  late IReservationRepository _repository;

  @observable
  ReserveOrQueryState _state = ReserveOrQueryLoading();

  @computed
  ReserveOrQueryState get state => _state;

  @action
  Future<void> _reserveOrQuery() async {
    try {
      bool hasReservation = await _repository.hasReservation();
      if (hasReservation) {
        _state = ReserveOrQueryQuerying();
      } else {
        _state = ReserveOrQueryReserving();
      }
    } catch (e) {
      debugPrint('Error on reserveOrQuery: $e');
      _state = ReserveOrQueryFailure();
    }
  }
}
