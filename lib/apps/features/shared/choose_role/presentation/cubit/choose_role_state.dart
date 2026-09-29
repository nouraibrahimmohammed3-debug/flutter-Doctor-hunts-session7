
import 'package:doctor_hunt/apps/features/shared/auth/domain/entities/user_role.dart';

class ChooseRoleState {
  const ChooseRoleState({
    this.selectedRole,
  });

  final UserRole? selectedRole;

  ChooseRoleState copyWith({
    UserRole? selectedRole,
  }) {
    return ChooseRoleState(
      selectedRole: selectedRole ?? this.selectedRole,
    );
  }
}

