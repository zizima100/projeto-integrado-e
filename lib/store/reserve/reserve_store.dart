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
  List<Seat>? _currentSeatsDay;
  int? _dayIndexSelected;
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
      _dayIndexSelected = 0;
      _currentSeatsDay = _allSeats![_dayIndexSelected!];
      _state = ReserveStateChooseDateAndSeat(
        seats: _currentSeatsDay!,
        dayIndex: _dayIndexSelected!,
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
    _dayIndexSelected = dayIndex;
    _currentSeatsDay = _allSeats![dayIndex];
    _state = ReserveStateChooseDateAndSeat(
      seats: _currentSeatsDay!,
      dayIndex: dayIndex,
    );
  }

  @action
  void onSeatTap(int id) {
    _seatIdSelected = _seatIndexFromId(id);
    var seat = _currentSeatsDay![_seatIdSelected!];
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
        _currentSeatsDay![_seatIdSelected!].select();
      } else {
        _currentSeatsDay![_seatIdSelected!].select();
      }
    } else if (status.isSelected) {
      _currentSeatsDay![_seatIdSelected!].unselect();
    }
    _state = ReserveStateChooseDateAndSeat(
      seats: _currentSeatsDay!,
      dayIndex: _dayIndexSelected!,
    );
  }

  int _seatIndexFromId(int id) => _currentSeatsDay!.indexWhere((seat) => seat.id == id);

  @action
  void chooseSeat() => _state = ReserveStateConfirmation(
        date: DateFormat(Constants.DD_MM_YYYY).format(DateTime.now().add(Duration(days: _dayIndexSelected!))),
        seat: 'Cadeira $_seatIdSelected',
      );

  @action
  void confirm() => _state = ReserveStateSuccess();

  @action
  void backState() {
    if (_state is ReserveStateInitial) {
      return;
    }
    if (_state is ReserveStateChooseDateAndSeat) {
      _state = ReserveStateInitial();
    }
    if (_state is ReserveStateConfirmation) {
      _state = ReserveStateChooseDateAndSeat(seats: _currentSeatsDay!, dayIndex: _dayIndexSelected!);
    }
  }

  @action
  void resetState() {
    _state = ReserveStateInitial();
  }
}
