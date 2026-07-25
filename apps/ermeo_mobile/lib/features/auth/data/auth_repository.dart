import 'dart:async';

import 'package:ermeo_api/ermeo_api.dart' as api;

import 'package:ermeo_mobile/core/session/session_service.dart';
import 'package:ermeo_mobile/features/auth/data/auth_role_converter.dart';
import 'package:ermeo_mobile/features/auth/data/auth_status_converter.dart';
import 'package:ermeo_mobile/features/auth/models/auth_role.dart';
import 'package:ermeo_mobile/features/auth/models/auth_status.dart';

abstract class AuthRepository {
  Stream<AuthStatus> get authStateChanges;

  AuthStatus get currentStatus;

  Future<void> login({required String email, required String password});

  Future<void> signUp({
    required String email,
    required String password,
    required String displayName,
    required AuthRole role,
  });

  Future<void> logout();
}

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required this.apiClient,
    required this.sessionService,
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
  }

  @override
  Future<void> signUp({
    required String email,
    required String password,
    required String displayName,
    required AuthRole role,
  }) async {
    final tokens = await apiClient.run(() async {
      final response = await apiClient.auth.registerUser(
        api.RegisterRequest(
          email: email,
          password: password,
          displayName: displayName,
          role: roleConverter.fromInput(role),
        ),
      );
      return response.data!;
    });
    await sessionService.setSession(
      accessToken: tokens.accessToken,
      refreshToken: tokens.refreshToken,
    );
  }

  @override
  Future<void> logout() => sessionService.clearSession();

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
