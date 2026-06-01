import 'package:beneesse_api/beneesse_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/auth_repository.dart';
import '../models/auth_mode.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AuthState()) {
    on<AuthModeToggled>(_onModeToggled);
    on<AuthEmailChanged>(_onEmailChanged);
    on<AuthPasswordChanged>(_onPasswordChanged);
    on<AuthDisplayNameChanged>(_onDisplayNameChanged);
    on<AuthRoleChanged>(_onRoleChanged);
    on<AuthSubmitted>(_onSubmitted);
  }

  final AuthRepository _authRepository;

  static final _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  void _onModeToggled(AuthModeToggled event, Emitter<AuthState> emit) {
    emit(_stateForMode(event.mode, state).copyWith(clearError: true));
  }

  void _onEmailChanged(AuthEmailChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(email: event.email, clearError: true));
  }

  void _onPasswordChanged(AuthPasswordChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(password: event.password, clearError: true));
  }

  void _onDisplayNameChanged(
    AuthDisplayNameChanged event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(displayName: event.displayName, clearError: true));
  }

  void _onRoleChanged(AuthRoleChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(role: event.role, clearError: true));
  }

  Future<void> _onSubmitted(
    AuthSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    final validationError = _validate(state);
    if (validationError != null) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          errorMessage: validationError,
        ),
      );
      return;
    }

    emit(state.copyWith(status: AuthStatus.loading, clearError: true));

    try {
      if (state.mode == AuthMode.login) {
        await _authRepository.login(
          email: state.email.trim(),
          password: state.password,
        );
      } else {
        await _authRepository.register(
          email: state.email.trim(),
          password: state.password,
          displayName: state.displayName.trim(),
          role: state.role,
        );
      }
      emit(state.copyWith(status: AuthStatus.success, clearError: true));
    } on ApiException catch (error) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          errorMessage: error.message,
        ),
      );
    } on Object {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          errorMessage: 'Something went wrong. Please try again.',
        ),
      );
    }
  }

  String? _validate(AuthState current) {
    final email = current.email.trim();
    if (email.isEmpty) {
      return 'Email is required';
    }
    if (!_emailPattern.hasMatch(email)) {
      return 'Enter a valid email address';
    }
    if (current.password.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (current.mode == AuthMode.signup && current.displayName.trim().isEmpty) {
      return 'Display name is required';
    }
    return null;
  }

  AuthState _stateForMode(AuthMode mode, AuthState current) {
    final isSignup = mode == AuthMode.signup;
    return current.copyWith(
      mode: mode,
      isSignup: isSignup,
      appBarTitle: isSignup ? 'Create account' : 'Sign in',
      submitButtonLabel: isSignup ? 'Create account' : 'Sign in',
    );
  }
}
