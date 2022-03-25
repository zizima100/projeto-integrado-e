import 'package:google_sign_in/google_sign_in.dart';
import 'package:thespot/data/exceptions/auth_exceptions.dart';
import 'package:thespot/data/model/auth_employee.dart';
import 'google_sign_in_repository.dart';

// https://github.com/flutter/plugins/blob/main/packages/google_sign_in/google_sign_in/example/lib/main.dart
class GoogleSignInRepositoryImpl implements GoogleSignInRepository {
  late final GoogleSignIn _googleSignIn;

  GoogleSignInRepositoryImpl() {
    _googleSignIn = GoogleSignIn(
      scopes: <String>[
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
  }

  @override
  Future<AuthEmployee> signIn() async {
    try {
      final account = await _googleSignIn.signIn();
      if (account == null) {
        throw const GoogleSignInException();
      }
      return AuthEmployee.fromGoogleSignAccount(account);
    } catch (e) {
      throw const GoogleSignInException();
    }
  }
}
