import 'package:beneesse_api/beneesse_api.dart';

import '../models/auth_mode.dart';

enum AuthStatus {
  initial,
  loading,
  success,
  failure,
}

class AuthState {
  const AuthState({
    this.mode = AuthMode.login,
    this.email = '',
    this.password = '',
    this.displayName = '',
    this.role = UserRole.athlete,
    this.status = AuthStatus.initial,
    this.errorMessage,
    this.appBarTitle = 'Sign in',
    this.loginTabLabel = 'Login',
    this.signupTabLabel = 'Sign up',
    this.emailLabel = 'Email',
    this.passwordLabel = 'Password',
    this.displayNameLabel = 'Display name',
    this.athleteRoleLabel = 'Athlete',
    this.instructorRoleLabel = 'Instructor',
    this.submitButtonLabel = 'Sign in',
    this.isSignup = false,
  });

  final AuthMode mode;
  final String email;
  final String password;
  final String displayName;
  final UserRole role;
  final AuthStatus status;
  final String? errorMessage;
  final String appBarTitle;
  final String loginTabLabel;
  final String signupTabLabel;
  final String emailLabel;
  final String passwordLabel;
  final String displayNameLabel;
  final String athleteRoleLabel;
  final String instructorRoleLabel;
  final String submitButtonLabel;
  final bool isSignup;

  bool get isLoading => status == AuthStatus.loading;

  AuthState copyWith({
    AuthMode? mode,
    String? email,
    String? password,
    String? displayName,
    UserRole? role,
    AuthStatus? status,
    String? errorMessage,
    bool clearError = false,
    String? appBarTitle,
    String? loginTabLabel,
    String? signupTabLabel,
    String? emailLabel,
    String? passwordLabel,
    String? displayNameLabel,
    String? athleteRoleLabel,
    String? instructorRoleLabel,
    String? submitButtonLabel,
    bool? isSignup,
  }) {
    return AuthState(
      mode: mode ?? this.mode,
      email: email ?? this.email,
      password: password ?? this.password,
      displayName: displayName ?? this.displayName,
      role: role ?? this.role,
      status: status ?? this.status,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      appBarTitle: appBarTitle ?? this.appBarTitle,
      loginTabLabel: loginTabLabel ?? this.loginTabLabel,
      signupTabLabel: signupTabLabel ?? this.signupTabLabel,
      emailLabel: emailLabel ?? this.emailLabel,
      passwordLabel: passwordLabel ?? this.passwordLabel,
      displayNameLabel: displayNameLabel ?? this.displayNameLabel,
      athleteRoleLabel: athleteRoleLabel ?? this.athleteRoleLabel,
      instructorRoleLabel: instructorRoleLabel ?? this.instructorRoleLabel,
      submitButtonLabel: submitButtonLabel ?? this.submitButtonLabel,
      isSignup: isSignup ?? this.isSignup,
    );
  }
}
