import 'package:google_sign_in/google_sign_in.dart';

// https://github.com/flutter/plugins/blob/main/packages/google_sign_in/google_sign_in/example/lib/main.dart
class GoogleSignInRepository {
  final _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<String?> signIn() async {
    final account = await _googleSignIn.signIn();
    return account?.email;
  }
}
