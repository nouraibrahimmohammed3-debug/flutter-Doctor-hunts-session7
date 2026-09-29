import 'package:doctor_hunt/apps/features/shared/auth/domain/entities/user_role.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'choose_role_state.dart';

class ChooseRoleCubit extends Cubit<ChooseRoleState> {
  ChooseRoleCubit() : super(const ChooseRoleState());

  void selectRole(UserRole role) {
    if (role == state.selectedRole) {
      return;
    }

    emit(
      state.copyWith(
        selectedRole: role,
      ),
    );
  }
}