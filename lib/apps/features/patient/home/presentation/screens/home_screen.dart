import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:doctor_hunt/apps/core/router/app_router.dart';
import 'package:doctor_hunt/apps/features/patient/home/presentation/bloc/home_doctors_bloc.dart';
import 'package:doctor_hunt/apps/features/patient/home/presentation/widgets/categories_section.dart';
import 'package:doctor_hunt/apps/features/patient/home/presentation/widgets/doctors_section.dart';
import 'package:doctor_hunt/apps/features/patient/home/presentation/widgets/home_header.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/data/models/doctor_model.dart';
import 'package:doctor_hunt/generated/strings.g.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeDoctorsBloc, HomeDoctorsState>(
      builder: (context, state) {
        final popular = state.doctors.where((d) => d.isPopular).toList();
        final featured = state.doctors.where((d) => d.isFeatured).toList();

        return Scaffold(
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 24),
              children: [
                HomeHeader(onSearchTap: () => context.go(AppRouter.findDoctors)),
                const SizedBox(height: 22),
                const CategoriesSection(),
                const SizedBox(height: 22),
                if (state.status == HomeDoctorsStatus.loading ||
                    state.status == HomeDoctorsStatus.initial)
                  const Padding(
                    padding: EdgeInsets.all(32),
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (state.status == HomeDoctorsStatus.failure)
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(state.errorMessage ?? 'Failed to load doctors.'),
                  )
                else if (state.status == HomeDoctorsStatus.empty)
                  const Padding(
                    padding: EdgeInsets.all(24),
                    child: Center(child: Text('No doctors available yet.')),
                  )
                else ...[
                  DoctorsSection(
                    title: t.popularDoctors,
                    doctors: popular,
                    largeCards: true,
                    onSeeAll: () => context.push(AppRouter.findDoctors),
                    onDoctorTap: (doctor) => _openDoctor(context, doctor),
                  ),
                  const SizedBox(height: 22),
                  DoctorsSection(
                    title: t.featureDoctors,
                    doctors: featured,
                    onSeeAll: () => context.push(AppRouter.findDoctors),
                    onDoctorTap: (doctor) => _openDoctor(context, doctor),
                  ),
                ],
              ],
            ),
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: 0,
            onDestinationSelected: (index) {
              if (index == 0) context.go(AppRouter.home);
              if (index == 1) context.go(AppRouter.favorites);
            },
            destinations: [
              NavigationDestination(icon: const Icon(Icons.home), label: t.home),
              NavigationDestination(icon: const Icon(Icons.favorite_border), label: t.favorites),
              NavigationDestination(icon: const Icon(Icons.chat_bubble_outline), label: t.messages),
              NavigationDestination(icon: const Icon(Icons.person_outline), label: t.profile),
            ],
          ),
        );
      },
    );
  }

  void _openDoctor(BuildContext context, DoctorModel doctor) {
    context.push(AppRouter.doctorDetailsPath(doctor.id), extra: doctor);
  }
}
