import 'dart:async';
import 'package:doctor_hunt/apps/features/admin/doctors_list/presentation/screen/admin_doctor_details_screen.dart';
import 'package:doctor_hunt/apps/features/shared/profile/presentation/screens/edit_profile_screen.dart';
import 'package:doctor_hunt/apps/features/shared/profile/presentation/screens/settings_screen.dart';
import 'package:doctor_hunt/apps/features/shared/profile/presentation/screens/privacy_policy_screen.dart';
import 'package:doctor_hunt/apps/features/admin/availability/presentation/admin_settings_screen.dart';
import 'package:doctor_hunt/apps/features/shared/appointments/presentation/appointments_screen.dart';
import 'package:doctor_hunt/apps/features/admin/availability/presentation/doctor_availability_screen.dart';

import 'package:doctor_hunt/apps/core/di/injection_container.dart';
import 'package:doctor_hunt/apps/features/admin/add_doctor/presentation/screen/add_doctor_screen.dart';
import 'package:doctor_hunt/apps/features/admin/doctors_list/presentation/bloc/admin_doctors/admin_doctors_bloc.dart';
import 'package:doctor_hunt/apps/features/admin/doctors_list/presentation/bloc/admin_doctors/admin_doctors_event.dart';
import 'package:doctor_hunt/apps/features/admin/doctors_list/presentation/screen/admin_doctor.dart';
import 'package:doctor_hunt/apps/features/admin/edit_doctor/presentation/screen/edit_doctor.dart';
import 'package:doctor_hunt/apps/features/patient/appointments/presentation/screens/select_time_screen.dart';
import 'package:doctor_hunt/apps/features/patient/doctor_details/presentation/screens/doctor_details_screen.dart';
import 'package:doctor_hunt/apps/features/patient/doctors_find/presentation/bloc/doctors_find_bloc.dart';
import 'package:doctor_hunt/apps/features/patient/doctors_find/presentation/bloc/doctors_find_event.dart';
import 'package:doctor_hunt/apps/features/patient/doctors_find/presentation/screens/find_doctors_screen.dart';
import 'package:doctor_hunt/apps/features/patient/favourites/presentation/screens/favorite_doctors_screen.dart';
import 'package:doctor_hunt/apps/features/patient/home/presentation/bloc/home_doctors_bloc.dart';
import 'package:doctor_hunt/apps/features/patient/home/presentation/bloc/home_doctors_event.dart';
import 'package:doctor_hunt/apps/features/patient/home/presentation/screens/home_screen.dart';
import 'package:doctor_hunt/apps/features/shared/auth/domain/entities/user_role.dart';
import 'package:doctor_hunt/apps/features/shared/auth/presentation/bloc/sign_in/auth_bloc.dart';
import 'package:doctor_hunt/apps/features/shared/auth/presentation/bloc/sign_in/auth_state.dart';
import 'package:doctor_hunt/apps/features/shared/auth/presentation/screens/change_password_screen.dart';
import 'package:doctor_hunt/apps/features/shared/auth/presentation/screens/forgot_password_screen.dart';
import 'package:doctor_hunt/apps/features/shared/auth/presentation/screens/login_screen.dart';
import 'package:doctor_hunt/apps/features/shared/auth/presentation/screens/sign_up_screen.dart';
import 'package:doctor_hunt/apps/features/shared/choose_role/presentation/screens/choose_role_screen.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/data/models/doctor_model.dart';
import 'package:doctor_hunt/apps/features/shared/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:doctor_hunt/apps/features/shared/profile/presentation/screens/profile_screen.dart';
import 'package:doctor_hunt/apps/features/shared/splash/presentation/screens/splash_screen.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/presentation/screens/doctor_route_screen.dart';
import 'package:go_router/go_router.dart';

abstract final class AppRouter {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String chooseRole = '/choose_role';
  static const String signUp = '/sign_up';
  static const String profile = '/profile';
  static const String editProfile = '/profile/edit';
  static const String settings = '/settings';
  static const String privacyPolicy = '/settings/privacy-policy';
  static const String home = '/home';
  static const String findDoctors = '/find-doctors';
  static const String doctorDetails = '/doctor/:doctorId';
  static const String favorites = '/favorites';
  static const String selectTime = '/doctor/:doctorId/select-time';
  static const String forgotPassword = '/forgot-password';
  static const String changePassword = '/change-password';

