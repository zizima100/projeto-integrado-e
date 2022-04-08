import 'package:thespot/data/model/employee_email.dart';
import 'package:thespot/data/provider/auth/auth_provider_interface.dart';

import 'auth_repository_interface.dart';

class AuthRepository implements IAuthRepository {
  final IAuthProvider provider;

  const AuthRepository({
    required this.provider,
  });

  @override
  Future<bool> isAuthorized(String email) async {
    final response = await provider.isAuthorized(EmployeeEmailRequest(email));
    return response.isAuthorized;
  }
}
