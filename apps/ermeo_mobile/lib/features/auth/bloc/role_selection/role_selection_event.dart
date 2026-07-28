part of 'role_selection_bloc.dart';

sealed class RoleSelectionEvent {
  const RoleSelectionEvent();
}

final class RoleSelectionRoleChanged extends RoleSelectionEvent {
  const RoleSelectionRoleChanged(this.role);

  final AuthRole role;
}

final class RoleSelectionSubmitted extends RoleSelectionEvent {
  const RoleSelectionSubmitted();
}
