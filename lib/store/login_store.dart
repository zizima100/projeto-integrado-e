import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class Login = _Login with _$Login;

abstract class _Login with Store {
  @observable
  LoginProgressState _progressState = LoginProgressState.INITIAL;

  @computed
  LoginProgressState get progressState => _progressState;

  @action
  Future<void> login() async {
    _progressState = LoginProgressState.LOADING;
    await Future.delayed(const Duration(seconds: 3));
    _progressState = LoginProgressState.SUCCESS;
  }
}

// ignore: constant_identifier_names
enum LoginProgressState { INITIAL, LOADING, ERROR, SUCCESS }
