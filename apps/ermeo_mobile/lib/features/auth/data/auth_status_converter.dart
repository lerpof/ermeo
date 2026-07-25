import 'package:ermeo_mobile/core/data/converter.dart';
import 'package:ermeo_mobile/core/session/session_state.dart';
import 'package:ermeo_mobile/features/auth/models/auth_status.dart';

class AuthStatusConverter implements Converter<SessionStatus, AuthStatus> {
  const AuthStatusConverter();

  @override
  AuthStatus fromInput(SessionStatus input) {
    return switch (input) {
      SessionStatus.unknown => AuthStatus.unknown,
      SessionStatus.unauthenticated => AuthStatus.unauthenticated,
      SessionStatus.authenticated => AuthStatus.authenticated,
    };
  }

  @override
  SessionStatus toInput(AuthStatus output) {
    return switch (output) {
      AuthStatus.unknown => SessionStatus.unknown,
      AuthStatus.unauthenticated => SessionStatus.unauthenticated,
      AuthStatus.authenticated => SessionStatus.authenticated,
    };
  }
}
