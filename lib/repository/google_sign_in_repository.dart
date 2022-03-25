
import 'package:thespot/data/model/auth_employee.dart';

abstract class GoogleSignInRepository {
  Future<AuthEmployee> signIn();
}
