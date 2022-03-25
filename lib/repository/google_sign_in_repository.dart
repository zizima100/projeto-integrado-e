
import 'package:thespot/data/model/auth_user.dart';

abstract class GoogleSignInRepository {
  Future<AuthUser> signIn();
}
