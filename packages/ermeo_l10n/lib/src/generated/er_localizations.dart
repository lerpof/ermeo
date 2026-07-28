// coverage:ignore-file
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'er_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of ErLocalizations
/// returned by `ErLocalizations.of(context)`.
///
/// Applications need to include `ErLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/er_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: ErLocalizations.localizationsDelegates,
///   supportedLocales: ErLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the ErLocalizations.supportedLocales
/// property.
abstract class ErLocalizations {
  ErLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static ErLocalizations of(BuildContext context) {
    return Localizations.of<ErLocalizations>(context, ErLocalizations)!;
  }

  static const LocalizationsDelegate<ErLocalizations> delegate =
      _ErLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// Application name shown in the system UI where a global title is needed.
  ///
  /// In en, this message translates to:
  /// **'Ermeo'**
  String get appTitle;

  /// Title on the login screen app bar.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get authLoginTitle;

  /// Title on the register screen app bar.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get authRegisterTitle;

  /// Label for the email field on the login screen.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get authLoginEmailLabel;

  /// Label for the password field on the login screen.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get authLoginPasswordLabel;

  /// Label for the email field on the register screen.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get authRegisterEmailLabel;

  /// Label for the password field on the register screen.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get authRegisterPasswordLabel;

  /// Primary submit button on the login screen.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get authLoginSubmitButton;

  /// Primary submit button on the register screen.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get authRegisterSubmitButton;

  /// Link on the login screen to navigate to register.
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get authLoginGoToRegister;

  /// Link on the register screen to navigate to login.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Sign in'**
  String get authRegisterGoToLogin;

  /// Label for the display name field on the register screen.
  ///
  /// In en, this message translates to:
  /// **'Display name'**
  String get authRegisterDisplayNameLabel;

  /// Google federated sign-in button on the login screen.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get authLoginGoogleButton;

  /// Apple federated sign-in button on the login screen (iOS).
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get authLoginAppleButton;

  /// Title on the post-auth role selection / onboarding screen.
  ///
  /// In en, this message translates to:
  /// **'Choose your role'**
  String get authRoleSelectionTitle;

  /// Supporting copy on the role selection screen.
  ///
  /// In en, this message translates to:
  /// **'Tell us how you will use Ermeo.'**
  String get authRoleSelectionSubtitle;

  /// Athlete option on the role selection screen.
  ///
  /// In en, this message translates to:
  /// **'Athlete'**
  String get authRoleSelectionAthlete;

  /// Instructor option on the role selection screen.
  ///
  /// In en, this message translates to:
  /// **'Instructor'**
  String get authRoleSelectionInstructor;

  /// Primary button to submit the chosen role.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get authRoleSelectionContinueButton;

  /// Validation error when no role is selected on onboarding.
  ///
  /// In en, this message translates to:
  /// **'Please select a role'**
  String get authValidationRoleRequired;

  /// Athlete option label reused where role names are shown.
  ///
  /// In en, this message translates to:
  /// **'Athlete'**
  String get authRegisterRoleAthlete;

  /// Instructor option label reused where role names are shown.
  ///
  /// In en, this message translates to:
  /// **'Instructor'**
  String get authRegisterRoleInstructor;

  /// Validation error when email is empty on auth forms.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get authValidationEmailRequired;

  /// Validation error when password is empty on auth forms.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get authValidationPasswordRequired;

  /// Validation error when password is shorter than the API minimum.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get authValidationPasswordTooShort;

  /// Validation error when display name is empty on register.
  ///
  /// In en, this message translates to:
  /// **'Display name is required'**
  String get authValidationDisplayNameRequired;

  /// Title on the dummy home screen app bar.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTitle;

  /// Placeholder welcome copy on the dummy home screen.
  ///
  /// In en, this message translates to:
  /// **'You are signed in.'**
  String get homeWelcomeMessage;

  /// Logout button on the dummy home screen.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get homeLogoutButton;
}

class _ErLocalizationsDelegate extends LocalizationsDelegate<ErLocalizations> {
  const _ErLocalizationsDelegate();

  @override
  Future<ErLocalizations> load(Locale locale) {
    return SynchronousFuture<ErLocalizations>(lookupErLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_ErLocalizationsDelegate old) => false;
}

ErLocalizations lookupErLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return ErLocalizationsEn();
  }

  throw FlutterError(
    'ErLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
