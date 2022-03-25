import 'package:google_sign_in/google_sign_in.dart';

class AuthEmployee {
  final String email;
  final String? name;
  final String? photoUrl;

  const AuthEmployee({
    required this.email,
    required this.name,
    required this.photoUrl,
  });

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
