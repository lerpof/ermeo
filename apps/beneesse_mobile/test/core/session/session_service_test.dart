import 'package:beneesse_mobile/core/session/session_service.dart';
import 'package:beneesse_mobile/core/session/session_state.dart';
import 'package:beneesse_secure_storage/beneesse_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

class _InMemoryTokenStorage implements TokenSecureStorage {
  SessionTokens? _tokens;

  @override
  Future<void> clearTokens() async => _tokens = null;

  @override
  Future<SessionTokens?> readTokens() async => _tokens;

  @override
  Future<void> writeTokens(SessionTokens tokens) async => _tokens = tokens;
}

void main() {
  group('SessionServiceImpl', () {
    late _InMemoryTokenStorage tokenStorage;
    late SessionServiceImpl service;

    setUp(() {
      tokenStorage = _InMemoryTokenStorage();
      service = SessionServiceImpl(
        tokenStorage: tokenStorage,
        baseUrl: 'https://api.test',
      );
    });

    test('restore authenticates when stored tokens exist', () async {
      await tokenStorage.writeTokens(
        const SessionTokens(
          accessToken: 'access',
          refreshToken: 'refresh',
        ),
      );

      await service.restore();

      expect(service.status, SessionStatus.authenticated);
      expect(service.readAccessToken(), 'access');
    });

    test('restore sets unauthenticated state when no tokens are stored', () async {
      await service.restore();

      expect(service.status, SessionStatus.unauthenticated);
      expect(service.isAuthenticated, isFalse);
      expect(service.readAccessToken(), isNull);
    });

    test('setSession writes tokens and authenticates', () async {
      await service.setSession(
        accessToken: 'access',
        refreshToken: 'refresh',
      );

      expect(service.status, SessionStatus.authenticated);
      expect(service.isAuthenticated, isTrue);
      expect(service.readAccessToken(), 'access');
      final stored = await tokenStorage.readTokens();
      expect(stored?.refreshToken, 'refresh');
    });

    test('clearSession removes tokens and unauthenticates', () async {
      await service.setSession(
        accessToken: 'access',
        refreshToken: 'refresh',
      );

      await service.clearSession();

      expect(service.status, SessionStatus.unauthenticated);
      expect(service.readAccessToken(), isNull);
      expect(await tokenStorage.readTokens(), isNull);
    });

    test('notifies listeners when auth state changes', () async {
      var notifications = 0;
      service.listenable.addListener(() => notifications++);

      await service.setSession(
        accessToken: 'access',
        refreshToken: 'refresh',
      );
      await service.clearSession();

      expect(notifications, 2);
    });
  });
}
