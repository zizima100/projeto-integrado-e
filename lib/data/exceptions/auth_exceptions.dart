class GoogleSignInException implements Exception {
  const GoogleSignInException();

  @override
  String toString() => 'Error in google sign in';
}

class CurrentEmployeeNotFound implements Exception {
  const CurrentEmployeeNotFound();

  @override
  String toString() => 'Current user was not found';
}
