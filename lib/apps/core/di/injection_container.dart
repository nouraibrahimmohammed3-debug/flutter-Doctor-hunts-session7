import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_hunt/apps/features/shared/profile/data/profile_service.dart';
import 'package:doctor_hunt/apps/features/shared/appointments/data/appointment_service.dart';
import 'package:doctor_hunt/apps/features/patient/favourites/data/services/favorites_firestore_service.dart';
import 'package:doctor_hunt/apps/features/patient/favourites/presentation/cubit/favorites_cubit.dart';
import 'package:doctor_hunt/apps/features/admin/deactivate_doctor/bloc/deactivate_doctor_bloc.dart';
import 'package:doctor_hunt/apps/features/admin/doctors_list/presentation/bloc/admin_doctors/admin_doctors_bloc.dart';
import 'package:doctor_hunt/apps/features/patient/home/presentation/bloc/home_doctors_bloc.dart';
import 'package:doctor_hunt/apps/features/patient/doctors_find/presentation/bloc/doctors_find_bloc.dart';
import 'package:doctor_hunt/apps/features/shared/auth/domain/usecases/sign_up.dart';
import 'package:doctor_hunt/apps/features/shared/auth/presentation/bloc/change_password/change_password_bloc.dart';
import 'package:doctor_hunt/apps/features/shared/auth/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:doctor_hunt/apps/features/shared/auth/presentation/bloc/sign_up/sign_up_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/data/services/doctor_photo_service.dart';
import 'package:get_it/get_it.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/presentation/cubit/doctor_load_cubit.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/data/models/doctor_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:doctor_hunt/apps/features/shared/doctors/data/services/doctors_firestore_service.dart';

import '../../features/admin/add_doctor/bloc/add_doctor_bloc.dart';
import '../../features/admin/edit_doctor/bloc/edit_doctor_bloc.dart';

import '../../features/shared/auth/data/datasources/active_role_local_datasource.dart';
import '../../features/shared/auth/data/datasources/auth_firebase_datasource.dart';
import '../../features/shared/auth/data/datasources/users_firestore_datasource.dart';
import '../../features/shared/auth/data/repository/auth_repository_impl.dart';
import '../../features/shared/auth/domain/repositories/auth_repository.dart';
import '../../features/shared/auth/domain/usecases/change_password.dart';
import '../../features/shared/auth/domain/usecases/send_password_reset_email.dart';
import '../../features/shared/auth/domain/usecases/sign_in.dart';
import '../../features/shared/auth/domain/usecases/sign_out.dart';
import '../../features/shared/auth/domain/usecases/validate_active_user.dart';
import '../../features/shared/auth/domain/usecases/watch_auth_state.dart';
import '../../features/shared/auth/presentation/bloc/sign_in/auth_bloc.dart';

final getIt = GetIt.instance;

