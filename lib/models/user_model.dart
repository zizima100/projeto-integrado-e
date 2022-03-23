import 'package:google_sign_in/google_sign_in.dart';

class User {
  final String email;
  final String? name;
  final String? photoUrl;

  const User({
    required this.email,
    required this.name,
    required this.photoUrl,
  });

  factory User.fromGoogleSignAccount(GoogleSignInAccount account) {
    return User(
      email: account.email,
      name: account.displayName,
      photoUrl: account.photoUrl,
    );
  }

  @override
  String toString() => 'User(email: $email, name: $name, photoUrl: $photoUrl)';
}
