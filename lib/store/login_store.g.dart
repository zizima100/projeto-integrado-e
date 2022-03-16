// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Login on _Login, Store {
  Computed<LoginProgressState>? _$progressStateComputed;

  @override
  LoginProgressState get progressState => (_$progressStateComputed ??=
          Computed<LoginProgressState>(() => super.progressState,
              name: '_Login.progressState'))
      .value;

  final _$_progressStateAtom = Atom(name: '_Login._progressState');

  @override
  LoginProgressState get _progressState {
    _$_progressStateAtom.reportRead();
    return super._progressState;
  }

  @override
  set _progressState(LoginProgressState value) {
    _$_progressStateAtom.reportWrite(value, super._progressState, () {
      super._progressState = value;
    });
  }

  final _$loginAsyncAction = AsyncAction('_Login.login');

  @override
  Future<void> login() {
    return _$loginAsyncAction.run(() => super.login());
  }

  @override
  String toString() {
    return '''
progressState: ${progressState}
    ''';
  }
}
