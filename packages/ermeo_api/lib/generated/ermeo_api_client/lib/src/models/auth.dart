// coverage:ignore-file
enum UserRole {
  athlete,
  instructor,
  admin;

  String get value => name;
}

enum SelfServeRole {
  athlete,
  instructor;

  String get value => name;
}

enum FederatedProvider {
  google,
  apple;

  String get value => name;
}

class RegisterRequest {
  RegisterRequest({
    required this.email,
    required this.password,
    required this.displayName,
  });

  final String email;
  final String password;
  final String displayName;

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
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

class FederatedLoginRequest {
  FederatedLoginRequest({
    required this.provider,
    required this.idToken,
    this.accessToken,
    this.nonce,
  });

  final FederatedProvider provider;
  final String idToken;
  final String? accessToken;
  final String? nonce;

  Map<String, dynamic> toJson() => {
        'provider': provider.value,
        'idToken': idToken,
        if (accessToken != null) 'accessToken': accessToken,
        if (nonce != null) 'nonce': nonce,
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

class UserProfile {
  UserProfile({
    required this.id,
    required this.email,
    required this.displayName,
    required this.profileId,
    this.role,
    this.bio,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        id: json['id'] as String,
        email: json['email'] as String,
        displayName: json['displayName'] as String,
        profileId: json['profileId'] as String,
        role: json['role'] == null
            ? null
            : UserRole.values.byName(json['role'] as String),
        bio: json['bio'] as String?,
      );

  final String id;
  final String email;
  final String displayName;
  final String profileId;
  final UserRole? role;
  final String? bio;
}

class UpdateUserRequest {
  UpdateUserRequest({required this.role});

  final SelfServeRole role;

  Map<String, dynamic> toJson() => {'role': role.value};
}
