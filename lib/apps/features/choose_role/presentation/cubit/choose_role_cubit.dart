import 'package:doctor_hunt/apps/features/choose_role/presentation/cubit/choose_role_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChooseRoleCubit extends Cubit<ChooseRoleState> {
  ChooseRoleCubit()
      : super(
          const ChooseRoleState(
            selectedRole: UserRole.patient,
          ),
        );

  void selectRole(UserRole role) {
    if (role == state.selectedRole) return;

    emit(ChooseRoleState(selectedRole: role));
  }
}
