import 'package:http/http.dart';
import 'package:thespot/data/model/auth_response.dart';
import 'package:thespot/data/model/employee_email.dart';
import 'package:thespot/data/provider/constants.dart';

import 'auth_provider.dart';

class AuthProviderImpl implements AuthProvider {
  late final Client client;

  AuthProviderImpl() {
    client = Client();
  }

  @override
  Future<AuthResponse> isAuthorized(EmployeeEmailRequest email) async {
    Response response = await client.get(
      Uri.parse(Constants.API_URL + '/auth?email=$email'),
    );
    return AuthResponse.fromJson(response.body);
  }
}
