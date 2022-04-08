import 'package:thespot/data/model/auth_employee.dart';

abstract class SsoRepository {
  Future<AuthEmployee> signIn();
}