  static const String adminLogin = '/admin_login';
  static const String adminDoctor = '/admin_doctor';
  static const String createDoctor = '/admin/create-doctor';
  static const String editDoctor = '/admin/edit-doctor';
  static const String doctorAvailability = '/admin/doctor-availability';
  static const String appointments = '/appointments';
  static const String adminAppointments = '/admin/appointments';
  static const String clinicLocation = '/admin/clinic-location';
  static const String adminSettings = '/admin/settings';
  static String adminDoctorDetailsPath(String doctorId) =>
      '/admin/doctor/$doctorId';

  static String doctorDetailsPath(String doctorId) => '/doctor/$doctorId';

  static String selectTimePath(String doctorId) =>
      '/doctor/$doctorId/select-time';

  static GoRouter create(AuthBloc authBloc) {
    final refresh = AuthRouterRefreshNotifier(authBloc);
    String? pendingDoctorLocation;

    return GoRouter(
      initialLocation: splash,
      refreshListenable: refresh,
      redirect: (context, state) {
        final auth = authBloc.state;
        final path = state.uri.path;
        if (!auth.isAuthenticated &&
            RegExp(r'^/doctor/[^/]+(?:/select-time)?$').hasMatch(path)) {
          pendingDoctorLocation = state.uri.toString();
        }

        if (auth.status == AuthStatus.initial ||
            auth.status == AuthStatus.loading) {
          final isAuthPublicScreen =
              path == splash ||
              path == onboarding ||
              path == login ||
              path == signUp ||
              path == adminLogin ||
              path == chooseRole ||
              path == forgotPassword;

          return isAuthPublicScreen ? null : splash;
        }

        if (!auth.isAuthenticated) {
          final isUnauthenticatedAllowedRoute =
              path == splash ||
              path == onboarding ||
              path == chooseRole ||
              path == login ||
              path == signUp ||
              path == adminLogin ||
              path == forgotPassword;

          return isUnauthenticatedAllowedRoute ? null : chooseRole;
        }

        final user = auth.user!;
        final activeRole = auth.activeRole;

        if (activeRole == null) {
          final isAllowedRoute =
              path == chooseRole ||
              path == login ||
              path == signUp ||
              path == adminLogin ||
              path == forgotPassword;

          return isAllowedRoute ? null : chooseRole;
        }

        final isAuthFlowRoute =
            path == splash ||
            path == onboarding ||
            path == login ||
            path == signUp ||
            path == adminLogin ||
            path == chooseRole ||
            path == forgotPassword;

        if (activeRole == UserRole.patient) {
          if (!user.hasRole(UserRole.patient)) return chooseRole;

          if (path == profile || path == changePassword) return null;
          if (isAuthFlowRoute) {
            final destination = pendingDoctorLocation ?? home;
            pendingDoctorLocation = null;
            return destination;
          }

          final isAdminRoute =
              path == adminDoctor ||
              path == createDoctor ||
              path == doctorAvailability ||
              path == editDoctor;

          if (isAdminRoute || path.startsWith('/admin/')) return home;

          return null;
        }

        if (activeRole == UserRole.admin) {
          pendingDoctorLocation = null;
          if (!user.hasRole(UserRole.admin)) return chooseRole;

          if (path == profile || path == changePassword) return null;
          if (isAuthFlowRoute) return adminDoctor;

          final isPatientRoute =
              path == home ||
              path == findDoctors ||
              path == favorites ||
              path == appointments ||
              path.startsWith('/doctor/');

          if (isPatientRoute) return adminDoctor;

          return null;
        }

        return null;
      },
      routes: [
        GoRoute(
          path: '/admin/doctor/:doctorId',
          builder: (_, state) => AdminDoctorDetailsScreen(
            doctorId: state.pathParameters['doctorId']!,
          ),
        ),
        GoRoute(
          path: editProfile,
          builder: (_, state) => EditProfileScreen(
            pickPhotoOnOpen: state.uri.queryParameters['photo'] == 'true',
          ),
        ),
        GoRoute(path: settings, builder: (_, __) => const SettingsScreen()),
        GoRoute(
          path: privacyPolicy,
          builder: (_, __) => const PrivacyPolicyScreen(),
        ),
        GoRoute(
          path: adminSettings,
          builder: (_, __) => const AdminSettingsScreen(),
        ),
        GoRoute(
          path: appointments,
          builder: (_, __) => const AppointmentsScreen(),
        ),
        GoRoute(
          path: adminAppointments,
          builder: (_, state) {
            final doctor = state.extra;
            return AppointmentsScreen(
              admin: true,
              doctorId: doctor is DoctorModel ? doctor.id : null,
              doctorName: doctor is DoctorModel ? doctor.name : null,
            );
          },
        ),
        GoRoute(
          path: clinicLocation,
          builder: (_, __) => const ClinicLocationScreen(),
        ),
        GoRoute(
          path: doctorAvailability,
          builder: (_, state) {
            var appStrings = t;
            final doctor = state.extra;
            return doctor is DoctorModel
                ? DoctorAvailabilityScreen(doctor: doctor)
                : Scaffold(
                    body: Center(child: Text(appStrings.doctors.notFound)),
                  );
          },
        ),
        GoRoute(path: splash, builder: (_, __) => const SplashScreen()),
        GoRoute(path: onboarding, builder: (_, __) => const OnboardingScreen()),
        GoRoute(path: chooseRole, builder: (_, __) => const ChooseRoleScreen()),
        GoRoute(
          path: login,
          builder: (context, state) {
            final role = state.extra is UserRole
                ? state.extra as UserRole
                : UserRole.patient;

            return LoginScreen(role: role);
          },
        ),
        GoRoute(
          path: adminLogin,
          builder: (_, __) => const LoginScreen(role: UserRole.admin),
        ),
        GoRoute(
          path: signUp,
          builder: (context, state) {
            final role = state.extra is UserRole
                ? state.extra as UserRole
                : UserRole.patient;

            return SignUpScreen(role: role);
          },
        ),
        GoRoute(
          path: forgotPassword,
          builder: (_, __) => const ForgotPasswordScreen(),
        ),
        GoRoute(
          path: changePassword,
          builder: (_, __) => const ChangePasswordScreen(),
        ),
        GoRoute(
          path: home,
          builder: (_, __) => BlocProvider<HomeDoctorsBloc>(
            create: (_) =>
                getIt<HomeDoctorsBloc>()..add(const HomeDoctorsStarted()),
            child: const HomeScreen(),
          ),
        ),
        GoRoute(
          path: findDoctors,
          builder: (_, routeState) => BlocProvider<DoctorsFindBloc>(
            create: (_) => getIt<DoctorsFindBloc>()
              ..add(
                DoctorsFindFiltersChanged(
                  specialty: routeState.uri.queryParameters['specialty'] ?? '',
                  sortBy: routeState.uri.queryParameters['sort'] ?? 'popular',
                ),
              )
              ..add(const DoctorsFindStarted()),
            child: const FindDoctorsScreen(),
          ),
        ),
        GoRoute(
          path: doctorDetails,
          builder: (context, state) {
            var appStrings = context.t;
            return DoctorRouteScreen(
              doctorId: state.pathParameters['doctorId']!,
              title: appStrings.doctorDetails,
              initialDoctor: state.extra is DoctorModel
                  ? state.extra as DoctorModel
                  : null,
              builder: (doctor) => DoctorDetailsScreen(doctor: doctor),
            );
          },
        ),
        GoRoute(path: profile, builder: (_, __) => const ProfileScreen()),
        GoRoute(
          path: selectTime,
          builder: (context, state) {
            var appStrings = context.t;
            return DoctorRouteScreen(
              doctorId: state.pathParameters['doctorId']!,
              title: appStrings.selecttime,
              initialDoctor: state.extra is DoctorModel
                  ? state.extra as DoctorModel
                  : null,
              builder: (doctor) => SelectTimeScreen(doctor: doctor),
            );
          },
        ),
        GoRoute(
          path: favorites,
          builder: (_, __) => const FavoriteDoctorsScreen(),
        ),
        GoRoute(
          path: adminDoctor,
          builder: (_, __) => BlocProvider<AdminDoctorsBloc>(
            create: (_) =>
                getIt<AdminDoctorsBloc>()..add(const AdminDoctorsStarted()),
            child: const AdminDoctorsScreen(),
          ),
        ),
        GoRoute(
          path: createDoctor,
          builder: (_, __) => const AddDoctorScreen(),
        ),
        GoRoute(
          path: editDoctor,
          builder: (_, state) {
            var appStrings = t;
            final doctor = state.extra;

            if (doctor is! DoctorModel) {
              return Scaffold(
                body: Center(child: Text(appStrings.doctors.notFound)),
              );
            }

            return EditDoctorScreen(doctor: doctor);
          },
        ),
      ],
    );
  }
}

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
