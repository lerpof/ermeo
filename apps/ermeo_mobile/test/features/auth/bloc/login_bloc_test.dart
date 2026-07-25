import 'package:bloc_test/bloc_test.dart';
import 'package:ermeo_api/ermeo_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:ermeo_mobile/features/auth/bloc/login/login_bloc.dart';
import 'package:ermeo_mobile/features/auth/data/auth_repository.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late AuthRepository authRepository;

  setUp(() {
    authRepository = _MockAuthRepository();
  });

  group('LoginBloc', () {
    test('initial state is empty', () {
      final bloc = LoginBloc(authRepository: authRepository);
      expect(bloc.state, const LoginState());
      bloc.close();
    });

    blocTest<LoginBloc, LoginState>(
      'emits updated email on LoginEmailChanged',
      build: () => LoginBloc(authRepository: authRepository),
      act: (bloc) => bloc.add(const LoginEmailChanged('a@b.com')),
      expect: () => [
        const LoginState(email: 'a@b.com'),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'emits updated password on LoginPasswordChanged',
      build: () => LoginBloc(authRepository: authRepository),
      act: (bloc) => bloc.add(const LoginPasswordChanged('secret')),
      expect: () => [
        const LoginState(password: 'secret'),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'emits emailRequired when email is empty',
      build: () => LoginBloc(authRepository: authRepository),
      seed: () => const LoginState(password: 'password'),
      act: (bloc) => bloc.add(const LoginSubmitted()),
      expect: () => [
        const LoginState(
          password: 'password',
          failure: LoginFailure.validation(LoginValidationError.emailRequired),
        ),
      ],
      verify: (_) {
        verifyNever(
          () => authRepository.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        );
      },
    );

    blocTest<LoginBloc, LoginState>(
      'emits passwordRequired when password is empty',
      build: () => LoginBloc(authRepository: authRepository),
      seed: () => const LoginState(email: 'a@b.com'),
      act: (bloc) => bloc.add(const LoginSubmitted()),
      expect: () => [
        const LoginState(
          email: 'a@b.com',
          failure: LoginFailure.validation(
            LoginValidationError.passwordRequired,
          ),
        ),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'emits success navigation on login success',
      build: () {
        when(
          () => authRepository.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async {});
        return LoginBloc(authRepository: authRepository);
      },
      seed: () => const LoginState(email: ' a@b.com ', password: 'password'),
      act: (bloc) => bloc.add(const LoginSubmitted()),
      expect: () => [
        const LoginState(
          email: ' a@b.com ',
          password: 'password',
          isSubmitting: true,
        ),
        const LoginState(
          email: ' a@b.com ',
          password: 'password',
          navigateToHome: true,
        ),
      ],
      verify: (_) {
        verify(
          () => authRepository.login(email: 'a@b.com', password: 'password'),
        ).called(1);
      },
    );

    blocTest<LoginBloc, LoginState>(
      'emits api failure on ApiException',
      build: () {
        when(
          () => authRepository.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(
          const ApiException(
            statusCode: 401,
            code: 'invalid_credentials',
            message: 'Bad credentials',
          ),
        );
        return LoginBloc(authRepository: authRepository);
      },
      seed: () => const LoginState(email: 'a@b.com', password: 'password'),
      act: (bloc) => bloc.add(const LoginSubmitted()),
      expect: () => [
        const LoginState(
          email: 'a@b.com',
          password: 'password',
          isSubmitting: true,
        ),
        const LoginState(
          email: 'a@b.com',
          password: 'password',
          failure: LoginFailure.api('Bad credentials'),
        ),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'emits api failure on unexpected error',
      build: () {
        when(
          () => authRepository.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(Exception('boom'));
        return LoginBloc(authRepository: authRepository);
      },
      seed: () => const LoginState(email: 'a@b.com', password: 'password'),
      act: (bloc) => bloc.add(const LoginSubmitted()),
      expect: () => [
        const LoginState(
          email: 'a@b.com',
          password: 'password',
          isSubmitting: true,
        ),
        LoginState(
          email: 'a@b.com',
          password: 'password',
          failure: LoginFailure.api(Exception('boom').toString()),
        ),
      ],
    );
  });
}
