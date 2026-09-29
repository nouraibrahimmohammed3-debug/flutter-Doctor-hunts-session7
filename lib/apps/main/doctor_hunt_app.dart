import 'package:doctor_hunt/apps/core/di/injection_container.dart';
import 'package:doctor_hunt/apps/core/router/app_router.dart';
import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/apps/features/patient/favourites/presentation/cubit/favorites_cubit.dart';
import 'package:doctor_hunt/apps/features/shared/auth/presentation/bloc/auth_bloc.dart';
import 'package:doctor_hunt/apps/features/shared/auth/presentation/bloc/auth_event.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/data/services/doctors_firestore_service.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorHuntApp extends StatefulWidget {
  const DoctorHuntApp({super.key});

  @override
  State<DoctorHuntApp> createState() => _DoctorHuntAppState();
}

class _DoctorHuntAppState extends State<DoctorHuntApp> {
  late final AuthBloc _authBloc;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();

    _authBloc = getIt<AuthBloc>()
      ..add(const AuthStarted());

    _router = AppRouter.create(_authBloc);
  }

  @override
  void dispose() {
    _router.dispose();
    _authBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: _authBloc,
        ),

        BlocProvider(
          create: (_) => FavoritesCubit(
            doctorsService: DoctorsFirestoreService(),
          )..start(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: _router,
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: AppColors.white,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
          ),
        ),
      ),
    );
  }
}