part of 'login_bloc.dart';

enum LoginValidationError {
  emailRequired,
  passwordRequired,
}

sealed class LoginFailure {
  const LoginFailure();

  const factory LoginFailure.validation(LoginValidationError error) =
      LoginValidationFailure;

  const factory LoginFailure.api(String message) = LoginApiFailure;
}

final class LoginValidationFailure extends LoginFailure {
  const LoginValidationFailure(this.error);

  final LoginValidationError error;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginValidationFailure && other.error == error;

  @override
  int get hashCode => error.hashCode;
}

final class LoginApiFailure extends LoginFailure {
  const LoginApiFailure(this.message);

  final String message;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginApiFailure && other.message == message;

  @override
  int get hashCode => message.hashCode;
}

final class LoginState {
  const LoginState({
    this.email = '',
    this.password = '',
    this.isSubmitting = false,
    this.failure,
    this.navigateToHome = false,
    this.navigateToRoleSelection = false,
  });

  final String email;
  final String password;
  final bool isSubmitting;
  final LoginFailure? failure;
  final bool navigateToHome;
  final bool navigateToRoleSelection;

  LoginState copyWith({
    String? email,
    String? password,
    bool? isSubmitting,
    LoginFailure? failure,
    bool clearFailure = false,
    bool? navigateToHome,
    bool? navigateToRoleSelection,
    bool clearNavigation = false,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      failure: clearFailure ? null : (failure ?? this.failure),
      navigateToHome: clearNavigation
          ? false
          : (navigateToHome ?? this.navigateToHome),
      navigateToRoleSelection: clearNavigation
          ? false
          : (navigateToRoleSelection ?? this.navigateToRoleSelection),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginState &&
          other.email == email &&
          other.password == password &&
          other.isSubmitting == isSubmitting &&
          other.failure == failure &&
          other.navigateToHome == navigateToHome &&
          other.navigateToRoleSelection == navigateToRoleSelection;

  @override
  int get hashCode => Object.hash(
    email,
    password,
    isSubmitting,
    failure,
    navigateToHome,
    navigateToRoleSelection,
  );
}
