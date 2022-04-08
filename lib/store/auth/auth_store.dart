// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart' show debugPrint;
import 'package:mobx/mobx.dart';
import 'package:thespot/data/model/auth_employee.dart';
import 'package:thespot/repository/auth/auth_repository.dart';
import 'package:thespot/repository/auth/sso_repository.dart';

import 'auth_state.dart';

part 'auth_store.g.dart';

class AuthStore extends _AuthStore with _$AuthStore {
  AuthStore({
    required SsoRepository ssoRepository,
    required AuthRepository authRepository,
  }) {
    super._ssoRepository = ssoRepository;
    super._authRepository = authRepository;
  }
}

abstract class _AuthStore with Store {
  late SsoRepository _ssoRepository;
  late AuthRepository _authRepository;

  @observable
  AuthState _state = AuthStateInitial();

  @computed
  AuthState get state => _state;

  @action
  Future<void> signIn() async {
    debugPrint('authstore login');
    try {
      AuthEmployee user = await _ssoRepository.signIn();
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
