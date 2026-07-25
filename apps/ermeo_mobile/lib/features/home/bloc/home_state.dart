part of 'home_bloc.dart';

final class HomeState {
  const HomeState({
    this.isLoggingOut = false,
    this.navigateToLogin = false,
    this.failureMessage,
  });

  final bool isLoggingOut;
  final bool navigateToLogin;
  final String? failureMessage;

  HomeState copyWith({
    bool? isLoggingOut,
    bool? navigateToLogin,
    bool clearNavigation = false,
    String? failureMessage,
    bool clearFailure = false,
  }) {
    return HomeState(
      isLoggingOut: isLoggingOut ?? this.isLoggingOut,
      navigateToLogin: clearNavigation
          ? false
          : (navigateToLogin ?? this.navigateToLogin),
      failureMessage: clearFailure ? null : (failureMessage ?? this.failureMessage),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeState &&
          other.isLoggingOut == isLoggingOut &&
          other.navigateToLogin == navigateToLogin &&
          other.failureMessage == failureMessage;

  @override
  int get hashCode => Object.hash(isLoggingOut, navigateToLogin, failureMessage);
}
