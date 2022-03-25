import 'package:http/http.dart';
import 'package:thespot/data/model/auth_response.dart';
import 'package:thespot/data/model/employee_email.dart';
import 'package:thespot/data/provider/auth_provider.dart';
import 'package:thespot/data/provider/constants.dart';

class AuthProviderImpl implements AuthProvider {
  late final Client client;

  AuthProviderImpl() {
    client = Client();
  }

  @override
  Future<AuthResponse> isAuthorized(EmployeeEmailRequest email) async {
    final params = email.toMap();
    await client.get(
      Uri.https(
        Constants.API_URL,
        '/auth',
      ),
      headers: params
    );
    return Future.value(AuthResponse(isAuthorized: true));
  }
}