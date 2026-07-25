import 'package:ermeo_api/ermeo_api.dart' as api;

import 'package:ermeo_mobile/core/data/converter.dart';
import 'package:ermeo_mobile/features/auth/models/auth_role.dart';

class AuthRoleConverter implements Converter<AuthRole, api.UserRole> {
  const AuthRoleConverter();

  @override
  api.UserRole fromInput(AuthRole input) {
    return switch (input) {
      AuthRole.athlete => api.UserRole.athlete,
      AuthRole.instructor => api.UserRole.instructor,
      AuthRole.admin => api.UserRole.admin,
    };
  }

  @override
  AuthRole toInput(api.UserRole output) {
    return switch (output) {
      api.UserRole.athlete => AuthRole.athlete,
      api.UserRole.instructor => AuthRole.instructor,
      api.UserRole.admin => AuthRole.admin,
    };
  }
}
