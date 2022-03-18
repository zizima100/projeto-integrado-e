import 'package:mobx/mobx.dart';
import 'package:thespot/repository/google_sign_in_repository.dart';

part 'login_store.g.dart';

class Login = _Login with _$Login;

abstract class _Login with Store {
  static late GoogleSignInRepository _googleRepository;

  @observable
  LoginProgressState _progressState = LoginProgressState.INITIAL;

  @computed
  LoginProgressState get progressState => _progressState;

  @action
  Future<void> login() async {
    _googleRepository = GoogleSignInRepository();
    String? email = await _googleRepository.signIn();
    print('email = $email');
  }
}

// ignore: constant_identifier_names
enum LoginProgressState { INITIAL, LOADING, ERROR, SUCCESS }
