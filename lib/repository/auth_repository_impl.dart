import 'package:thespot/data/model/employee_email.dart';
import 'package:thespot/data/provider/auth_provider.dart';
import 'package:thespot/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthProvider provider;

  const AuthRepositoryImpl({
    required this.provider,
  });

  @override
  Future<bool> isAuthorized(String email) async {
    final response = await provider.isAuthorized(EmployeeEmailRequest(email));
    return response.isAuthorized;
  }
}
