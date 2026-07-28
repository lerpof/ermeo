import 'package:bloc_test/bloc_test.dart';
import 'package:ermeo_api/ermeo_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:ermeo_mobile/features/auth/bloc/role_selection/role_selection_bloc.dart';
import 'package:ermeo_mobile/features/auth/data/auth_repository.dart';
import 'package:ermeo_mobile/features/auth/models/auth_role.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late AuthRepository authRepository;

  setUpAll(() {
    registerFallbackValue(AuthRole.athlete);
  });

  setUp(() {
    authRepository = _MockAuthRepository();
  });

  group('RoleSelectionBloc', () {
    test('initial state has no role', () {
      final bloc = RoleSelectionBloc(authRepository: authRepository);
      expect(bloc.state, const RoleSelectionState());
      bloc.close();
    });

    blocTest<RoleSelectionBloc, RoleSelectionState>(
      'updates role on RoleSelectionRoleChanged',
      build: () => RoleSelectionBloc(authRepository: authRepository),
      act: (bloc) =>
          bloc.add(const RoleSelectionRoleChanged(AuthRole.instructor)),
      expect: () => [
        const RoleSelectionState(role: AuthRole.instructor),
      ],
    );

    blocTest<RoleSelectionBloc, RoleSelectionState>(
      'emits roleRequired when none selected',
      build: () => RoleSelectionBloc(authRepository: authRepository),
      act: (bloc) => bloc.add(const RoleSelectionSubmitted()),
      expect: () => [
        const RoleSelectionState(
          failure: RoleSelectionFailure.validation(
            RoleSelectionValidationError.roleRequired,
          ),
        ),
      ],
    );

    blocTest<RoleSelectionBloc, RoleSelectionState>(
      'emits navigateToHome on success',
      build: () {
        when(
          () => authRepository.completeOnboarding(role: any(named: 'role')),
        ).thenAnswer((_) async {});
        return RoleSelectionBloc(authRepository: authRepository);
      },
      seed: () => const RoleSelectionState(role: AuthRole.athlete),
      act: (bloc) => bloc.add(const RoleSelectionSubmitted()),
      expect: () => [
        const RoleSelectionState(role: AuthRole.athlete, isSubmitting: true),
        const RoleSelectionState(
          role: AuthRole.athlete,
          navigateToHome: true,
        ),
      ],
    );

    blocTest<RoleSelectionBloc, RoleSelectionState>(
      'emits api failure on ApiException',
      build: () {
        when(
          () => authRepository.completeOnboarding(role: any(named: 'role')),
        ).thenThrow(
          const ApiException(
            statusCode: 409,
            code: 'conflict',
            message: 'Role already set',
          ),
        );
        return RoleSelectionBloc(authRepository: authRepository);
      },
      seed: () => const RoleSelectionState(role: AuthRole.athlete),
      act: (bloc) => bloc.add(const RoleSelectionSubmitted()),
      expect: () => [
        const RoleSelectionState(role: AuthRole.athlete, isSubmitting: true),
        const RoleSelectionState(
          role: AuthRole.athlete,
          failure: RoleSelectionFailure.api('Role already set'),
        ),
      ],
    );
  });
}
