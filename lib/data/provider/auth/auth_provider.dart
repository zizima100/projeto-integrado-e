import 'package:thespot/data/model/auth_response.dart';
import 'package:thespot/data/model/employee_email.dart';

abstract class AuthProvider {
  Future<AuthResponse> isAuthorized(EmployeeEmailRequest email);
}
