import 'package:beneesse_secure_storage/beneesse_secure_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late FlutterSecureStorage storage;
  late TokenSecureStorage secureStorage;

  setUp(() {
    storage = _MockFlutterSecureStorage();
    secureStorage = FlutterTokenSecureStorage(storage: storage);
  });

  group('readTokens', () {
    test('returns null when access token is missing', () async {
      when(() => storage.read(key: any(named: 'key'))).thenAnswer((invocation) {
        final key = invocation.namedArguments[#key] as String;
        return Future.value(key == 'auth.access_token' ? null : 'refresh');
      });

      final result = await secureStorage.readTokens();

      expect(result, isNull);
    });

    test('returns null when refresh token is missing', () async {
      when(() => storage.read(key: any(named: 'key'))).thenAnswer((invocation) {
        final key = invocation.namedArguments[#key] as String;
        return Future.value(key == 'auth.refresh_token' ? null : 'access');
      });

      final result = await secureStorage.readTokens();

      expect(result, isNull);
    });

    test('returns tokens when both keys exist', () async {
      when(() => storage.read(key: any(named: 'key'))).thenAnswer((invocation) {
        final key = invocation.namedArguments[#key] as String;
        return Future.value(
          key == 'auth.access_token' ? 'access-token' : 'refresh-token',
        );
      });

      final result = await secureStorage.readTokens();

      expect(result, isNotNull);
      expect(result!.accessToken, 'access-token');
      expect(result.refreshToken, 'refresh-token');
    });
  });

  test('writeTokens writes both token keys', () async {
    when(() => storage.write(key: any(named: 'key'), value: any(named: 'value')))
        .thenAnswer((_) async {});

    await secureStorage.writeTokens(
      const SessionTokens(
        accessToken: 'access-token',
        refreshToken: 'refresh-token',
      ),
    );

    verify(
      () => storage.write(key: 'auth.access_token', value: 'access-token'),
    ).called(1);
    verify(
      () => storage.write(key: 'auth.refresh_token', value: 'refresh-token'),
    ).called(1);
    verifyNoMoreInteractions(storage);
  });

  test('clearTokens deletes both token keys', () async {
    when(() => storage.delete(key: any(named: 'key'))).thenAnswer((_) async {});

    await secureStorage.clearTokens();

    verify(() => storage.delete(key: 'auth.access_token')).called(1);
    verify(() => storage.delete(key: 'auth.refresh_token')).called(1);
    verifyNoMoreInteractions(storage);
  });
}
