import 'package:beneesse_mobile/core/di/service_locator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ServiceLocator', () {
    setUp(() {
      ServiceLocator.instance.init(baseUrl: 'https://api.test');
    });

    tearDown(() {
      ServiceLocator.instance.clearSession();
    });

    test('isAuthenticated is false without tokens', () {
      expect(ServiceLocator.instance.isAuthenticated, isFalse);
    });

    test('setSession stores tokens and reports authenticated', () {
      ServiceLocator.instance.setSession(
        accessToken: 'access',
        refreshToken: 'refresh',
      );

      expect(ServiceLocator.instance.isAuthenticated, isTrue);
    });

    test('clearSession removes tokens', () {
      ServiceLocator.instance.setSession(
        accessToken: 'access',
        refreshToken: 'refresh',
      );

      ServiceLocator.instance.clearSession();

      expect(ServiceLocator.instance.isAuthenticated, isFalse);
    });

    test('sessionNotifier notifies listeners on session change', () {
      var notifications = 0;
      ServiceLocator.instance.sessionNotifier.addListener(() {
        notifications++;
      });

      ServiceLocator.instance.setSession(
        accessToken: 'access',
        refreshToken: 'refresh',
      );
      ServiceLocator.instance.clearSession();

      expect(notifications, 2);
    });
  });
}
