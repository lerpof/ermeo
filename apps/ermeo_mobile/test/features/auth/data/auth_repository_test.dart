import 'package:ermeo_api/ermeo_api.dart' as api;
import 'package:ermeo_secure_storage/ermeo_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';

import 'package:ermeo_mobile/core/session/session_service.dart';
import 'package:ermeo_mobile/core/session/session_state.dart';
import 'package:ermeo_mobile/features/auth/data/auth_repository.dart';
import 'package:ermeo_mobile/features/auth/data/auth_role_converter.dart';
import 'package:ermeo_mobile/features/auth/data/auth_status_converter.dart';
import 'package:ermeo_mobile/features/auth/data/federated_auth_gateway.dart';
import 'package:ermeo_mobile/features/auth/models/auth_role.dart';
import 'package:ermeo_mobile/features/auth/models/auth_status.dart';

class _MockFederatedAuthGateway extends Mock implements FederatedAuthGateway {}

void main() {
  const tokensJson = {
    'accessToken': 'access-1',
    'refreshToken': 'refresh-1',
    'tokenType': 'bearer',
    'expiresIn': 3600,
  };

  const profileJson = {
    'id': 'uid-1',
    'email': 'a@b.com',
    'displayName': 'Alex',
    'profileId': '11111111-1111-1111-1111-111111111111',
    'role': null,
  };

  late Dio dio;
  late DioAdapter adapter;
  late api.ErmeoApiClient apiClient;
  late AppSessionService sessionService;
  late FederatedAuthGateway federatedAuthGateway;
  late AuthRepositoryImpl repository;

  setUpAll(() {
    registerFallbackValue(
      const FederatedCredentials(
        provider: api.FederatedProvider.google,
        idToken: 'token',
      ),
    );
  });

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
    federatedAuthGateway = _MockFederatedAuthGateway();
    repository = AuthRepositoryImpl(
      apiClient: apiClient,
      sessionService: sessionService,
      federatedAuthGateway: federatedAuthGateway,
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

    test('login stores tokens and loads profile', () async {
      adapter
        ..onPost(
          '/auth/login',
          (server) => server.reply(200, tokensJson),
          data: Matchers.any,
        )
        ..onGet(
          '/users/me',
          (server) => server.reply(200, {
            ...profileJson,
            'role': 'athlete',
          }),
        );

      await repository.login(email: 'a@b.com', password: 'password1');

      expect(sessionService.isAuthenticated, isTrue);
      expect(sessionService.readAccessToken(), 'access-1');
      expect(sessionService.role, AuthRole.athlete);
      expect(sessionService.needsOnboarding, isFalse);
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

    test('signUp stores tokens and marks onboarding needed', () async {
      adapter
        ..onPost(
          '/auth/register',
          (server) => server.reply(201, tokensJson),
          data: Matchers.any,
        )
        ..onGet(
          '/users/me',
          (server) => server.reply(200, profileJson),
        );

      await repository.signUp(
        email: 'a@b.com',
        password: 'password1',
        displayName: 'Alex',
      );

      expect(sessionService.isAuthenticated, isTrue);
      expect(sessionService.needsOnboarding, isTrue);
    });

    test('loginWithGoogle exchanges provider token', () async {
      when(() => federatedAuthGateway.signInWithGoogle()).thenAnswer(
        (_) async => const FederatedCredentials(
          provider: api.FederatedProvider.google,
          idToken: 'google-id',
          accessToken: 'google-access',
        ),
      );
      adapter
        ..onPost(
          '/auth/federated',
          (server) => server.reply(200, tokensJson),
          data: Matchers.any,
        )
        ..onGet(
          '/users/me',
          (server) => server.reply(200, profileJson),
        );

      await repository.loginWithGoogle();

      expect(sessionService.isAuthenticated, isTrue);
      expect(sessionService.needsOnboarding, isTrue);
    });

    test('completeOnboarding sets role once', () async {
      await sessionService.setSession(
        accessToken: 'access-1',
        refreshToken: 'refresh-1',
      );
      sessionService.setProfile(role: null);

      adapter.onPatch(
        '/users/me',
        (server) => server.reply(200, {
          ...profileJson,
          'role': 'instructor',
        }),
        data: Matchers.any,
      );

      await repository.completeOnboarding(role: AuthRole.instructor);

      expect(sessionService.role, AuthRole.instructor);
      expect(sessionService.needsOnboarding, isFalse);
    });

    test('logout clears session', () async {
      await sessionService.setSession(
        accessToken: 'a',
        refreshToken: 'r',
      );
      sessionService.setProfile(role: AuthRole.athlete);
      expect(sessionService.isAuthenticated, isTrue);

      await repository.logout();

      expect(sessionService.isAuthenticated, isFalse);
      expect(sessionService.readAccessToken(), isNull);
      expect(sessionService.role, isNull);
    });
  });
}
