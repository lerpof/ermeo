import 'package:bloc_test/bloc_test.dart';
import 'package:ermeo_api/ermeo_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:ermeo_mobile/features/auth/bloc/register/register_bloc.dart';
import 'package:ermeo_mobile/features/auth/data/auth_repository.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late AuthRepository authRepository;

  setUp(() {
    authRepository = _MockAuthRepository();
  });

  group('RegisterBloc', () {
    test('initial state is empty', () {
      final bloc = RegisterBloc(authRepository: authRepository);
      expect(bloc.state, const RegisterState());
      bloc.close();
    });

    blocTest<RegisterBloc, RegisterState>(
      'updates fields on change events',
      build: () => RegisterBloc(authRepository: authRepository),
      act: (bloc) {
        bloc
          ..add(const RegisterEmailChanged('a@b.com'))
          ..add(const RegisterPasswordChanged('password1'))
          ..add(const RegisterDisplayNameChanged('Alex'));
      },
      expect: () => [
        const RegisterState(email: 'a@b.com'),
        const RegisterState(email: 'a@b.com', password: 'password1'),
        const RegisterState(
          email: 'a@b.com',
          password: 'password1',
          displayName: 'Alex',
        ),
      ],
    );

    blocTest<RegisterBloc, RegisterState>(
      'emits emailRequired when email is empty',
      build: () => RegisterBloc(authRepository: authRepository),
      seed: () => const RegisterState(
        password: 'password1',
        displayName: 'Alex',
      ),
      act: (bloc) => bloc.add(const RegisterSubmitted()),
      expect: () => [
        const RegisterState(
          password: 'password1',
          displayName: 'Alex',
          failure: RegisterFailure.validation(
            RegisterValidationError.emailRequired,
          ),
        ),
      ],
    );

    blocTest<RegisterBloc, RegisterState>(
      'emits passwordRequired when password is empty',
      build: () => RegisterBloc(authRepository: authRepository),
      seed: () => const RegisterState(
        email: 'a@b.com',
        displayName: 'Alex',
      ),
      act: (bloc) => bloc.add(const RegisterSubmitted()),
      expect: () => [
        const RegisterState(
          email: 'a@b.com',
          displayName: 'Alex',
          failure: RegisterFailure.validation(
            RegisterValidationError.passwordRequired,
          ),
        ),
      ],
    );

    blocTest<RegisterBloc, RegisterState>(
      'emits passwordTooShort when password is under 8 chars',
      build: () => RegisterBloc(authRepository: authRepository),
      seed: () => const RegisterState(
        email: 'a@b.com',
        password: 'short',
        displayName: 'Alex',
      ),
      act: (bloc) => bloc.add(const RegisterSubmitted()),
      expect: () => [
        const RegisterState(
          email: 'a@b.com',
          password: 'short',
          displayName: 'Alex',
          failure: RegisterFailure.validation(
            RegisterValidationError.passwordTooShort,
          ),
        ),
      ],
    );

    blocTest<RegisterBloc, RegisterState>(
      'emits displayNameRequired when display name is empty',
      build: () => RegisterBloc(authRepository: authRepository),
      seed: () => const RegisterState(
        email: 'a@b.com',
        password: 'password1',
      ),
      act: (bloc) => bloc.add(const RegisterSubmitted()),
      expect: () => [
        const RegisterState(
          email: 'a@b.com',
          password: 'password1',
          failure: RegisterFailure.validation(
            RegisterValidationError.displayNameRequired,
          ),
        ),
      ],
    );

    blocTest<RegisterBloc, RegisterState>(
      'emits role selection navigation on success',
      build: () {
        when(
          () => authRepository.signUp(
            email: any(named: 'email'),
            password: any(named: 'password'),
            displayName: any(named: 'displayName'),
          ),
        ).thenAnswer((_) async {});
        return RegisterBloc(authRepository: authRepository);
      },
      seed: () => const RegisterState(
        email: ' a@b.com ',
        password: 'password1',
        displayName: ' Alex ',
      ),
      act: (bloc) => bloc.add(const RegisterSubmitted()),
      expect: () => [
        const RegisterState(
          email: ' a@b.com ',
          password: 'password1',
          displayName: ' Alex ',
          isSubmitting: true,
        ),
        const RegisterState(
          email: ' a@b.com ',
          password: 'password1',
          displayName: ' Alex ',
          navigateToRoleSelection: true,
        ),
      ],
      verify: (_) {
        verify(
          () => authRepository.signUp(
            email: 'a@b.com',
            password: 'password1',
            displayName: 'Alex',
          ),
        ).called(1);
      },
    );

    blocTest<RegisterBloc, RegisterState>(
      'emits api failure on ApiException',
      build: () {
        when(
          () => authRepository.signUp(
            email: any(named: 'email'),
            password: any(named: 'password'),
            displayName: any(named: 'displayName'),
          ),
        ).thenThrow(
          const ApiException(
            statusCode: 409,
            code: 'conflict',
            message: 'Email already used',
          ),
        );
        return RegisterBloc(authRepository: authRepository);
      },
      seed: () => const RegisterState(
        email: 'a@b.com',
        password: 'password1',
        displayName: 'Alex',
      ),
      act: (bloc) => bloc.add(const RegisterSubmitted()),
      expect: () => [
        const RegisterState(
          email: 'a@b.com',
          password: 'password1',
          displayName: 'Alex',
          isSubmitting: true,
        ),
        const RegisterState(
          email: 'a@b.com',
          password: 'password1',
          displayName: 'Alex',
          failure: RegisterFailure.api('Email already used'),
        ),
      ],
    );

    blocTest<RegisterBloc, RegisterState>(
      'emits api failure on unexpected error',
      build: () {
        when(
          () => authRepository.signUp(
            email: any(named: 'email'),
            password: any(named: 'password'),
            displayName: any(named: 'displayName'),
          ),
        ).thenThrow(Exception('boom'));
        return RegisterBloc(authRepository: authRepository);
      },
      seed: () => const RegisterState(
        email: 'a@b.com',
        password: 'password1',
        displayName: 'Alex',
      ),
      act: (bloc) => bloc.add(const RegisterSubmitted()),
      expect: () => [
        const RegisterState(
          email: 'a@b.com',
          password: 'password1',
          displayName: 'Alex',
          isSubmitting: true,
        ),
        RegisterState(
          email: 'a@b.com',
          password: 'password1',
          displayName: 'Alex',
          failure: RegisterFailure.api(Exception('boom').toString()),
        ),
      ],
    );
  });
}
