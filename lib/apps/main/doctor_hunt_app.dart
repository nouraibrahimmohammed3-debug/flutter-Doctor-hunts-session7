import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/apps/features/doctors/data/services/doctors_service.dart';
import 'package:doctor_hunt/apps/features/favourites/presentation/cubit/favorites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/router/app_router.dart';
//import '../../generated/app_colors.dart';
//import '../../generated/style_atom.dart';

class DoctorHuntApp extends StatelessWidget {
  const DoctorHuntApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FavoritesCubit(
        initialFavoriteIds: DoctorsService.doctors
            .where((doctor) => doctor.isFavorite)
            .map((doctor) => doctor.id),
      ),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.route,
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: AppColors.white,
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        ),
      ),
    );
  }
}
