import 'package:flutter/material.dart' show debugPrint;
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
      _state = QueryStateLoading();
      _reservation = await _repository.getReservation();
      _state = QueryStateQueried(_reservation!, _reservation!.idSeat - 1);
    } catch (e) {
      debugPrint('Error on _query: $e');
      _state = QueryStateFailure();
    }
  }

  @action
  void detailedReservation() {
    _state = QueryStateDetailed(_reservation!);
  }

  @action
  void backToInitial() {
    _state = QueryStateQueried(_reservation!, _reservation!.idSeat - 1);
  }

  @action
  void confirmCancellation() {
    _state = QueryStateConfirmCancellation();
  }

  @action
  void backToReservationDetailed() {
    _state = QueryStateDetailed(_reservation!);
  }

  @action
  Future<void> cancelReservation() async {
    try {
      bool cancelled = await _repository.cancel(_reservation!.id);
      if (cancelled) {
        _state = QueryStateReservationCancelled();
      } else {
        _state = QueryStateFailure();
      }
    } on Exception catch (e) {
      print('QueryStore cancelReservation error: $e');
      _state = QueryStateFailure();
    }
  }
}
