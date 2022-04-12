import 'package:http/http.dart';
import 'package:thespot/data/model/auth_response.dart';
import 'package:thespot/data/model/employee_email.dart';
import 'package:thespot/data/provider/constants.dart';

import 'auth_provider_interface.dart';

class AuthProvider implements IAuthProvider {
  late final Client _client;

  AuthProvider() {
    _client = Client();
  }

  @override
  Future<AuthResponse> isAuthorized(EmployeeEmailRequest email) async {
    Response response = await _client.get(
      Uri.parse(Constants.API_URL + '/auth?email=$email'),
    );
    return AuthResponse.fromJson(response.body);
  }
}
