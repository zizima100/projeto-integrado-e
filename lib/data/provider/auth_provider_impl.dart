import 'package:thespot/data/model/auth_response.dart';
import 'package:thespot/data/provider/auth_provider.dart';

class AuthProviderImpl implements AuthProvider {
  @override
  Future<AuthResponse> isAuthorized(String email) async {
    return Future.value(AuthResponse(isAuthorized: true));
  }
}