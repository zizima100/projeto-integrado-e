import 'package:mobx/mobx.dart';
import 'package:thespot/data/exceptions/auth_exceptions.dart';
import 'package:thespot/data/model/auth_employee.dart';
import 'package:thespot/data/repository/auth_repository.dart';
import 'package:thespot/repository/google_sign_in_repository.dart';

part 'login_store.g.dart';

class Login extends _Login with _$Login {
  Login({
    required GoogleSignInRepository signInRepository,
    required AuthRepository authRepository,
  }) {
    super._signInRepository = signInRepository;
    super._authRepository = authRepository;
  }
}

abstract class _Login with Store {
  late GoogleSignInRepository _signInRepository;
  late AuthRepository _authRepository;

  @observable
  LoginProgressState _progressState = LoginProgressState.INITIAL;

  @computed
  LoginProgressState get progressState => _progressState;

  @action
  Future<void> login() async {
    try {
      AuthEmployee user = await _signInRepository.signIn();
      print('user = $user');
      final isAuthorized = await _authRepository.isAuthorized(user.email);
    } on GoogleSignInException {
      _progressState = LoginProgressState.ERROR;
    }
  }
}

// ignore: constant_identifier_names
enum LoginProgressState { INITIAL, LOADING, ERROR, SUCCESS }
