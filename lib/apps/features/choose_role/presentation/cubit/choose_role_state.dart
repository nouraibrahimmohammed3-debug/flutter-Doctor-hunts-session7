enum UserRole { patient, admin }

class ChooseRoleState {
  const ChooseRoleState({required this.selectedRole});

  final UserRole selectedRole;
}
