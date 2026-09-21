import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorFormState {
  const DoctorFormState({this.name = '', this.specialization});
  final String name;
  final String? specialization;

  DoctorFormState copyWith({String? name, String? specialization}) {
    return DoctorFormState(
      name: name ?? this.name,
      specialization: specialization ?? this.specialization,
    );
  }
}

class DoctorFormCubit extends Cubit<DoctorFormState> {
  DoctorFormCubit({DoctorFormState? initialState})
      : super(initialState ?? const DoctorFormState());

  void nameChanged(String value) => emit(state.copyWith(name: value));

  void specializationChanged(String? value) {
    if (value == null) return;
    emit(state.copyWith(specialization: value));
  }
}
