class GoogleSignInException implements Exception {
  const GoogleSignInException();

  @override
  String toString() => 'Ocorreu um erro';
}

class CurrentUserNotFound implements Exception {
  const CurrentUserNotFound();

  @override
  String toString() => 'Current user was not found';
}
