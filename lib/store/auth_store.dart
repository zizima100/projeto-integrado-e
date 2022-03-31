// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart' show debugPrint;
import 'package:mobx/mobx.dart';
import 'package:thespot/data/model/auth_employee.dart';
import 'package:thespot/repository/auth_repository.dart';
import 'package:thespot/repository/google_sign_in_repository.dart';
import 'package:thespot/store/auth_state.dart';

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
  AuthState _state = AuthStateInitial();

  @computed
  AuthState get state => _state;

  @action
  Future<void> login() async {
    debugPrint('authstore login');
    try {
      AuthEmployee user = await _signInRepository.signIn();
      debugPrint('user = $user');
      _state = AuthStateLoading();
      final isAuthorized = await _authRepository.isAuthorized(user.email);
      debugPrint('isAuthorized = $isAuthorized');
      if (isAuthorized) {
        _state = AuthStateSuccess();
      } else {
        _state = AuthStateUnauthorized();
      }
    } catch (e) {
      debugPrint('Exception in login: $e');
      _state = AuthStateFailure();
    }
  }
}
