import 'dart:convert';

class AuthResponse {
  final bool isAuthorized;

  AuthResponse({
    required this.isAuthorized,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'isAuthorized': isAuthorized});
  
    return result;
  }

  factory AuthResponse.fromMap(Map<String, dynamic> map) {
    return AuthResponse(
      isAuthorized: map['isAuthorized'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthResponse.fromJson(String source) => AuthResponse.fromMap(json.decode(source));
}
