// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'er_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class ErLocalizationsEn extends ErLocalizations {
  ErLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Ermeo';

  @override
  String get authLoginTitle => 'Sign in';

  @override
  String get authRegisterTitle => 'Create account';

  @override
  String get authLoginEmailLabel => 'Email';

  @override
  String get authLoginPasswordLabel => 'Password';

  @override
  String get authRegisterEmailLabel => 'Email';

  @override
  String get authRegisterPasswordLabel => 'Password';

  @override
  String get authLoginSubmitButton => 'Sign in';

  @override
  String get authRegisterSubmitButton => 'Create account';

  @override
  String get authLoginGoToRegister => 'Create an account';

  @override
  String get authRegisterGoToLogin => 'Already have an account? Sign in';

  @override
  String get authRegisterDisplayNameLabel => 'Display name';

  @override
  String get authRegisterRoleLabel => 'Role';

  @override
  String get authRegisterRoleAthlete => 'Athlete';

  @override
  String get authRegisterRoleInstructor => 'Instructor';

  @override
  String get authRegisterRoleAdmin => 'Admin';

  @override
  String get authValidationEmailRequired => 'Email is required';

  @override
  String get authValidationPasswordRequired => 'Password is required';

  @override
  String get authValidationPasswordTooShort =>
      'Password must be at least 8 characters';

  @override
  String get authValidationDisplayNameRequired => 'Display name is required';

  @override
  String get homeTitle => 'Home';

  @override
  String get homeWelcomeMessage => 'You are signed in.';

  @override
  String get homeLogoutButton => 'Sign out';
}
