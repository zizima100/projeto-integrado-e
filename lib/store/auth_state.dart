abstract class AuthState {}

class AuthStateInitial implements AuthState {}

class AuthStateSuccess implements AuthState {}

class AuthStateFailure implements AuthState {}

class AuthStateLoading implements AuthState {}

class AuthStateUnauthorized implements AuthState {}
