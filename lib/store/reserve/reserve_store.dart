import 'package:mobx/mobx.dart';
import 'package:thespot/data/model/seat.dart';
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
  List<Seat>? _seats;

  @observable
  ReserveState _state = ReserveStateInitial();

  @computed
  ReserveState get state => _state;

  @action
  Future<void> start() async {
    try {
      _seats = await _repository.getSeatsInNext4Days();
      print('seats => $_seats');
      _state = ReserveStateChooseDateAndSeat(seats: _seats!);
    } catch (e) {
      _state = ReserveStateFailure();
    }
  }

  @action
  void onSeatTap(int id) {
    int index = _seatIndexFromId(id);
    var seat = _seats![index];
    print('seat tapped = $seat');
    SeatStatus status = seat.status;
    if (status.isUnavailable) {
      return;
    }

    if (status.isAvailable) {
      Seat? selectedSeat =
          _seats!.firstWhereOrNull((seat) => seat.status.isSelected);
      if (selectedSeat != null) {
        int selectedIndex = _seatIndexFromId(selectedSeat.id);
        _seats![selectedIndex].unselect();
        _seats![index].select();
      } else {
        _seats![index].select();
      }
    } else if (status.isSelected) {
      _seats![index].unselect();
    }
    _state = ReserveStateChooseDateAndSeat(seats: _seats!);
  }

  int _seatIndexFromId(int id) => _seats!.indexWhere((seat) => seat.id == id);

  @action
  void chooseSeat() => _state = ReserveStateConfirmation(
        date: '12/03/2022',
        seat: 'Cadeira 12',
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
      _state = ReserveStateChooseDateAndSeat(seats: _seats!);
    }
  }

  @action
  void resetState() {
    _state = ReserveStateInitial();
  }
}
