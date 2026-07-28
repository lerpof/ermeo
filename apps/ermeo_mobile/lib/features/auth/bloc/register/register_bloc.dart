import 'package:ermeo_api/ermeo_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ermeo_mobile/features/auth/data/auth_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({required this.authRepository}) : super(const RegisterState()) {
    on<RegisterEmailChanged>(_onEmailChanged);
    on<RegisterPasswordChanged>(_onPasswordChanged);
    on<RegisterDisplayNameChanged>(_onDisplayNameChanged);
    on<RegisterSubmitted>(_onSubmitted);
  }

  final AuthRepository authRepository;

  void _onEmailChanged(
    RegisterEmailChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(
      state.copyWith(
        email: event.email,
        clearFailure: true,
        clearNavigation: true,
      ),
    );
  }

  void _onPasswordChanged(
    RegisterPasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(
      state.copyWith(
        password: event.password,
        clearFailure: true,
        clearNavigation: true,
      ),
    );
  }

  void _onDisplayNameChanged(
    RegisterDisplayNameChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(
      state.copyWith(
        displayName: event.displayName,
        clearFailure: true,
        clearNavigation: true,
      ),
    );
  }

  Future<void> _onSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    final email = state.email.trim();
    final password = state.password;
    final displayName = state.displayName.trim();

    if (email.isEmpty) {
      emit(
        state.copyWith(
          failure: const RegisterFailure.validation(
            RegisterValidationError.emailRequired,
          ),
          clearNavigation: true,
        ),
      );
      return;
    }

    if (password.isEmpty) {
      emit(
        state.copyWith(
          failure: const RegisterFailure.validation(
            RegisterValidationError.passwordRequired,
          ),
          clearNavigation: true,
        ),
      );
      return;
    }

    if (password.length < 8) {
      emit(
        state.copyWith(
          failure: const RegisterFailure.validation(
            RegisterValidationError.passwordTooShort,
          ),
          clearNavigation: true,
        ),
      );
      return;
    }

    if (displayName.isEmpty) {
      emit(
        state.copyWith(
          failure: const RegisterFailure.validation(
            RegisterValidationError.displayNameRequired,
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
      await authRepository.signUp(
        email: email,
        password: password,
        displayName: displayName,
      );
      emit(
        state.copyWith(
          isSubmitting: false,
          navigateToRoleSelection: true,
          clearFailure: true,
        ),
      );
    } on ApiException catch (error) {
      emit(
        state.copyWith(
          isSubmitting: false,
          failure: RegisterFailure.api(error.message),
          clearNavigation: true,
        ),
      );
    } on Object catch (error) {
      emit(
        state.copyWith(
          isSubmitting: false,
          failure: RegisterFailure.api(error.toString()),
          clearNavigation: true,
        ),
      );
    }
  }
}
