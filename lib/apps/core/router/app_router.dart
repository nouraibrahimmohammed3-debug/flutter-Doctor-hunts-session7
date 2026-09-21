import 'package:doctor_hunt/apps/features/admin/presentation/bloc/admin_doctors/admin_doctors_bloc.dart';
import 'package:doctor_hunt/apps/features/admin/presentation/bloc/admin_doctors/admin_doctors_event.dart';
import 'package:doctor_hunt/apps/features/admin/presentation/screen/admin_doctor.dart';
import 'package:doctor_hunt/apps/features/admin/presentation/screen/creat_doctor_admin.dart';
import 'package:doctor_hunt/apps/features/auth/data/models/user_role.dart';
import 'package:doctor_hunt/apps/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:doctor_hunt/apps/features/auth/presentation/screens/admin_login_screen.dart';
import 'package:doctor_hunt/apps/features/choose_role/presentation/screens/choose_role_screen.dart';
import 'package:doctor_hunt/apps/features/patient/appointments/presentation/screens/select_time_screen.dart';
import 'package:doctor_hunt/apps/features/patient/doctors/presentation/screens/doctor_details_screen.dart';
import 'package:doctor_hunt/apps/features/patient/doctors/presentation/screens/find_doctors_screen.dart';
import 'package:doctor_hunt/apps/features/patient/favourites/presentation/screens/favorite_doctors_screen.dart';
import 'package:doctor_hunt/apps/features/patient/home/presentation/bloc/home_doctors_bloc.dart';
import 'package:doctor_hunt/apps/features/patient/home/presentation/screens/home_screen.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/data/models/doctor_model.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/data/services/doctors_firestore_service.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/data/services/doctors_service.dart';
import 'package:doctor_hunt/apps/features/shared/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:doctor_hunt/apps/features/shared/splash/presentation/screens/splash_screen.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AuthRouterRefreshNotifier extends ChangeNotifier {
  AuthRouterRefreshNotifier(AuthBloc authBloc) {
    _subscription = authBloc.stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<AuthState> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

abstract final class AppRouter {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String chooseRole = '/choose_role';
  static const String home = '/home';
  static const String findDoctors = '/find-doctors';
  static const String doctorDetails = '/doctor/:doctorId';
  static const String favorites = '/favorites';
  static const String adminLogin = '/admin_login';
  static const String adminDoctor = '/admin_doctor';
  static const String createDoctor = '/admin/create-doctor';
  static const String selectTime = '/doctor/:doctorId/select-time';

  static String doctorDetailsPath(String doctorId) => '/doctor/$doctorId';
  static String selectTimePath(String doctorId) => '/doctor/$doctorId/select-time';

  static GoRouter create(AuthBloc authBloc) {
    final refresh = AuthRouterRefreshNotifier(authBloc);
    return GoRouter(
      refreshListenable: refresh,
      redirect: (context, state) {
        final auth = authBloc.state;
        final path = state.uri.path;
        final publicPaths = <String>{splash, onboarding, login};

        if (auth.status == AuthStatus.initial || auth.status == AuthStatus.loading) {
          return path == splash ? null : splash;
        }

        if (auth.status == AuthStatus.unauthenticated ||
            auth.status == AuthStatus.failure ||
            auth.status == AuthStatus.inactive) {
          return publicPaths.contains(path) ? null : login;
        }

        final user = auth.user;
        if (auth.status == AuthStatus.authenticated && user != null) {
          if (path == login || path == onboarding || path == splash) {
            return chooseRole;
          }

          if (path == chooseRole) return null;

          if (path == adminDoctor || path == createDoctor) {
            if (!user.hasRole(UserRole.admin) || auth.activeRole != UserRole.admin) {
              return chooseRole;
            }
          }

          if ({home, findDoctors, favorites, doctorDetails}.contains(path) ||
              path.startsWith('/doctor/')) {
            if (!user.hasRole(UserRole.patient) || auth.activeRole != UserRole.patient) {
              return chooseRole;
            }
          }
        }
        return null;
      },
      routes: [
        GoRoute(path: splash, builder: (_, __) => const SplashScreen()),
        GoRoute(path: onboarding, builder: (_, __) => const OnboardingScreen()),
        GoRoute(path: login, builder: (_, __) => const LoginScreen()),
        GoRoute(path: chooseRole, builder: (_, __) => const ChooseRoleScreen()),
        GoRoute(
          path: home,
          builder: (_, __) => BlocProvider(
            create: (_) => HomeDoctorsBloc(doctorsService: DoctorsFirestoreService())..add(const HomeDoctorsStarted()),
            child: const HomeScreen(),
          ),
        ),
        GoRoute(path: findDoctors, builder: (_, __) => const FindDoctorsScreen()),
        GoRoute(
          path: doctorDetails,
          builder: (_, state) {
            final id = state.pathParameters['doctorId']!;
            final extra = state.extra;
            final doctor = extra is DoctorModel ? extra : DoctorsService.doctorById(id);
            return doctor == null ? const SizedBox.shrink() : DoctorDetailsScreen(doctor: doctor);
          },
        ),
        GoRoute(
          path: selectTime,
          builder: (_, state) {
            final id = state.pathParameters['doctorId']!;
            final doctor = DoctorsService.doctorById(id);
            return doctor == null ? const SizedBox.shrink() : SelectTimeScreen(doctor: doctor);
          },
        ),
        GoRoute(path: favorites, builder: (_, __) => const FavoriteDoctorsScreen()),
        GoRoute(path: adminLogin, builder: (_, __) => const LoginScreen()),
        GoRoute(
          path: adminDoctor,
          builder: (_, __) => BlocProvider(
            create: (_) => AdminDoctorsBloc(doctorsService: DoctorsFirestoreService())..add(const AdminDoctorsStarted()),
            child: const AdminDoctorsScreen(),
          ),
        ),
        GoRoute(
          path: createDoctor,
          builder: (_, state) {
            final doctor = state.extra is DoctorModel ? state.extra as DoctorModel : null;
            return BlocProvider(
              create: (_) => AdminDoctorsBloc(doctorsService: DoctorsFirestoreService()),
              child: CreateDoctorScreen(doctor: doctor),
            );
          },
        ),
      ],
    );
  }
}
