part of 'role_selection_bloc.dart';

enum RoleSelectionValidationError {
  roleRequired,
}

sealed class RoleSelectionFailure {
  const RoleSelectionFailure();

  const factory RoleSelectionFailure.validation(
    RoleSelectionValidationError error,
  ) = RoleSelectionValidationFailure;

  const factory RoleSelectionFailure.api(String message) =
      RoleSelectionApiFailure;
}

final class RoleSelectionValidationFailure extends RoleSelectionFailure {
  const RoleSelectionValidationFailure(this.error);

  final RoleSelectionValidationError error;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoleSelectionValidationFailure && other.error == error;

  @override
  int get hashCode => error.hashCode;
}

final class RoleSelectionApiFailure extends RoleSelectionFailure {
  const RoleSelectionApiFailure(this.message);

  final String message;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoleSelectionApiFailure && other.message == message;

  @override
  int get hashCode => message.hashCode;
}

final class RoleSelectionState {
  const RoleSelectionState({
    this.role,
    this.isSubmitting = false,
    this.failure,
    this.navigateToHome = false,
  });

  final AuthRole? role;
  final bool isSubmitting;
  final RoleSelectionFailure? failure;
  final bool navigateToHome;

  RoleSelectionState copyWith({
    AuthRole? role,
    bool? isSubmitting,
    RoleSelectionFailure? failure,
    bool clearFailure = false,
    bool? navigateToHome,
    bool clearNavigation = false,
  }) {
    return RoleSelectionState(
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
      other is RoleSelectionState &&
          other.role == role &&
          other.isSubmitting == isSubmitting &&
          other.failure == failure &&
          other.navigateToHome == navigateToHome;

  @override
  int get hashCode => Object.hash(role, isSubmitting, failure, navigateToHome);
}
