import 'package:mobx/mobx.dart';
import 'package:thespot/store/reserve/reserve_state.dart';

part 'reserve_store.g.dart';

class ReserveStore extends _ReserveStore with _$ReserveStore {}

abstract class _ReserveStore with Store {
  @observable
  ReserveState _state = ReserveStateInitial();

  @computed
  ReserveState get state => _state;

  @action
  void start() {
    _state = ReserveStateChooseDateAndSeat(isLoading: true);
  }

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
      _state = ReserveStateChooseDateAndSeat(isLoading: false);
    }
  }
}
