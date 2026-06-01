import 'package:beneesse_api/beneesse_api.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:beneesse_mobile/features/auth/bloc/auth_bloc.dart';
import 'package:beneesse_mobile/features/auth/bloc/auth_event.dart';
import 'package:beneesse_mobile/features/auth/bloc/auth_state.dart';
import 'package:beneesse_mobile/features/auth/data/auth_repository.dart';
import 'package:beneesse_mobile/features/auth/models/auth_mode.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late _MockAuthRepository authRepository;

  setUp(() {
    authRepository = _MockAuthRepository();
  });

  AuthBloc buildBloc() => AuthBloc(authRepository: authRepository);

  group('AuthBloc', () {
    blocTest<AuthBloc, AuthState>(
      'toggles to signup mode',
      build: buildBloc,
      act: (bloc) => bloc.add(const AuthModeToggled(AuthMode.signup)),
      expect: () => [
        isA<AuthState>()
            .having((s) => s.mode, 'mode', AuthMode.signup)
            .having((s) => s.isSignup, 'isSignup', true)
            .having((s) => s.appBarTitle, 'appBarTitle', 'Create account')
            .having((s) => s.submitButtonLabel, 'submit', 'Create account'),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'updates email and clears error',
      build: buildBloc,
      seed: () => const AuthState(errorMessage: 'Old error'),
      act: (bloc) => bloc.add(const AuthEmailChanged('a@b.com')),
      expect: () => [
        isA<AuthState>()
            .having((s) => s.email, 'email', 'a@b.com')
            .having((s) => s.errorMessage, 'error', isNull),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'updates password display name and role',
      build: buildBloc,
      act: (bloc) {
        bloc
          ..add(const AuthPasswordChanged('password1'))
          ..add(const AuthDisplayNameChanged('Alex'))
          ..add(const AuthRoleChanged(UserRole.instructor));
      },
      expect: () => [
        isA<AuthState>().having((s) => s.password, 'password', 'password1'),
        isA<AuthState>()
            .having((s) => s.password, 'password', 'password1')
            .having((s) => s.displayName, 'displayName', 'Alex'),
        isA<AuthState>()
            .having((s) => s.password, 'password', 'password1')
            .having((s) => s.displayName, 'displayName', 'Alex')
            .having((s) => s.role, 'role', UserRole.instructor),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'fails validation for empty email',
      build: buildBloc,
      act: (bloc) => bloc.add(const AuthSubmitted()),
      expect: () => [
        isA<AuthState>()
            .having((s) => s.status, 'status', AuthStatus.failure)
            .having((s) => s.errorMessage, 'error', 'Email is required'),
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

    blocTest<AuthBloc, AuthState>(
      'fails validation for invalid email',
      build: buildBloc,
      seed: () => const AuthState(email: 'not-an-email', password: 'password1'),
      act: (bloc) => bloc.add(const AuthSubmitted()),
      expect: () => [
        isA<AuthState>().having(
          (s) => s.errorMessage,
          'error',
          'Enter a valid email address',
        ),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'fails validation for short password',
      build: buildBloc,
      seed: () => const AuthState(email: 'a@b.com', password: 'short'),
      act: (bloc) => bloc.add(const AuthSubmitted()),
      expect: () => [
        isA<AuthState>().having(
          (s) => s.errorMessage,
          'error',
          'Password must be at least 8 characters',
        ),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'fails validation for missing display name on signup',
      build: buildBloc,
      seed: () => const AuthState(
        mode: AuthMode.signup,
        isSignup: true,
        email: 'a@b.com',
        password: 'password1',
      ),
      act: (bloc) => bloc.add(const AuthSubmitted()),
      expect: () => [
        isA<AuthState>().having(
          (s) => s.errorMessage,
          'error',
          'Display name is required',
        ),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'login succeeds',
      build: buildBloc,
      seed: () => const AuthState(email: 'a@b.com', password: 'password1'),
      setUp: () {
        when(
          () => authRepository.login(
            email: 'a@b.com',
            password: 'password1',
          ),
        ).thenAnswer((_) async {});
      },
      act: (bloc) => bloc.add(const AuthSubmitted()),
      expect: () => [
        isA<AuthState>().having((s) => s.status, 'status', AuthStatus.loading),
        isA<AuthState>().having((s) => s.status, 'status', AuthStatus.success),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'signup succeeds',
      build: buildBloc,
      seed: () => const AuthState(
        mode: AuthMode.signup,
        isSignup: true,
        email: 'a@b.com',
        password: 'password1',
        displayName: 'Alex',
        role: UserRole.instructor,
      ),
      setUp: () {
        when(
          () => authRepository.register(
            email: 'a@b.com',
            password: 'password1',
            displayName: 'Alex',
            role: UserRole.instructor,
          ),
        ).thenAnswer((_) async {});
      },
      act: (bloc) => bloc.add(const AuthSubmitted()),
      expect: () => [
        isA<AuthState>().having((s) => s.status, 'status', AuthStatus.loading),
        isA<AuthState>().having((s) => s.status, 'status', AuthStatus.success),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'maps ApiException to failure message',
      build: buildBloc,
      seed: () => const AuthState(email: 'a@b.com', password: 'password1'),
      setUp: () {
        when(
          () => authRepository.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(
          const ApiException(
            statusCode: 401,
            code: 'unauthorized',
            message: 'Invalid credentials',
          ),
        );
      },
      act: (bloc) => bloc.add(const AuthSubmitted()),
      expect: () => [
        isA<AuthState>().having((s) => s.status, 'status', AuthStatus.loading),
        isA<AuthState>()
            .having((s) => s.status, 'status', AuthStatus.failure)
            .having((s) => s.errorMessage, 'error', 'Invalid credentials'),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'maps unknown errors to generic message',
      build: buildBloc,
      seed: () => const AuthState(email: 'a@b.com', password: 'password1'),
      setUp: () {
        when(
          () => authRepository.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(Exception('boom'));
      },
      act: (bloc) => bloc.add(const AuthSubmitted()),
      expect: () => [
        isA<AuthState>().having((s) => s.status, 'status', AuthStatus.loading),
        isA<AuthState>().having(
          (s) => s.errorMessage,
          'error',
          'Something went wrong. Please try again.',
        ),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'toggles back to login mode',
      build: buildBloc,
      seed: () => const AuthState(mode: AuthMode.signup, isSignup: true),
      act: (bloc) => bloc.add(const AuthModeToggled(AuthMode.login)),
      expect: () => [
        isA<AuthState>()
            .having((s) => s.mode, 'mode', AuthMode.login)
            .having((s) => s.submitButtonLabel, 'submit', 'Sign in'),
      ],
    );
  });
}
