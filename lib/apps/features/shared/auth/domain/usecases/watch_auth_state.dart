import 'package:doctor_hunt/apps/features/shared/auth/domain/repositories/auth_repository.dart';

import '../entities/app_user.dart';

class WatchAuthState {
  const WatchAuthState(this._repository);

  final AuthRepository _repository;

  Stream<AppUser?> call() {
    return _repository.watchAuthState();
  }
}