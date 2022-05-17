import 'package:flutter/material.dart' show debugPrint;
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:thespot/data/model/seat.dart';
import 'package:thespot/data/provider/constants.dart';
import 'package:thespot/repository/reservation/reservation_repository_interface.dart';
import 'package:thespot/store/reserve/reserve_state.dart';
import 'package:collection/collection.dart';

part 'reserve_store.g.dart';

class ReserveStore extends _ReserveStore with _$ReserveStore {
  ReserveStore({
    required IReservationRepository repository,
  }) {
    super._repository = repository;
  }
}

abstract class _ReserveStore with Store {
  late IReservationRepository _repository;
  List<List<Seat>>? _allSeats;
  final SeatIndexes _indexes = SeatIndexes(dayIndex: 0);
  List<Seat>? _currentSeatsDay;
  int? _seatIdSelected;

  @observable
  ReserveState _state = ReserveStateInitial();

  @computed
  ReserveState get state => _state;

  @action
  Future<void> start() async {
    try {
      _allSeats = await _repository.getSeatsInNext4Days();
      print('_allSeats => $_allSeats');
      _currentSeatsDay = _allSeats![_indexes.dayIndex];
      _state = ReserveStateChooseDateAndSeat(
        seats: _currentSeatsDay!,
        dayIndex: _indexes.dayIndex,
      );
    } catch (e) {
      debugPrint('error in reservation store start: $e');
      _state = ReserveStateFailure();
    }
  }

  /// `indexDay` should be in [0,4] range.
  /// 0 is today, 1 tomorrow and so on.
  @action
  void onDayTap(int dayIndex) {
    _indexes.dayIndex = dayIndex;
    _indexes.resetSeat();
    _unselectAllSeats();
    _currentSeatsDay = _allSeats![dayIndex];

    _state = ReserveStateChooseDateAndSeat(
      seats: _currentSeatsDay!,
      dayIndex: dayIndex,
    );
  }

  @action
  void onSeatTap(int id) {
    _indexes.seatIndex = _seatIndexFromId(id);
    var seat = _currentSeatsDay![_indexes.seatIndex!];
    print('seat tapped = $seat');
    SeatStatus status = seat.status;
    if (status.isUnavailable) {
      return;
    }

    if (status.isAvailable) {
      Seat? selectedSeat = _currentSeatsDay!.firstWhereOrNull((seat) => seat.status.isSelected);
      if (selectedSeat != null) {
        int selectedIndex = _seatIndexFromId(selectedSeat.id);
        _currentSeatsDay![selectedIndex].unselect();
        _currentSeatsDay![_indexes.seatIndex!].select();
      } else {
        _currentSeatsDay![_indexes.seatIndex!].select();
      }
      _seatIdSelected = id;
    } else if (status.isSelected) {
      if (_seatIdSelected == id) {
        _seatIdSelected = null;
      }
      _currentSeatsDay![_indexes.seatIndex!].unselect();
    }
    _state = ReserveStateChooseDateAndSeat(
      seats: _currentSeatsDay!,
      dayIndex: _indexes.dayIndex,
    );
  }

  int _seatIndexFromId(int id) => _currentSeatsDay!.indexWhere((seat) => seat.id == id);

  void _unselectAllSeats() {
    for (var seatsDay in _allSeats!) {
      for (var seat in seatsDay) {
        seat.unselect();
      }
    }
  }

  @action
  void chooseSeat() {
    if (_seatIdSelected != null) {
      _state = ReserveStateConfirmation(
        date: DateFormat(Constants.DD_MM_YYYY).format(DateTime.now().add(
          Duration(days: _indexes.dayIndex),
        )),
        seat: 'Cadeira $_seatIdSelected',
        indexSelected: _indexes.seatIndex!,
      );
    }
  }

  @action
  Future<void> confirm() async {
    try {
      await _repository.reserve(
        DateTime.now().add(Duration(days: _indexes.dayIndex)),
        _seatIdSelected!,
      );
      _state = ReserveStateSuccess();
    } on Exception catch (e) {
      debugPrint('error in reservation confirmation: $e');
      _state = ReserveStateFailure();
    }
  }

  @action
  void backState() {
    if (_state is ReserveStateInitial) {
      return;
    }
    if (_state is ReserveStateChooseDateAndSeat) {
      _state = ReserveStateInitial();
    }
    if (_state is ReserveStateConfirmation) {
      _state = ReserveStateChooseDateAndSeat(
        seats: _currentSeatsDay!,
        dayIndex: _indexes.dayIndex,
      );
    }
  }

  @action
  void resetState() {
    _state = ReserveStateInitial();
  }
}
