part of 'register_bloc.dart';

enum RegisterValidationError {
  emailRequired,
  passwordRequired,
  passwordTooShort,
  displayNameRequired,
}

sealed class RegisterFailure {
  const RegisterFailure();

  const factory RegisterFailure.validation(RegisterValidationError error) =
      RegisterValidationFailure;

  const factory RegisterFailure.api(String message) = RegisterApiFailure;
}

final class RegisterValidationFailure extends RegisterFailure {
  const RegisterValidationFailure(this.error);

  final RegisterValidationError error;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegisterValidationFailure && other.error == error;

  @override
  int get hashCode => error.hashCode;
}

final class RegisterApiFailure extends RegisterFailure {
  const RegisterApiFailure(this.message);

  final String message;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegisterApiFailure && other.message == message;

  @override
  int get hashCode => message.hashCode;
}

final class RegisterState {
  const RegisterState({
    this.email = '',
    this.password = '',
    this.displayName = '',
    this.role = AuthRole.athlete,
    this.isSubmitting = false,
    this.failure,
    this.navigateToHome = false,
  });

  final String email;
  final String password;
  final String displayName;
  final AuthRole role;
  final bool isSubmitting;
  final RegisterFailure? failure;
  final bool navigateToHome;

  RegisterState copyWith({
    String? email,
    String? password,
    String? displayName,
    AuthRole? role,
    bool? isSubmitting,
    RegisterFailure? failure,
    bool clearFailure = false,
    bool? navigateToHome,
    bool clearNavigation = false,
  }) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
      displayName: displayName ?? this.displayName,
      role: role ?? this.role,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      failure: clearFailure ? null : (failure ?? this.failure),
      navigateToHome: clearNavigation
          ? false
          : (navigateToHome ?? this.navigateToHome),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegisterState &&
          other.email == email &&
          other.password == password &&
          other.displayName == displayName &&
          other.role == role &&
          other.isSubmitting == isSubmitting &&
          other.failure == failure &&
          other.navigateToHome == navigateToHome;

  @override
  int get hashCode => Object.hash(
    email,
    password,
    displayName,
    role,
    isSubmitting,
    failure,
    navigateToHome,
  );
}
