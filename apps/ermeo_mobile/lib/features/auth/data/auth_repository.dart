import 'dart:async';

import 'package:ermeo_api/ermeo_api.dart' as api;

import 'package:ermeo_mobile/core/session/session_service.dart';
import 'package:ermeo_mobile/features/auth/data/auth_role_converter.dart';
import 'package:ermeo_mobile/features/auth/data/auth_status_converter.dart';
import 'package:ermeo_mobile/features/auth/data/federated_auth_gateway.dart';
import 'package:ermeo_mobile/features/auth/models/auth_role.dart';
import 'package:ermeo_mobile/features/auth/models/auth_status.dart';

abstract class AuthRepository {
  Stream<AuthStatus> get authStateChanges;

  AuthStatus get currentStatus;

  Future<void> login({required String email, required String password});

  Future<void> loginWithGoogle();

  Future<void> loginWithApple();

  Future<void> signUp({
    required String email,
    required String password,
    required String displayName,
  });

  Future<void> refreshProfile();

  Future<void> completeOnboarding({required AuthRole role});

  Future<void> logout();
}

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required this.apiClient,
    required this.sessionService,
    required this.federatedAuthGateway,
    this.roleConverter = const AuthRoleConverter(),
    this.statusConverter = const AuthStatusConverter(),
  }) {
    _controller = StreamController<AuthStatus>.broadcast(
      onListen: () {
        if (!_controller.isClosed) {
          _controller.add(currentStatus);
        }
      },
    );
    sessionService.addListener(_onSessionChanged);
  }

  final api.ErmeoApiClient apiClient;
  final AppSessionService sessionService;
  final FederatedAuthGateway federatedAuthGateway;
  final AuthRoleConverter roleConverter;
  final AuthStatusConverter statusConverter;
  late final StreamController<AuthStatus> _controller;

  @override
  Stream<AuthStatus> get authStateChanges => _controller.stream;

  @override
  AuthStatus get currentStatus =>
      statusConverter.fromInput(sessionService.status);

  @override
  Future<void> login({
    required String email,
    required String password,
  }) async {
    final tokens = await apiClient.run(() async {
      final response = await apiClient.auth.loginUser(
        api.LoginRequest(email: email, password: password),
      );
      return response.data!;
    });
    await sessionService.setSession(
      accessToken: tokens.accessToken,
      refreshToken: tokens.refreshToken,
    );
    await refreshProfile();
  }

  @override
  Future<void> loginWithGoogle() async {
    final credentials = await federatedAuthGateway.signInWithGoogle();
    await _federatedLogin(credentials);
  }

  @override
  Future<void> loginWithApple() async {
    final credentials = await federatedAuthGateway.signInWithApple();
    await _federatedLogin(credentials);
  }

  @override
  Future<void> signUp({
    required String email,
    required String password,
    required String displayName,
  }) async {
    final tokens = await apiClient.run(() async {
      final response = await apiClient.auth.registerUser(
        api.RegisterRequest(
          email: email,
          password: password,
          displayName: displayName,
        ),
      );
      return response.data!;
    });
    await sessionService.setSession(
      accessToken: tokens.accessToken,
      refreshToken: tokens.refreshToken,
    );
    await refreshProfile();
  }

  @override
  Future<void> refreshProfile() async {
    final profile = await apiClient.run(() async {
      final response = await apiClient.users.getCurrentUser();
      return response.data!;
    });
    sessionService.setProfile(
      role: profile.role == null ? null : roleConverter.toInput(profile.role!),
    );
  }

  @override
  Future<void> completeOnboarding({required AuthRole role}) async {
    if (role == AuthRole.admin) {
      throw ArgumentError.value(role, 'role', 'Admin is not self-serve');
    }
    final selfServeRole = switch (role) {
      AuthRole.athlete => api.SelfServeRole.athlete,
      AuthRole.instructor => api.SelfServeRole.instructor,
      AuthRole.admin => throw ArgumentError.value(role, 'role'),
    };
    final profile = await apiClient.run(() async {
      final response = await apiClient.users.updateCurrentUser(
        api.UpdateUserRequest(role: selfServeRole),
      );
      return response.data!;
    });
    sessionService.setProfile(
      role: profile.role == null ? null : roleConverter.toInput(profile.role!),
    );
  }

  @override
  Future<void> logout() => sessionService.clearSession();

  Future<void> _federatedLogin(FederatedCredentials credentials) async {
    final tokens = await apiClient.run(() async {
      final response = await apiClient.auth.federatedLogin(
        api.FederatedLoginRequest(
          provider: credentials.provider,
          idToken: credentials.idToken,
          accessToken: credentials.accessToken,
          nonce: credentials.nonce,
        ),
      );
      return response.data!;
    });
    await sessionService.setSession(
      accessToken: tokens.accessToken,
      refreshToken: tokens.refreshToken,
    );
    await refreshProfile();
  }

  void dispose() {
    sessionService.removeListener(_onSessionChanged);
    unawaited(_controller.close());
  }

  void _onSessionChanged() {
    if (!_controller.isClosed) {
      _controller.add(currentStatus);
    }
  }
}
