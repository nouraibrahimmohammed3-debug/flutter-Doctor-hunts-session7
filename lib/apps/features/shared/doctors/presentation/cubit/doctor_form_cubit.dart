import 'package:doctor_hunt/apps/core/extensions/localized_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/services/doctor_photo_service.dart';
import '../../data/models/doctor_specialty.dart';

class DoctorFormState {
  const DoctorFormState({
    this.name = '',
    this.specialization,
    this.fee = '',
    this.imagePath = '',
    this.uploading = false,
    this.errorMessage,
  });
  final String name;
  final String? specialization;
  final String fee;
  final String imagePath;
  final bool uploading;
  final String? errorMessage;

  DoctorFormState copyWith({
    String? name,
    String? specialization,
    String? fee,
    String? imagePath,
    bool? uploading,
    String? errorMessage,
  }) {
    return DoctorFormState(
      name: name ?? this.name,
      specialization: specialization ?? this.specialization,
      fee: fee ?? this.fee,
      imagePath: imagePath ?? this.imagePath,
      uploading: uploading ?? this.uploading,
      errorMessage: errorMessage,
    );
  }
}

class DoctorFormCubit extends Cubit<DoctorFormState> {
  DoctorFormCubit({
    DoctorFormState? initialState,
    required DoctorPhotoService photoService,
  }) : _photoService = photoService,
       super(
         initialState == null
             ? const DoctorFormState()
             : initialState.copyWith(
                 specialization: initialState.specialization == null
                     ? null
                     : DoctorSpecialty.id(initialState.specialization!),
               ),
       );
  final DoctorPhotoService _photoService;
  void feeChanged(String value) => emit(state.copyWith(fee: value));
  Future<void> uploadPhoto() async {
    if (state.uploading) return;
    emit(state.copyWith(uploading: true));
    try {
      final path = await _photoService.pickAndUpload();
      if (!isClosed) emit(state.copyWith(imagePath: path, uploading: false));
    } catch (error) {
      if (!isClosed) {
        emit(
          state.copyWith(uploading: false, errorMessage: localizedError(error)),
        );
      }
    }
  }

  void nameChanged(String value) => emit(state.copyWith(name: value));

  void specializationChanged(String? value) {
    if (value == null) return;
    emit(state.copyWith(specialization: DoctorSpecialty.id(value)));
  }
}
