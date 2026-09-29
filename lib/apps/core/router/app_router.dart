import 'dart:async';

import 'package:doctor_hunt/apps/features/admin/presentation/bloc/admin_doctors/admin_doctors_bloc.dart';
import 'package:doctor_hunt/apps/features/admin/presentation/bloc/admin_doctors/admin_doctors_event.dart';
import 'package:doctor_hunt/apps/features/admin/presentation/screen/admin_doctor.dart';
import 'package:doctor_hunt/apps/features/admin/presentation/screen/creat_doctor_admin.dart';
import 'package:doctor_hunt/apps/features/patient/appointments/presentation/screens/select_time_screen.dart';
import 'package:doctor_hunt/apps/features/patient/doctor_details/presentation/screens/doctor_details_screen.dart';
import 'package:doctor_hunt/apps/features/patient/doctors_find/presentation/screens/find_doctors_screen.dart';
import 'package:doctor_hunt/apps/features/patient/favourites/presentation/screens/favorite_doctors_screen.dart';
import 'package:doctor_hunt/apps/features/patient/home/presentation/bloc/home_doctors_bloc.dart';
import 'package:doctor_hunt/apps/features/patient/home/presentation/screens/home_screen.dart';
import 'package:doctor_hunt/apps/features/shared/auth/domain/entities/user_role.dart';
import 'package:doctor_hunt/apps/features/shared/auth/presentation/bloc/auth_bloc.dart';
import 'package:doctor_hunt/apps/features/shared/auth/presentation/bloc/auth_state.dart';
import 'package:doctor_hunt/apps/features/shared/auth/presentation/screens/login_screen.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/data/models/doctor_model.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/data/services/doctors_firestore_service.dart';
import 'package:doctor_hunt/apps/features/shared/choose_role/presentation/screens/choose_role_screen.dart';
import 'package:doctor_hunt/apps/features/shared/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:doctor_hunt/apps/features/shared/splash/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:doctor_hunt/apps/features/shared/profile/presentation/screens/profile_screen.dart';

class AuthRouterRefreshNotifier extends ChangeNotifier {
  AuthRouterRefreshNotifier(AuthBloc authBloc) {
    _subscription = authBloc.stream.listen((_) {
      notifyListeners();
    });
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
  static const String profile = '/profile';
  static const String home = '/home';
  static const String findDoctors = '/find-doctors';
  static const String doctorDetails = '/doctor/:doctorId';
  static const String favorites = '/favorites';
  static const String selectTime = '/doctor/:doctorId/select-time';

  static const String adminLogin = '/admin_login';
  static const String adminDoctor = '/admin_doctor';
  static const String createDoctor = '/admin/create-doctor';

  static String doctorDetailsPath(String doctorId) {
    return '/doctor/$doctorId';
  }

  static String selectTimePath(String doctorId) {
    return '/doctor/$doctorId/select-time';
  }

  static GoRouter create(AuthBloc authBloc) {
    final refresh = AuthRouterRefreshNotifier(authBloc);

    return GoRouter(
      initialLocation: splash,
      refreshListenable: refresh,
      redirect: (context, state) {
        final auth = authBloc.state;
        final path = state.uri.path;

        if (auth.status == AuthStatus.initial) {
          return path == splash ? null : splash;
        }

        if (auth.status == AuthStatus.loading) {
          if (path == splash || path == login) {
            return null;
          }

          return splash;
        }

        if (auth.status == AuthStatus.unauthenticated) {
          if (path == splash) {
            return onboarding;
          }

          if (path == onboarding || path == login) {
            return null;
          }

          return login;
        }

        if (auth.status == AuthStatus.failure ||
            auth.status == AuthStatus.inactive) {
          if (path == login) {
            return null;
          }

          return login;
        }

        final user = auth.user;

        if (auth.status == AuthStatus.authenticated && user != null) {
          if (path == splash ||
              path == onboarding ||
              path == login ||
              path == adminLogin) {
            return chooseRole;
          }

          if (path == chooseRole) {
            return null;
          }

          final isAdminRoute = path == adminDoctor || path == createDoctor;

          if (isAdminRoute) {
            final canAccessAdmin =
                user.hasRole(UserRole.admin) &&
                auth.activeRole == UserRole.admin;

            if (!canAccessAdmin) {
              return chooseRole;
            }
          }

          final isPatientRoute =
              path == home ||
              path == findDoctors ||
              path == favorites ||
              path == profile ||
              path == doctorDetails ||
              path == selectTime ||
              path.startsWith('/doctor/');

          if (isPatientRoute) {
            final canAccessPatient =
                user.hasRole(UserRole.patient) &&
                auth.activeRole == UserRole.patient;

            if (!canAccessPatient) {
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
          builder: (_, __) {
            return BlocProvider(
              create: (_) =>
                  HomeDoctorsBloc(doctorsService: DoctorsFirestoreService())
                    ..add(const HomeDoctorsStarted()),
              child: const HomeScreen(),
            );
          },
        ),
        GoRoute(
          path: findDoctors,
          builder: (_, __) => const FindDoctorsScreen(),
        ),
        GoRoute(
          path: doctorDetails,
          builder: (_, state) {
            final doctor = state.extra;

            if (doctor is! DoctorModel) {
              return const Scaffold(
                body: Center(child: Text('Doctor not found')),
              );
            }

            return DoctorDetailsScreen(doctor: doctor);
          },
        ),
        GoRoute(path: profile, builder: (_, __) => const ProfileScreen()),
        GoRoute(
          path: selectTime,
          builder: (_, state) {
            final doctor = state.extra;

            if (doctor is! DoctorModel) {
              return const Scaffold(
                body: Center(child: Text('Doctor not found')),
              );
            }

            return SelectTimeScreen(doctor: doctor);
          },
        ),
        GoRoute(
          path: favorites,
          builder: (_, __) => const FavoriteDoctorsScreen(),
        ),
        GoRoute(path: adminLogin, builder: (_, __) => const LoginScreen()),
        GoRoute(
          path: adminDoctor,
          builder: (_, __) {
            return BlocProvider(
              create: (_) =>
                  AdminDoctorsBloc(doctorsService: DoctorsFirestoreService())
                    ..add(const AdminDoctorsStarted()),
              child: const AdminDoctorsScreen(),
            );
          },
        ),
        GoRoute(
          path: createDoctor,
          builder: (_, state) {
            final doctor = state.extra is DoctorModel
                ? state.extra as DoctorModel
                : null;

            return BlocProvider(
              create: (_) =>
                  AdminDoctorsBloc(doctorsService: DoctorsFirestoreService()),
              child: CreateDoctorScreen(doctor: doctor),
            );
          },
        ),
      ],
    );
  }
}
