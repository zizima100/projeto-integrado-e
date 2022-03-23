import 'package:thespot/models/user_model.dart';

abstract class GoogleSignInRepository {
  Future<User> signIn();
}
