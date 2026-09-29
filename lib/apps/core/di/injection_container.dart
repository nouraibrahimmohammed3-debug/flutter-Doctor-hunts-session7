import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_hunt/apps/features/shared/auth/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../../features/shared/auth/data/datasources/auth_firebase_datasource.dart';
import '../../features/shared/auth/data/datasources/users_firestore_datasource.dart';
import '../../features/shared/auth/data/repository/auth_repository_impl.dart';
import '../../features/shared/auth/domain/usecases/sign_in.dart';
import '../../features/shared/auth/domain/usecases/sign_out.dart';
import '../../features/shared/auth/domain/usecases/validate_active_user.dart';
import '../../features/shared/auth/domain/usecases/watch_auth_state.dart';
import '../../features/shared/auth/presentation/bloc/auth_bloc.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // --------------------------------------------------
  // External dependencies
  // --------------------------------------------------

  getIt.registerLazySingleton<FirebaseAuth>(
    () => FirebaseAuth.instance,
  );

  getIt.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );

  // --------------------------------------------------
  // Data sources
  // --------------------------------------------------

  getIt.registerLazySingleton<AuthFirebaseDataSource>(
    () => AuthFirebaseDataSourceImpl(
      auth: getIt<FirebaseAuth>(),
    ),
  );

  getIt.registerLazySingleton<UsersFirestoreDataSource>(
    () => UsersFirestoreDataSourceImpl(
      firestore: getIt<FirebaseFirestore>(),
    ),
  );

  // --------------------------------------------------
  // Repository
  // --------------------------------------------------

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authDataSource: getIt<AuthFirebaseDataSource>(),
      usersDataSource:
          getIt<UsersFirestoreDataSource>(),
    ),
  );

  // --------------------------------------------------
  // Use cases
  // --------------------------------------------------

  getIt.registerLazySingleton<SignIn>(
    () => SignIn(
      getIt<AuthRepository>(),
    ),
  );

  getIt.registerLazySingleton<SignOut>(
    () => SignOut(
      getIt<AuthRepository>(),
    ),
  );

  getIt.registerLazySingleton<WatchAuthState>(
    () => WatchAuthState(
      getIt<AuthRepository>(),
    ),
  );

  getIt.registerLazySingleton<ValidateActiveUser>(
    () => const ValidateActiveUser(),
  );

  // --------------------------------------------------
  // Bloc
  // --------------------------------------------------

  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(
      watchAuthState: getIt<WatchAuthState>(),
      signIn: getIt<SignIn>(),
      signOut: getIt<SignOut>(),
      validateActiveUser:
          getIt<ValidateActiveUser>(),
    ),
  );
}