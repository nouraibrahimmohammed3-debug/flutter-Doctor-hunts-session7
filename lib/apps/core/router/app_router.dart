import 'package:doctor_hunt/apps/features/appointments/presentation/screens/select_time_screen.dart';
import 'package:doctor_hunt/apps/features/auth/presentation/screens/admin_login_screen.dart';
import 'package:doctor_hunt/apps/features/choose_role/presentation/screens/choose_role_screen.dart';
import 'package:doctor_hunt/apps/features/doctors/data/services/doctors_service.dart';
import 'package:doctor_hunt/apps/features/doctors/presentation/screens/doctor_details_screen.dart';
import 'package:doctor_hunt/apps/features/doctors/presentation/screens/find_doctors_screen.dart';
import 'package:doctor_hunt/apps/features/favourites/presentation/screens/favorite_doctors_screen.dart';
import 'package:doctor_hunt/apps/features/home/presentation/screens/home_screen.dart';
import 'package:doctor_hunt/apps/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:doctor_hunt/apps/features/splash/presentation/screens/splash_screen.dart';
import 'package:go_router/go_router.dart';

abstract final class AppRouter {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String chooseRole = '/choose_role';
  static const String home = '/home';
  static const String findDoctors = '/find-doctors';
  static const String doctorDetails = '/doctor/:doctorId';
  static const String favorites = '/favorites';
  static const String admin_login = '/admin_login';

  static String doctorDetailsPath(String doctorId) => '/doctor/$doctorId';
  static const String selectTime = '/doctor/:doctorId/select-time';
  static String selectTimePath(String doctorId) =>
      '/doctor/$doctorId/select-time';

  static final GoRouter route = GoRouter(
    routes: [
      GoRoute(path: splash, builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: chooseRole,
        builder: (context, state) => const ChooseRoleScreen(),
      ),
      GoRoute(path: home, builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: findDoctors,
        builder: (context, state) => const FindDoctorsScreen(),
      ),
      GoRoute(
        path: doctorDetails,
        // redirect: (context, state) {
        //   final id = state.pathParameters['doctorId'];
        //   return DoctorsService.doctorById(id ?? '') == null ? findDoctors : null;
        // },
        builder: (context, state) {
          final id = state.pathParameters['doctorId']!;
          final doctor = DoctorsService.doctorById(id)!;
          return DoctorDetailsScreen(doctor: doctor);
        },
      ),
      GoRoute(
        path: selectTime,
        builder: (context, state) {
          final id = state.pathParameters['doctorId']!;
          final doctor = DoctorsService.doctorById(id)!;
          return SelectTimeScreen(doctor: doctor);
        },
      ),
      GoRoute(
        path: favorites,
        builder: (_, __) => const FavoriteDoctorsScreen(),
      ),
      GoRoute(
        path: admin_login,
        builder: (context, state) => const AdminLoginScreen(),
      ),
    ],
  );
}
