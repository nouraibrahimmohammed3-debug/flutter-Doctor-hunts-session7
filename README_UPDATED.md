# Doctor Hunt - Unified Updated Version

This archive contains the full project with the architecture refactor plus the doctor CRUD/Home/BLoC work and the Auth/Roles/GoRouter/Firestore Rules work combined.

Included:
- Feature-Based structure with shared doctors and patient/admin separation.
- Doctor model/service and Firestore stream.
- AdminDoctorsBloc CRUD + availability.
- Reusable DoctorFormFields widget + DoctorFormCubit.
- Home split into reusable widgets and Firestore-driven HomeDoctorsBloc.
- Firebase AuthRepository + AuthBloc.
- UserRole: patient/admin only.
- AppUserModel with roles[] and isActive.
- GoRouter guards for patient/admin routes.
- Firestore rules based on users/{uid}.roles and isActive.

Before running:
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter analyze
flutter run

Note: flutter analyze/run were not executed in the packaging environment because Flutter SDK is not installed there.
