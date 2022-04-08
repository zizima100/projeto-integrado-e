abstract class IAuthRepository {
  Future<bool> isAuthorized(String email);
}
