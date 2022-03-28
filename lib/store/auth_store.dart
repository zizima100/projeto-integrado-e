// ignore_for_file: constant_identifier_names

import 'package:mobx/mobx.dart';
import 'package:thespot/data/model/auth_employee.dart';
import 'package:thespot/repository/auth_repository.dart';
import 'package:thespot/repository/google_sign_in_repository.dart';

part 'auth_store.g.dart';

class AuthStore extends _AuthStore with _$AuthStore {
  AuthStore({
    required GoogleSignInRepository signInRepository,
    required AuthRepository authRepository,
  }) {
    super._signInRepository = signInRepository;
    super._authRepository = authRepository;
  }
}

abstract class _AuthStore with Store {
  late GoogleSignInRepository _signInRepository;
  late AuthRepository _authRepository;

  @observable
  LoginProgressState _state = LoginProgressState.INITIAL;

  @computed
  LoginProgressState get state => _state;

  @action
  Future<void> login() async {
    try {
      print('Store login');
      AuthEmployee user = await _signInRepository.signIn();
      print('user = $user');
      _state = LoginProgressState.LOADING;
      final isAuthorized = await _authRepository.isAuthorized(user.email);
      print('isAuthorized = $isAuthorized');
      if (isAuthorized) {
        _state = LoginProgressState.SUCCESS;
      } else {
        _state = LoginProgressState.UNAUTHORIZED;
      }
    } catch (e) {
      _state = LoginProgressState.ERROR;
    }
  }
}

enum LoginProgressState {
  INITIAL,
  LOADING,
  ERROR,
  SUCCESS,
  UNAUTHORIZED,
}
