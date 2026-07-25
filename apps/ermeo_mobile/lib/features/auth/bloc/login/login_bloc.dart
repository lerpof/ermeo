import 'package:ermeo_api/ermeo_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ermeo_mobile/features/auth/data/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required this.authRepository}) : super(const LoginState()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  final AuthRepository authRepository;

  void _onEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    emit(
      state.copyWith(
        email: event.email,
        clearFailure: true,
        clearNavigation: true,
      ),
    );
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(
      state.copyWith(
        password: event.password,
        clearFailure: true,
        clearNavigation: true,
      ),
    );
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    final email = state.email.trim();
    final password = state.password;

    if (email.isEmpty) {
      emit(
        state.copyWith(
          failure: const LoginFailure.validation(LoginValidationError.emailRequired),
          clearNavigation: true,
        ),
      );
      return;
    }

    if (password.isEmpty) {
      emit(
        state.copyWith(
          failure: const LoginFailure.validation(
            LoginValidationError.passwordRequired,
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
      await authRepository.login(email: email, password: password);
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
          failure: LoginFailure.api(error.message),
          clearNavigation: true,
        ),
      );
    } on Object catch (error) {
      emit(
        state.copyWith(
          isSubmitting: false,
          failure: LoginFailure.api(error.toString()),
          clearNavigation: true,
        ),
      );
    }
  }
}
