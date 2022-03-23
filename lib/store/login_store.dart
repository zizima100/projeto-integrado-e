import 'package:mobx/mobx.dart';
import 'package:thespot/exceptions/login_exceptions.dart';
import 'package:thespot/models/user_model.dart';
import 'package:thespot/repository/google_sign_in_repository.dart';

part 'login_store.g.dart';

class Login extends _Login with _$Login {
  Login(GoogleSignInRepository signInRepository) {
    super._signInRepository = signInRepository;
  }
}

abstract class _Login with Store {
  late GoogleSignInRepository _signInRepository;

  @observable
  LoginProgressState _progressState = LoginProgressState.INITIAL;

  @computed
  LoginProgressState get progressState => _progressState;

  @action
  Future<void> login() async {
    try {
      User user = await _signInRepository.signIn();
      print('user = $user');
    } on GoogleSignInException {
      _progressState = LoginProgressState.ERROR;
    }
  }
}

// ignore: constant_identifier_names
enum LoginProgressState { INITIAL, LOADING, ERROR, SUCCESS }
