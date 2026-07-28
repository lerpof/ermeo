import 'package:ermeo_api/ermeo_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ermeo_mobile/core/session/session_service.dart';
import 'package:ermeo_mobile/features/auth/data/auth_repository.dart';
import 'package:ermeo_mobile/features/auth/data/federated_auth_gateway.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required this.authRepository,
    required this.sessionService,
  }) : super(const LoginState()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
    on<LoginGooglePressed>(_onGooglePressed);
    on<LoginApplePressed>(_onApplePressed);
  }

  final AuthRepository authRepository;
  final AppSessionService sessionService;

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
      emit(_successState());
    } on ApiException catch (error) {
      emit(_apiFailure(error.message));
    } on Object catch (error) {
      emit(_apiFailure(error.toString()));
    }
  }

  Future<void> _onGooglePressed(
    LoginGooglePressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(
      state.copyWith(
        isSubmitting: true,
        clearFailure: true,
        clearNavigation: true,
      ),
    );
    try {
      await authRepository.loginWithGoogle();
      emit(_successState());
    } on FederatedAuthCancelledException {
      emit(state.copyWith(isSubmitting: false, clearNavigation: true));
    } on ApiException catch (error) {
      emit(_apiFailure(error.message));
    } on Object catch (error) {
      emit(_apiFailure(error.toString()));
    }
  }

  Future<void> _onApplePressed(
    LoginApplePressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(
      state.copyWith(
        isSubmitting: true,
        clearFailure: true,
        clearNavigation: true,
      ),
    );
    try {
      await authRepository.loginWithApple();
      emit(_successState());
    } on FederatedAuthCancelledException {
      emit(state.copyWith(isSubmitting: false, clearNavigation: true));
    } on ApiException catch (error) {
      emit(_apiFailure(error.message));
    } on Object catch (error) {
      emit(_apiFailure(error.toString()));
    }
  }

  LoginState _successState() {
    final needsOnboarding = sessionService.needsOnboarding;
    return state.copyWith(
      isSubmitting: false,
      navigateToHome: !needsOnboarding,
      navigateToRoleSelection: needsOnboarding,
      clearFailure: true,
    );
  }

  LoginState _apiFailure(String message) {
    return state.copyWith(
      isSubmitting: false,
      failure: LoginFailure.api(message),
      clearNavigation: true,
    );
  }
}
