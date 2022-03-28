import 'dart:convert';

class AuthResponse {
  final bool isAuthorized;

  AuthResponse({
    required this.isAuthorized,
  });

  factory AuthResponse.fromMap(Map<String, dynamic> map) {
    return AuthResponse(
      isAuthorized: map['authorized'] ?? false,
    );
  }

  factory AuthResponse.fromJson(String source) =>
      AuthResponse.fromMap(json.decode(source));

  @override
  String toString() => 'AuthResponse(isAuthorized: $isAuthorized)';
}
