// coverage:ignore-file
class RegisterRequest {
  RegisterRequest({
    required this.email,
    required this.password,
    required this.role,
    required this.displayName,
  });

  final String email;
  final String password;
  final String role;
  final String displayName;

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'role': role,
        'displayName': displayName,
      };
}

class LoginRequest {
  LoginRequest({required this.email, required this.password});

  final String email;
  final String password;

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}

class RefreshRequest {
  RefreshRequest({required this.refreshToken});

  final String refreshToken;

  Map<String, dynamic> toJson() => {'refreshToken': refreshToken};
}

class AuthTokens {
  AuthTokens({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.expiresIn,
  });

  factory AuthTokens.fromJson(Map<String, dynamic> json) => AuthTokens(
        accessToken: json['accessToken'] as String,
        refreshToken: json['refreshToken'] as String,
        tokenType: json['tokenType'] as String? ?? 'bearer',
        expiresIn: json['expiresIn'] as int,
      );

  final String accessToken;
  final String refreshToken;
  final String tokenType;
  final int expiresIn;
}
