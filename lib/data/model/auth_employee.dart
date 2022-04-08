import 'package:google_sign_in/google_sign_in.dart';

class AuthEmployee {
  String email;
  String? name;
  String? photoUrl;

  AuthEmployee({
    required this.email,
    required this.name,
    required this.photoUrl,
  });

  factory AuthEmployee.initial() =>
      AuthEmployee(email: '', name: null, photoUrl: null);

  set(AuthEmployee auth) {
    email = auth.email;
    name = auth.name;
    photoUrl = auth.photoUrl;
  }

  factory AuthEmployee.fromGoogleSignAccount(GoogleSignInAccount account) {
    return AuthEmployee(
      email: account.email,
      name: account.displayName,
      photoUrl: account.photoUrl,
    );
  }

  @override
  String toString() => 'User(email: $email, name: $name, photoUrl: $photoUrl)';
}
