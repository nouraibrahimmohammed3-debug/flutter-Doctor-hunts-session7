import 'package:doctor_hunt/apps/core/router/app_router.dart';
import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/apps/features/patient/doctors_find/presentation/bloc/doctors_find_bloc.dart';
import 'package:doctor_hunt/apps/features/patient/doctors_find/presentation/bloc/doctors_find_event.dart';
import 'package:doctor_hunt/apps/features/patient/doctors_find/presentation/bloc/doctors_state.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/data/models/doctor_model.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/data/services/doctors_firestore_service.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/presentation/widgets/doctor_image.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FindDoctorsScreen extends StatelessWidget {
  const FindDoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DoctorsFindBloc(
        doctorsService: DoctorsFirestoreService(),
      )..add(
          const DoctorsFindStarted(),
        ),
      child: const FindDoctorsView(),
    );
  }
}

class FindDoctorsView extends StatelessWidget {
  const FindDoctorsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          t.findDoctors,
          style: context.semiBold16TextMain,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              TextField(
                onChanged: (value) {
                  context.read<DoctorsFindBloc>().add(
                        DoctorsFindSearchChanged(value),
                      );
                },
                decoration: InputDecoration(
                  hintText: t.dentistSearch,
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 20,
                  ),
                  suffixIcon: const Icon(
                    Icons.close,
                    size: 18,
                  ),
                  filled: true,
                  fillColor: AppColors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<
                    DoctorsFindBloc,
                    DoctorsFindState>(
                  builder: (context, state) {
                    if (state.status ==
                            DoctorsFindStatus.loading ||
                        state.status ==
                            DoctorsFindStatus.initial) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (state.status ==
                        DoctorsFindStatus.failure) {
                      return Center(
                        child: Text(
                          state.errorMessage ??
                              'Failed to load doctors.',
                          style: context.regular14TextSub,
                          textAlign: TextAlign.center,
                        ),
                      );
                    }

                    if (state.filteredDoctors.isEmpty) {
                      return Center(
                        child: Text(
                          t.noDoctorsFound,
                          style: context.regular14TextSub,
                        ),
                      );
                    }

                    return ListView.separated(
                      itemCount:
                          state.filteredDoctors.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final doctor =
                            state.filteredDoctors[index];

                        return DoctorListCard(
                          doctor: doctor,
                          onTap: () {
                            context.push(
                              AppRouter.doctorDetailsPath(
                                doctor.id,
                              ),
                              extra: doctor,
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DoctorListCard extends StatelessWidget {
  const DoctorListCard({
    super.key,
    required this.doctor,
    required this.onTap,
  });

  final DoctorModel doctor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: AppColors.boxShadow,
              blurRadius: 8,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 78,
                height: 88,
                child: DoctorImage(
                  imagePath: doctor.imagePath,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor.name,
                    style: context.semiBold14TextMain,
                  ),
                  Text(
                    doctor.specialization,
                    style: context.regular11TextSub,
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 13,
                        color: AppColors.warning,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        doctor.rating.toStringAsFixed(1),
                        style: context.regular11TextSub,
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          t.nextAvailable,
                          style: context.regular11Primary,
                        ),
                      ),
                      FilledButton(
                        onPressed: onTap,
                        style: FilledButton.styleFrom(
                          minimumSize:
                              const Size(76, 32),
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                        ),
                        child: Text(
                          t.bookNow,
                          style: context.medium11White,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}