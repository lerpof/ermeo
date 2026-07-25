import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:ermeo_mobile/features/auth/data/auth_repository.dart';
import 'package:ermeo_mobile/features/home/bloc/home_bloc.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late AuthRepository authRepository;

  setUp(() {
    authRepository = _MockAuthRepository();
  });

  group('HomeBloc', () {
    test('initial state', () {
      final bloc = HomeBloc(authRepository: authRepository);
      expect(bloc.state, const HomeState());
      bloc.close();
    });

    blocTest<HomeBloc, HomeState>(
      'emits navigateToLogin on logout success',
      build: () {
        when(() => authRepository.logout()).thenAnswer((_) async {});
        return HomeBloc(authRepository: authRepository);
      },
      act: (bloc) => bloc.add(const HomeLogoutRequested()),
      expect: () => [
        const HomeState(isLoggingOut: true),
        const HomeState(navigateToLogin: true),
      ],
      verify: (_) {
        verify(() => authRepository.logout()).called(1);
      },
    );

    blocTest<HomeBloc, HomeState>(
      'emits failureMessage on logout error',
      build: () {
        when(() => authRepository.logout()).thenThrow(Exception('logout failed'));
        return HomeBloc(authRepository: authRepository);
      },
      act: (bloc) => bloc.add(const HomeLogoutRequested()),
      expect: () => [
        const HomeState(isLoggingOut: true),
        HomeState(failureMessage: Exception('logout failed').toString()),
      ],
    );
  });
}
