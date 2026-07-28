import 'package:ermeo_api/ermeo_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ermeo_mobile/features/auth/data/auth_repository.dart';
import 'package:ermeo_mobile/features/auth/models/auth_role.dart';

part 'role_selection_event.dart';
part 'role_selection_state.dart';

class RoleSelectionBloc extends Bloc<RoleSelectionEvent, RoleSelectionState> {
  RoleSelectionBloc({required this.authRepository})
      : super(const RoleSelectionState()) {
    on<RoleSelectionRoleChanged>(_onRoleChanged);
    on<RoleSelectionSubmitted>(_onSubmitted);
  }

  final AuthRepository authRepository;

  void _onRoleChanged(
    RoleSelectionRoleChanged event,
    Emitter<RoleSelectionState> emit,
  ) {
    emit(
      state.copyWith(
        role: event.role,
        clearFailure: true,
        clearNavigation: true,
      ),
    );
  }

  Future<void> _onSubmitted(
    RoleSelectionSubmitted event,
    Emitter<RoleSelectionState> emit,
  ) async {
    final role = state.role;
    if (role == null) {
      emit(
        state.copyWith(
          failure: const RoleSelectionFailure.validation(
            RoleSelectionValidationError.roleRequired,
          ),
          clearNavigation: true,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        isSubmitting: true,
        clearFailure: true,
        clearNavigation: true,
      ),
    );

    try {
      await authRepository.completeOnboarding(role: role);
      emit(
        state.copyWith(
          isSubmitting: false,
          navigateToHome: true,
          clearFailure: true,
        ),
      );
    } on ApiException catch (error) {
      emit(
        state.copyWith(
          isSubmitting: false,
          failure: RoleSelectionFailure.api(error.message),
          clearNavigation: true,
        ),
      );
    } on Object catch (error) {
      emit(
        state.copyWith(
          isSubmitting: false,
          failure: RoleSelectionFailure.api(error.toString()),
          clearNavigation: true,
        ),
      );
    }
  }
}
