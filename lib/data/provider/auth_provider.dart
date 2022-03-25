import 'package:thespot/data/model/auth_response.dart';

abstract class AuthProvider {
  Future<AuthResponse> isAuthorized(String email);
}