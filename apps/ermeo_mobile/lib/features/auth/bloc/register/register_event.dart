part of 'register_bloc.dart';

sealed class RegisterEvent {
  const RegisterEvent();
}

final class RegisterEmailChanged extends RegisterEvent {
  const RegisterEmailChanged(this.email);

  final String email;
}

final class RegisterPasswordChanged extends RegisterEvent {
  const RegisterPasswordChanged(this.password);

  final String password;
}

final class RegisterDisplayNameChanged extends RegisterEvent {
  const RegisterDisplayNameChanged(this.displayName);

  final String displayName;
}

final class RegisterRoleChanged extends RegisterEvent {
  const RegisterRoleChanged(this.role);

  final AuthRole role;
}

final class RegisterSubmitted extends RegisterEvent {
  const RegisterSubmitted();
}
