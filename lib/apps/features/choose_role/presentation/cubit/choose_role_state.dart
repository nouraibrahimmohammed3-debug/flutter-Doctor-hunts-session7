import 'package:doctor_hunt/apps/features/auth/data/models/user_role.dart';

enum ChooseRoleStatus { initial, selected }

class ChooseRoleState {
  const ChooseRoleState({this.selectedRole});

  final UserRole? selectedRole;

  ChooseRoleState copyWith({UserRole? selectedRole}) {
    return ChooseRoleState(selectedRole: selectedRole ?? this.selectedRole);
  }
}
