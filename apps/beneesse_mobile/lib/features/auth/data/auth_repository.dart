import 'package:beneesse_api/beneesse_api.dart';

import '../../../core/di/service_locator.dart';

abstract class AuthRepository {
  Future<void> login({
    required String email,
    required String password,
  });

  Future<void> register({
    required String email,
    required String password,
    required String displayName,
    required UserRole role,
  });
}

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({BeneesseApiClient? apiClient})
      : _api = apiClient ?? ServiceLocator.instance.apiClient;

  final BeneesseApiClient _api;

  @override
  Future<void> login({
    required String email,
    required String password,
  }) async {
    final tokens = await _api.run(
      () => _api.auth
          .loginUser(LoginRequest(email: email, password: password))
          .then((r) => r.data!),
    );
    ServiceLocator.instance.setSession(
      accessToken: tokens.accessToken,
      refreshToken: tokens.refreshToken,
    );
  }

  @override
  Future<void> register({
    required String email,
    required String password,
    required String displayName,
    required UserRole role,
  }) async {
    final tokens = await _api.run(
      () => _api.auth
          .registerUser(
            RegisterRequest(
              email: email,
              password: password,
              displayName: displayName,
              role: role,
            ),
          )
          .then((r) => r.data!),
    );
    ServiceLocator.instance.setSession(
      accessToken: tokens.accessToken,
      refreshToken: tokens.refreshToken,
    );
  }
}
