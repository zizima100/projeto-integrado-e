import 'package:google_sign_in/google_sign_in.dart';
import 'package:thespot/data/model/auth_employee.dart';
import 'sso_repository.dart';

// https://github.com/flutter/plugins/blob/main/packages/google_sign_in/google_sign_in/example/lib/main.dart
class GoogleSignInRepository implements SsoRepository {
  late final GoogleSignIn _googleSignIn;

  GoogleSignInRepository() {
    _googleSignIn = GoogleSignIn(
      scopes: <String>[
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
  }

  @override
  Future<AuthEmployee> signIn() async {
    final account = await _googleSignIn.signIn();
    if (account == null) {
      throw Exception();
    }
    return AuthEmployee.fromGoogleSignAccount(account);
  }
}
