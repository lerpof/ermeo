import 'package:beneesse_api/beneesse_api.dart';
import 'package:beneesse_mobile/core/di/service_locator.dart';
import 'package:beneesse_mobile/features/auth/data/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockBeneesseApiClient extends Mock implements BeneesseApiClient {}

class _MockAuthApi extends Mock implements AuthApi {}

void main() {
  group('AuthRepositoryImpl', () {
    late _MockBeneesseApiClient apiClient;
    late _MockAuthApi authApi;
    late AuthRepositoryImpl repository;

    setUpAll(() {
      ServiceLocator.instance.init(baseUrl: 'https://api.test');
      registerFallbackValue(
        LoginRequest(email: 'a@b.com', password: 'password'),
      );
      registerFallbackValue(
        RegisterRequest(
          email: 'a@b.com',
          password: 'password',
          displayName: 'User',
          role: UserRole.athlete,
        ),
      );
    });

    setUp(() {
      apiClient = _MockBeneesseApiClient();
      authApi = _MockAuthApi();
      when(() => apiClient.auth).thenReturn(authApi);
      when(() => apiClient.run<AuthTokens>(any())).thenAnswer(
        (invocation) async {
          final call =
              invocation.positionalArguments[0] as Future<AuthTokens> Function();
          return call();
        },
      );
      repository = AuthRepositoryImpl(apiClient: apiClient);
    });

    tearDown(ServiceLocator.instance.clearSession);

    test('login stores session on success', () async {
      when(() => authApi.loginUser(any())).thenAnswer(
        (_) async => Response(
          data: AuthTokens(
            accessToken: 'access',
            refreshToken: 'refresh',
            tokenType: 'bearer',
            expiresIn: 3600,
          ),
          requestOptions: RequestOptions(path: '/auth/login'),
        ),
      );

      await repository.login(email: 'user@test.com', password: 'password1');

      expect(ServiceLocator.instance.isAuthenticated, isTrue);
      verify(() => authApi.loginUser(any())).called(1);
    });

    test('register stores session on success', () async {
      when(() => authApi.registerUser(any())).thenAnswer(
        (_) async => Response(
          data: AuthTokens(
            accessToken: 'access',
            refreshToken: 'refresh',
            tokenType: 'bearer',
            expiresIn: 3600,
          ),
          requestOptions: RequestOptions(path: '/auth/register'),
        ),
      );

      await repository.register(
        email: 'user@test.com',
        password: 'password1',
        displayName: 'User',
        role: UserRole.instructor,
      );

      expect(ServiceLocator.instance.isAuthenticated, isTrue);
      verify(() => authApi.registerUser(any())).called(1);
    });

    test('login propagates ApiException on failure', () async {
      when(() => apiClient.run<AuthTokens>(any())).thenThrow(
        const ApiException(
          statusCode: 401,
          code: 'unauthorized',
          message: 'Invalid credentials',
        ),
      );

      await expectLater(
        repository.login(email: 'user@test.com', password: 'wrongpass'),
        throwsA(isA<ApiException>()),
      );
      expect(ServiceLocator.instance.isAuthenticated, isFalse);
    });
  });
}
