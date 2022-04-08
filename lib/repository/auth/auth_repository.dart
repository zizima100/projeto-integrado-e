abstract class AuthRepository {
  Future<bool> isAuthorized(String email);
}