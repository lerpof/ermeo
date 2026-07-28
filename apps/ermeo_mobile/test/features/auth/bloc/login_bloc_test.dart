import 'package:bloc_test/bloc_test.dart';
import 'package:ermeo_api/ermeo_api.dart';
import 'package:ermeo_secure_storage/ermeo_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:ermeo_mobile/core/session/session_service.dart';
import 'package:ermeo_mobile/features/auth/bloc/login/login_bloc.dart';
import 'package:ermeo_mobile/features/auth/data/auth_repository.dart';
import 'package:ermeo_mobile/features/auth/data/federated_auth_gateway.dart';
import 'package:ermeo_mobile/features/auth/models/auth_role.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late AuthRepository authRepository;
  late AppSessionService sessionService;

  setUp(() {
    authRepository = _MockAuthRepository();
    sessionService = AppSessionService(
      tokenStorage: InMemoryTokenSecureStorage(),
    );
  });

  LoginBloc buildBloc() => LoginBloc(
        authRepository: authRepository,
        sessionService: sessionService,
      );

  group('LoginBloc', () {
    test('initial state is empty', () {
      final bloc = buildBloc();
      expect(bloc.state, const LoginState());
      bloc.close();
    });

    blocTest<LoginBloc, LoginState>(
      'emits updated email on LoginEmailChanged',
      build: buildBloc,
      act: (bloc) => bloc.add(const LoginEmailChanged('a@b.com')),
      expect: () => [
        const LoginState(email: 'a@b.com'),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'emits updated password on LoginPasswordChanged',
      build: buildBloc,
      act: (bloc) => bloc.add(const LoginPasswordChanged('secret')),
      expect: () => [
        const LoginState(password: 'secret'),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'emits emailRequired when email is empty',
      build: buildBloc,
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
      build: buildBloc,
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
      'emits home navigation when profile has role',
      build: () {
        when(
          () => authRepository.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async {
          await sessionService.setSession(
            accessToken: 'a',
            refreshToken: 'r',
          );
          sessionService.setProfile(role: AuthRole.athlete);
        });
        return buildBloc();
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
    );

    blocTest<LoginBloc, LoginState>(
      'emits role selection navigation when role is missing',
      build: () {
        when(
          () => authRepository.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async {
          await sessionService.setSession(
            accessToken: 'a',
            refreshToken: 'r',
          );
          sessionService.setProfile(role: null);
        });
        return buildBloc();
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
          navigateToRoleSelection: true,
        ),
      ],
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
        return buildBloc();
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
        return buildBloc();
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

    blocTest<LoginBloc, LoginState>(
      'clears submitting when Google sign-in is cancelled',
      build: () {
        when(() => authRepository.loginWithGoogle()).thenThrow(
          const FederatedAuthCancelledException(),
        );
        return buildBloc();
      },
      act: (bloc) => bloc.add(const LoginGooglePressed()),
      expect: () => [
        const LoginState(isSubmitting: true),
        const LoginState(),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'navigates home after Google success with role',
      build: () {
        when(() => authRepository.loginWithGoogle()).thenAnswer((_) async {
          await sessionService.setSession(
            accessToken: 'a',
            refreshToken: 'r',
          );
          sessionService.setProfile(role: AuthRole.instructor);
        });
        return buildBloc();
      },
      act: (bloc) => bloc.add(const LoginGooglePressed()),
      expect: () => [
        const LoginState(isSubmitting: true),
        const LoginState(navigateToHome: true),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'navigates home after Apple success with role',
      build: () {
        when(() => authRepository.loginWithApple()).thenAnswer((_) async {
          await sessionService.setSession(
            accessToken: 'a',
            refreshToken: 'r',
          );
          sessionService.setProfile(role: AuthRole.athlete);
        });
        return buildBloc();
      },
      act: (bloc) => bloc.add(const LoginApplePressed()),
      expect: () => [
        const LoginState(isSubmitting: true),
        const LoginState(navigateToHome: true),
      ],
    );
  });
}
