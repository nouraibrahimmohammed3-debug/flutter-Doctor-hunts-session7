import 'package:doctor_hunt/apps/features/patient/home/presentation/bloc/home_doctors_state.dart';
import 'package:flutter/material.dart';
import 'package:doctor_hunt/apps/core/widgets/doctor_hunt_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:doctor_hunt/apps/core/router/app_router.dart';
import 'package:doctor_hunt/apps/features/patient/home/presentation/bloc/home_doctors_bloc.dart';
import 'package:doctor_hunt/apps/features/patient/home/presentation/widgets/categories_section.dart';
import 'package:doctor_hunt/apps/features/patient/home/presentation/widgets/doctors_section.dart';
import 'package:doctor_hunt/apps/features/patient/home/presentation/widgets/home_header.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/data/models/doctor_model.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import '../widgets/patient_home_menu.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var appStrings = context.t;

    return PatientHomeMenu(
      builder: (context, openMenu) =>
          BlocBuilder<HomeDoctorsBloc, HomeDoctorsState>(
            builder: (context, state) {
              final popular = state.doctors.where((d) => d.isAvailable).toList()
                ..sort((a, b) => b.patientStories.compareTo(a.patientStories));
              final featured =
                  state.doctors.where((d) => d.isAvailable).toList()
                    ..sort((a, b) => b.rating.compareTo(a.rating));

              return Scaffold(
                backgroundColor: const Color(0xFFF5FBFE),
                body: SafeArea(
                  top: false,
                  child: ListView(
                    padding: const EdgeInsets.only(bottom: 24),
                    children: [
                      HomeHeader(
                        onMenuTap: openMenu,
                        onSearchTap: () => context.go(AppRouter.findDoctors),
                      ),
                      const SizedBox(height: 40),
                      const CategoriesSection(),
                      const SizedBox(height: 40),
                      if (state.status == HomeDoctorsStatus.loading ||
                          state.status == HomeDoctorsStatus.initial)
                        const Padding(
                          padding: EdgeInsets.all(32),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      else if (state.status == HomeDoctorsStatus.failure)
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: Text(
                            state.errorMessage ??
                                appStrings.commonUi.doctorsLoadFailed,
                          ),
                        )
                      else if (state.status == HomeDoctorsStatus.empty)
                        Padding(
                          padding: EdgeInsets.all(24),
                          child: Center(
                            child: Text(appStrings.commonUi.noDoctors),
                          ),
                        )
                      else ...[
                        DoctorsSection(
                          title: appStrings.popularDoctors,
                          doctors: popular,
                          largeCards: true,
                          onSeeAll: () => context.push(AppRouter.findDoctors),
                          onDoctorTap: (doctor) => _openDoctor(context, doctor),
                        ),
                        const SizedBox(height: 22),
                        DoctorsSection(
                          title: appStrings.commonUi.topRatedDoctors,
                          doctors: featured,
                          onSeeAll: () => context.push(
                            '${AppRouter.findDoctors}?sort=rating',
                          ),
                          onDoctorTap: (doctor) => _openDoctor(context, doctor),
                        ),
                      ],
                    ],
                  ),
                ),
                bottomNavigationBar: DoctorHuntNavigationBar.patient(
                  context: context,
                  selectedIndex: 0,
                ),
              );
            },
          ),
    );
  }

  void _openDoctor(BuildContext context, DoctorModel doctor) {
    context.push(AppRouter.doctorDetailsPath(doctor.id), extra: doctor);
  }
}
