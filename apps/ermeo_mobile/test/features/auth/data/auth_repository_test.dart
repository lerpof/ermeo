import 'package:ermeo_api/ermeo_api.dart' as api;
import 'package:ermeo_secure_storage/ermeo_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:dio/dio.dart';

import 'package:ermeo_mobile/core/session/session_service.dart';
import 'package:ermeo_mobile/core/session/session_state.dart';
import 'package:ermeo_mobile/features/auth/data/auth_repository.dart';
import 'package:ermeo_mobile/features/auth/data/auth_role_converter.dart';
import 'package:ermeo_mobile/features/auth/data/auth_status_converter.dart';
import 'package:ermeo_mobile/features/auth/models/auth_role.dart';
import 'package:ermeo_mobile/features/auth/models/auth_status.dart';

void main() {
  const tokensJson = {
    'accessToken': 'access-1',
    'refreshToken': 'refresh-1',
    'tokenType': 'bearer',
    'expiresIn': 3600,
  };

  late Dio dio;
  late DioAdapter adapter;
  late api.ErmeoApiClient apiClient;
  late AppSessionService sessionService;
  late AuthRepositoryImpl repository;

  setUp(() {
    dio = Dio(BaseOptions(baseUrl: 'https://api.test'));
    adapter = DioAdapter(dio: dio);
    apiClient = api.ErmeoApiClient(
      baseUrl: 'https://api.test',
      dio: dio,
    );
    sessionService = AppSessionService(
      tokenStorage: InMemoryTokenSecureStorage(),
    );
    repository = AuthRepositoryImpl(
      apiClient: apiClient,
      sessionService: sessionService,
    );
  });

  tearDown(() {
    repository.dispose();
  });

  group('AuthRoleConverter', () {
    const converter = AuthRoleConverter();

    test('maps all roles both ways', () {
      for (final role in AuthRole.values) {
        final apiRole = converter.fromInput(role);
        expect(converter.toInput(apiRole), role);
      }
    });
  });

  group('AuthStatusConverter', () {
    const converter = AuthStatusConverter();

    test('maps all statuses both ways', () {
      for (final status in SessionStatus.values) {
        final authStatus = converter.fromInput(status);
        expect(converter.toInput(authStatus), status);
      }
    });
  });

  group('AuthRepositoryImpl', () {
    test('currentStatus mirrors session and stream emits changes', () async {
      expect(repository.currentStatus, AuthStatus.unknown);

      final statuses = <AuthStatus>[];
      final sub = repository.authStateChanges.listen(statuses.add);

      await sessionService.clearSession();
      await sessionService.setSession(
        accessToken: 'a',
        refreshToken: 'r',
      );

      await Future<void>.delayed(Duration.zero);
      expect(repository.currentStatus, AuthStatus.authenticated);
      expect(statuses, contains(AuthStatus.unauthenticated));
      expect(statuses, contains(AuthStatus.authenticated));

      await sub.cancel();
    });

    test('login stores tokens on success', () async {
      adapter.onPost(
        '/auth/login',
        (server) => server.reply(200, tokensJson),
        data: Matchers.any,
      );

      await repository.login(email: 'a@b.com', password: 'password1');

      expect(sessionService.isAuthenticated, isTrue);
      expect(sessionService.readAccessToken(), 'access-1');
      expect(sessionService.readRefreshToken(), 'refresh-1');
    });

    test('login throws ApiException on failure', () async {
      adapter.onPost(
        '/auth/login',
        (server) => server.reply(401, {
          'code': 'invalid_credentials',
          'message': 'Bad credentials',
        }),
        data: Matchers.any,
      );

      await expectLater(
        repository.login(email: 'a@b.com', password: 'wrong'),
        throwsA(
          isA<api.ApiException>().having(
            (e) => e.message,
            'message',
            'Bad credentials',
          ),
        ),
      );
      expect(sessionService.isAuthenticated, isFalse);
    });

    test('signUp stores tokens on success', () async {
      adapter.onPost(
        '/auth/register',
        (server) => server.reply(201, tokensJson),
        data: Matchers.any,
      );

      await repository.signUp(
        email: 'a@b.com',
        password: 'password1',
        displayName: 'Alex',
        role: AuthRole.instructor,
      );

      expect(sessionService.isAuthenticated, isTrue);
      expect(sessionService.readAccessToken(), 'access-1');
    });

    test('signUp throws ApiException on failure', () async {
      adapter.onPost(
        '/auth/register',
        (server) => server.reply(409, {
          'code': 'email_taken',
          'message': 'Email already used',
        }),
        data: Matchers.any,
      );

      await expectLater(
        repository.signUp(
          email: 'a@b.com',
          password: 'password1',
          displayName: 'Alex',
          role: AuthRole.athlete,
        ),
        throwsA(isA<api.ApiException>()),
      );
    });

    test('logout clears session', () async {
      await sessionService.setSession(
        accessToken: 'a',
        refreshToken: 'r',
      );
      expect(sessionService.isAuthenticated, isTrue);

      await repository.logout();

      expect(sessionService.isAuthenticated, isFalse);
      expect(sessionService.readAccessToken(), isNull);
    });
  });
}
