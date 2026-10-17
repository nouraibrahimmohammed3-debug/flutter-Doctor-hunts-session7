import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

import 'package:doctor_hunt/apps/core/di/injection_container.dart';
import 'package:doctor_hunt/apps/core/router/app_router.dart';
import 'package:doctor_hunt/apps/core/themes/app_theme.dart';
import 'package:doctor_hunt/apps/features/shared/auth/domain/entities/user_role.dart';
import 'package:doctor_hunt/apps/features/patient/favourites/presentation/cubit/favorites_cubit.dart';
import 'package:doctor_hunt/apps/features/shared/auth/presentation/bloc/sign_in/auth_bloc.dart';
import 'package:doctor_hunt/apps/features/shared/auth/presentation/bloc/sign_in/auth_event.dart';
import 'package:doctor_hunt/apps/features/shared/auth/presentation/bloc/sign_in/auth_state.dart';
import 'package:doctor_hunt/generated/strings.g.dart'; // ملف slang المولّد

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

    _authBloc = getIt<AuthBloc>()..add(const AuthStarted());
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
    return BlocListener<AuthBloc, AuthState>(
      bloc: _authBloc,
      listenWhen: (previous, current) =>
          previous.user?.language != current.user?.language,
      listener: (_, state) {
        if (state.user != null) {
          LocaleSettings.setLocale(
            state.user!.language == 'ar' ? AppLocale.ar : AppLocale.en,
          );
        }
      },
      child: MultiBlocProvider(
        providers: [BlocProvider.value(value: _authBloc)],
        child: BlocBuilder<AuthBloc, AuthState>(
          buildWhen: (previous, current) =>
              previous.user?.uid != current.user?.uid,
          builder: (context, authState) => BlocProvider(
            key: ValueKey(authState.user?.uid),
            create: (_) =>
                getIt<FavoritesCubit>(param1: authState.user?.uid)..start(),
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: _router,

              locale: TranslationProvider.of(context).flutterLocale,
              supportedLocales: AppLocaleUtils.supportedLocales,
              localizationsDelegates: GlobalMaterialLocalizations.delegates,

              theme: AppTheme.light,
              builder: (context, child) => BlocBuilder<AuthBloc, AuthState>(
                buildWhen: (previous, current) =>
                    previous.activeRole != current.activeRole,
                builder: (_, state) => DesignBackground(
                  admin: state.activeRole == UserRole.admin,
                  child: child ?? const SizedBox.shrink(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