void setupDependencies({required SharedPreferences sharedPreferences}) {
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  getIt.registerLazySingleton<ActiveRoleLocalDataSource>(
    () => ActiveRoleLocalDataSource(getIt<SharedPreferences>()),
  );

  // Firebase
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  getIt.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );

  // Doctors
  getIt.registerLazySingleton<ProfileService>(
    () => ProfileService(
      firestore: getIt<FirebaseFirestore>(),
      auth: getIt<FirebaseAuth>(),
      photos: getIt<DoctorPhotoService>(),
    ),
  );
  getIt.registerLazySingleton<AppointmentService>(
    () => AppointmentService(firestore: getIt<FirebaseFirestore>()),
  );
  getIt.registerLazySingleton<DoctorPhotoService>(
    () => DoctorPhotoService(storage: FirebaseStorage.instance),
  );
  getIt.registerLazySingleton<DoctorsFirestoreService>(
    () => DoctorsFirestoreService(firestore: getIt<FirebaseFirestore>()),
  );

  // Auth Data Sources
  getIt.registerLazySingleton<AuthFirebaseDataSource>(
    () => AuthFirebaseDataSourceImpl(auth: getIt<FirebaseAuth>()),
  );

  getIt.registerLazySingleton<UsersFirestoreDataSource>(
    () => UsersFirestoreDataSourceImpl(firestore: getIt<FirebaseFirestore>()),
  );

  // Auth Repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authDataSource: getIt<AuthFirebaseDataSource>(),
      usersDataSource: getIt<UsersFirestoreDataSource>(),
    ),
  );

  // Auth Use Cases
  getIt.registerLazySingleton<SignIn>(() => SignIn(getIt<AuthRepository>()));

  getIt.registerLazySingleton<SignOut>(() => SignOut(getIt<AuthRepository>()));

  getIt.registerLazySingleton<SignUp>(() => SignUp(getIt<AuthRepository>()));

  getIt.registerLazySingleton<WatchAuthState>(
    () => WatchAuthState(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<ValidateActiveUser>(
    () => const ValidateActiveUser(),
  );
  // Forgot Password
  getIt.registerLazySingleton<SendPasswordResetEmail>(
    () => SendPasswordResetEmail(getIt<AuthRepository>()),
  );
  getIt.registerFactory<ForgotPasswordBloc>(
    () => ForgotPasswordBloc(
      sendPasswordResetEmail: getIt<SendPasswordResetEmail>(),
    ),
  );

  // Change Password
  getIt.registerLazySingleton<ChangePassword>(
    () => ChangePassword(getIt<AuthRepository>()),
  );
  getIt.registerFactory<ChangePasswordBloc>(
    () => ChangePasswordBloc(changePassword: getIt<ChangePassword>()),
  );

  // Auth Bloc
  getIt.registerLazySingleton<AuthBloc>(
    () => AuthBloc(
      watchAuthState: getIt<WatchAuthState>(),
      signIn: getIt<SignIn>(),
      signOut: getIt<SignOut>(),
      validateActiveUser: getIt<ValidateActiveUser>(),
      activeRoleLocalDataSource: getIt<ActiveRoleLocalDataSource>(),
    ),
  );

  // Sign Up
  getIt.registerFactory<SignUpBloc>(() => SignUpBloc(signUp: getIt<SignUp>()));

  // Admin Blocs
  getIt.registerFactory<AddDoctorBloc>(
    () => AddDoctorBloc(doctorsService: getIt<DoctorsFirestoreService>()),
  );

  getIt.registerFactory<EditDoctorBloc>(
    () => EditDoctorBloc(doctorsService: getIt<DoctorsFirestoreService>()),
  );

  getIt.registerFactory<AdminDoctorsBloc>(
    () => AdminDoctorsBloc(doctorsService: getIt<DoctorsFirestoreService>()),
  );

  getIt.registerFactory<DeactivateDoctorBloc>(
    () => DeactivateDoctorBloc(repository: getIt<DoctorsFirestoreService>()),
  );

  // Patient Blocs
  getIt.registerFactoryParam<DoctorLoadCubit, String, DoctorModel?>(
    (doctorId, initialDoctor) => DoctorLoadCubit(
      doctorId: doctorId,
      initialDoctor: initialDoctor,
      service: getIt<DoctorsFirestoreService>(),
    ),
  );
  getIt.registerFactory<DoctorsFindBloc>(
    () => DoctorsFindBloc(doctorsService: getIt<DoctorsFirestoreService>()),
  );
  getIt.registerLazySingleton<FavoritesFirestoreService>(
    () => FavoritesFirestoreService(firestore: getIt<FirebaseFirestore>()),
  );
  getIt.registerFactoryParam<FavoritesCubit, String?, void>(
    (userId, _) => FavoritesCubit(
      doctorsService: getIt<DoctorsFirestoreService>(),
      favoritesService: getIt<FavoritesFirestoreService>(),
      userId: userId,
    ),
  );
  getIt.registerFactory<HomeDoctorsBloc>(
    () => HomeDoctorsBloc(doctorsService: getIt<DoctorsFirestoreService>()),
  );
}
