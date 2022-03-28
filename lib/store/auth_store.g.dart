// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthStore on _AuthStore, Store {
  Computed<LoginProgressState>? _$stateComputed;

  @override
  LoginProgressState get state =>
      (_$stateComputed ??= Computed<LoginProgressState>(() => super.state,
              name: '_AuthStore.state'))
          .value;

  final _$_stateAtom = Atom(name: '_AuthStore._state');

  @override
  LoginProgressState get _state {
    _$_stateAtom.reportRead();
    return super._state;
  }

  @override
  set _state(LoginProgressState value) {
    _$_stateAtom.reportWrite(value, super._state, () {
      super._state = value;
    });
  }

  final _$loginAsyncAction = AsyncAction('_AuthStore.login');

  @override
  Future<void> login() {
    return _$loginAsyncAction.run(() => super.login());
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
