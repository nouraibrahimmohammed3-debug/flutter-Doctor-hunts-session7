import 'package:doctor_hunt/apps/features/shared/doctors/data/models/doctor_specialty.dart';
import 'package:doctor_hunt/apps/features/admin/doctors_list/presentation/widgets/count_card.dart';
import 'package:doctor_hunt/apps/features/admin/doctors_list/presentation/widgets/doctor_admin_tile.dart';
import 'package:flutter/material.dart';
import 'package:doctor_hunt/apps/core/widgets/doctor_hunt_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import 'package:doctor_hunt/apps/core/di/injection_container.dart';
import 'package:doctor_hunt/apps/core/router/app_router.dart';
import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/apps/core/widgets/doctor_hunt_app_bar.dart';
import 'package:doctor_hunt/apps/features/admin/deactivate_doctor/bloc/deactivate_doctor_bloc.dart';
import 'package:doctor_hunt/apps/features/admin/deactivate_doctor/bloc/deactivate_doctor_state.dart';
import 'package:doctor_hunt/apps/features/admin/doctors_list/presentation/bloc/admin_doctors/admin_doctors_bloc.dart';
import 'package:doctor_hunt/apps/features/admin/doctors_list/presentation/bloc/admin_doctors/admin_doctors_state.dart';
import 'package:doctor_hunt/apps/features/admin/doctors_list/presentation/bloc/admin_doctors/admin_doctors_event.dart';
import 'package:doctor_hunt/generated/strings.g.dart';

class AdminDoctorsScreen extends StatelessWidget {
  const AdminDoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var appStrings = context.t;

    return BlocProvider(
      create: (_) => getIt<DeactivateDoctorBloc>(),
      child: MultiBlocListener(
        listeners: [
          BlocListener<AdminDoctorsBloc, AdminDoctorsState>(
            listenWhen: (previous, current) =>
                previous.successMessage != current.successMessage ||
                previous.errorMessage != current.errorMessage,
            listener: (context, state) {
              final message = state.successMessage ?? state.errorMessage;

              if (message != null) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(message)));
              }
            },
          ),
          BlocListener<DeactivateDoctorBloc, DeactivateDoctorState>(
            listenWhen: (previous, current) =>
                previous.status != current.status ||
                previous.successMessage != current.successMessage ||
                previous.errorMessage != current.errorMessage,
            listener: (context, state) {
              final message = state.successMessage ?? state.errorMessage;

              if (message != null) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(message)));
              }
            },
          ),
        ],
        child: Scaffold(
          appBar: DoctorHuntAppBar(
            title: appStrings.doctor,
            actions: [
              IconButton(
                onPressed: () {
                  context.push(AppRouter.profile);
                },
                icon: const Icon(Icons.person_outline),
              ),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: BlocBuilder<AdminDoctorsBloc, AdminDoctorsState>(
                builder: (context, state) {
                  final doctors = state.doctors;
                  final visible = state.visibleDoctors;
                  final specialties =
                      doctors
                          .map(
                            (doctor) =>
                                DoctorSpecialty.id(doctor.specialization),
                          )
                          .toSet()
                          .toList()
                        ..sort();

                  final activeCount = doctors
                      .where((doctor) => doctor.isAvailable)
                      .length;

                  return Column(
                    children: [
                      TextFormField(
                        onChanged: (value) => context
                            .read<AdminDoctorsBloc>()
                            .add(AdminDoctorsFiltersChanged(searchText: value)),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          hintText: appStrings.searchDoctors,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: AppColors.alabaster,
                            ),
                          ),
                        ),
                      ),
                      const Gap(12),
                      Row(
                        children: [
                          CountCard(
                            title: appStrings.totalDoctors,
                            value: doctors.length,
                          ),
                          const Gap(14),
                          CountCard(
                            title: appStrings.activeDoctors,
                            value: activeCount,
                          ),
                        ],
                      ),
                      const Gap(16),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (final specialty in ['', ...specialties])
                              Padding(
                                padding: const EdgeInsetsDirectional.only(
                                  end: 8,
                                ),
                                child: ChoiceChip(
                                  label: Text(
                                    specialty.isEmpty
                                        ? appStrings.commonUi.all
                                        : DoctorSpecialty.label(specialty),
                                  ),
                                  selected:
                                      specialty ==
                                      DoctorSpecialty.id(state.specialty),
                                  onSelected: (_) =>
                                      context.read<AdminDoctorsBloc>().add(
                                        AdminDoctorsFiltersChanged(
                                          specialty: specialty,
                                        ),
                                      ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const Gap(12),
                      Expanded(
                        child:
                            state.status == AdminDoctorsStatus.loading &&
                                doctors.isEmpty
                            ? const Center(child: CircularProgressIndicator())
                            : state.status == AdminDoctorsStatus.failure &&
                                  doctors.isEmpty
                            ? Center(
                                child: Text(
                                  state.errorMessage ??
                                      appStrings.commonUi.doctorsLoadFailed,
                                ),
                              )
                            : visible.isEmpty
                            ? Center(child: Text(appStrings.noDoctorsFound))
                            : ListView.separated(
                                padding: const EdgeInsets.only(
                                  top: 12,
                                  bottom: 80,
                                ),
                                itemCount: visible.length,
                                separatorBuilder: (_, __) =>
                                    const SizedBox(height: 12),
                                itemBuilder: (context, index) {
                                  final doctor = visible[index];

                                  return DoctorAdminTile(doctor: doctor);
                                },
                              ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          bottomNavigationBar: DoctorHuntNavigationBar.admin(
            context: context,
            selectedIndex: 0,
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => context.push(AppRouter.createDoctor),
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            icon: const Icon(Icons.add),
            label: Text(appStrings.addDoctor),
          ),
        ),
      ),
    );
  }
}
