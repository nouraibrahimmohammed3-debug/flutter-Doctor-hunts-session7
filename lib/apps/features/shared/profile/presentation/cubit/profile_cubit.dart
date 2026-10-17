import 'package:doctor_hunt/apps/core/extensions/localized_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/profile_service.dart';
import '../../../auth/domain/entities/app_user.dart';

class ProfileState {
  const ProfileState({
    this.busy = false,
    this.photoUrl = '',
    this.error,
    this.saved = false,
  });
  final bool busy;
  final String photoUrl;
  final String? error;
  final bool saved;
}

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.service, this.user)
    : super(ProfileState(photoUrl: user.photoUrl));
  final ProfileService service;
  final AppUser user;
  Future<void> pickPhoto() async {
    if (state.busy) return;
    emit(ProfileState(busy: true, photoUrl: state.photoUrl));
    try {
      final url = await service.pickPhoto();
      if (!isClosed) emit(ProfileState(photoUrl: url ?? state.photoUrl));
    } catch (error) {
      if (!isClosed) {
        emit(
          ProfileState(photoUrl: state.photoUrl, error: localizedError(error)),
        );
      }
    }
  }

  Future<void> save({
    required String name,
    required String phone,
    required DateTime? birthDate,
    required String gender,
  }) async {
    if (state.busy) return;
    emit(ProfileState(busy: true, photoUrl: state.photoUrl));
    try {
      await service.save(
        user: user,
        name: name,
        phone: phone,
        photoUrl: state.photoUrl,
        birthDate: birthDate,
        gender: gender,
      );
      if (!isClosed) {
        emit(ProfileState(photoUrl: state.photoUrl, saved: true));
      }
    } catch (error) {
      if (!isClosed) {
        emit(
          ProfileState(photoUrl: state.photoUrl, error: localizedError(error)),
        );
      }
    }
  }
}
