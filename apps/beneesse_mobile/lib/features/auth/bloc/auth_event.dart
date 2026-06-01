import 'package:beneesse_api/beneesse_api.dart';

import '../models/auth_mode.dart';

sealed class AuthEvent {
  const AuthEvent();
}

final class AuthModeToggled extends AuthEvent {
  const AuthModeToggled(this.mode);

  final AuthMode mode;
}

final class AuthEmailChanged extends AuthEvent {
  const AuthEmailChanged(this.email);

  final String email;
}

final class AuthPasswordChanged extends AuthEvent {
  const AuthPasswordChanged(this.password);

  final String password;
}

final class AuthDisplayNameChanged extends AuthEvent {
  const AuthDisplayNameChanged(this.displayName);

  final String displayName;
}

final class AuthRoleChanged extends AuthEvent {
  const AuthRoleChanged(this.role);

  final UserRole role;
}

final class AuthSubmitted extends AuthEvent {
  const AuthSubmitted();
}
