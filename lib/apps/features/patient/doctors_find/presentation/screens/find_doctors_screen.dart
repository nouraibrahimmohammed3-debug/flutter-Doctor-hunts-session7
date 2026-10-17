import 'package:doctor_hunt/apps/features/shared/doctors/data/models/doctor_specialty.dart';
import 'package:doctor_hunt/apps/core/router/app_router.dart';
import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/apps/features/patient/doctors_find/presentation/bloc/doctors_find_bloc.dart';
import 'package:doctor_hunt/apps/features/patient/doctors_find/presentation/bloc/doctors_find_event.dart';
import 'package:doctor_hunt/apps/features/patient/doctors_find/presentation/bloc/doctors_state.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/data/models/doctor_model.dart';
import 'package:doctor_hunt/apps/core/widgets/doctor_hunt_navigation_bar.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/presentation/widgets/doctor_image.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';
import 'package:doctor_hunt/apps/features/patient/favourites/presentation/cubit/favorites_cubit.dart';
import 'package:doctor_hunt/apps/features/patient/favourites/presentation/cubit/favorites_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FindDoctorsScreen extends StatelessWidget {
  const FindDoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const FindDoctorsView();
  }
}

class FindDoctorsView extends StatefulWidget {
  const FindDoctorsView({super.key});

  @override
  State<FindDoctorsView> createState() => _FindDoctorsViewState();
}

class _FindDoctorsViewState extends State<FindDoctorsView> {
  final searchController = TextEditingController();
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appStrings = context.t;

    return Scaffold(
      appBar: AppBar(
        title: Text(appStrings.findDoctors, style: context.semiBold16TextMain),
        actions: [
          IconButton(
            tooltip: appStrings.favorites,
            icon: const Icon(Icons.favorite_outline),
            onPressed: () => context.push(AppRouter.favorites),
          ),
        ],
      ),
      bottomNavigationBar: DoctorHuntNavigationBar.patient(
        context: context,
        selectedIndex: 1,
      ),
      body: BlocListener<FavoritesCubit, FavoritesState>(
        listenWhen: (previous, current) =>
            current.errorMessage != null &&
            previous.errorMessage != current.errorMessage,
        listener: (context, state) => ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(state.errorMessage!))),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                TextField(
                  controller: searchController,
                  onChanged: (value) {
                    context.read<DoctorsFindBloc>().add(
                      DoctorsFindSearchChanged(value),
                    );
                  },
                  decoration: InputDecoration(
                    hintText: appStrings.searchDoctor,
                    prefixIcon: const Icon(Icons.search, size: 20),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.close, size: 18),
                      onPressed: () {
                        searchController.clear();
                        context.read<DoctorsFindBloc>().add(
                          const DoctorsFindSearchChanged(''),
                        );
                      },
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
                BlocBuilder<DoctorsFindBloc, DoctorsFindState>(
                  builder: (context, state) {
                    final specialties =
                        state.doctors
                            .where((doctor) => doctor.isAvailable)
                            .map(
                              (doctor) =>
                                  DoctorSpecialty.id(doctor.specialization),
                            )
                            .toSet()
                            .toList()
                          ..sort();
                    return Column(
                      children: [
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
                                        DoctorSpecialty.id(state.specialty) ==
                                        specialty,
                                    onSelected: (_) =>
                                        context.read<DoctorsFindBloc>().add(
                                          DoctorsFindFiltersChanged(
                                            specialty: specialty,
                                          ),
                                        ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Text(appStrings.mvp.sortBy),
                            const SizedBox(width: 12),
                            DropdownButton<String>(
                              value: state.sortBy,
                              items: [
                                DropdownMenuItem(
                                  value: 'popular',
                                  child: Text(appStrings.mvp.popular),
                                ),
                                DropdownMenuItem(
                                  value: 'rating',
                                  child: Text(appStrings.mvp.topRated),
                                ),
                              ],
                              onChanged: (sort) => context
                                  .read<DoctorsFindBloc>()
                                  .add(DoctorsFindFiltersChanged(sortBy: sort)),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
                Expanded(
                  child: BlocBuilder<DoctorsFindBloc, DoctorsFindState>(
                    builder: (context, state) {
                      if (state.status == DoctorsFindStatus.loading ||
                          state.status == DoctorsFindStatus.initial) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state.status == DoctorsFindStatus.failure) {
                        return Center(
                          child: Text(
                            state.errorMessage ??
                                appStrings.commonUi.doctorsLoadFailed,
                            style: context.regular14TextSub,
                            textAlign: TextAlign.center,
                          ),
                        );
                      }

                      if (state.visibleDoctors.isEmpty) {
                        return Center(
                          child: Text(
                            appStrings.noDoctorsFound,
                            style: context.regular14TextSub,
                          ),
                        );
                      }

                      return ListView.separated(
                        itemCount: state.visibleDoctors.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final doctor = state.visibleDoctors[index];

                          return DoctorListCard(
                            doctor: doctor,
                            onTap: () {
                              context.push(
                                AppRouter.doctorDetailsPath(doctor.id),
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
      ),
    );
  }
}

class DoctorListCard extends StatelessWidget {
  const DoctorListCard({super.key, required this.doctor, required this.onTap});
  final DoctorModel doctor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    var appStrings = context.t;
    final favorites = context.watch<FavoritesCubit>().state;
    final favorite = favorites.favoriteDoctorIds.contains(doctor.id);
    final canFavorite =
        favorites.status == FavoritesStatus.success &&
        !favorites.pendingDoctorIds.contains(doctor.id);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(color: AppColors.boxShadow, blurRadius: 8),
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
                child: DoctorImage(imagePath: doctor.imagePath),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          doctor.name,
                          style: context.semiBold14TextMain,
                        ),
                      ),
                      IconButton(
                        tooltip: favorite
                            ? appStrings.commonUi.removeFavorite
                            : appStrings.commonUi.addFavorite,
                        onPressed: canFavorite
                            ? () => context
                                  .read<FavoritesCubit>()
                                  .toggleFavorite(doctor.id)
                            : null,
                        icon: Icon(
                          favorite ? Icons.favorite : Icons.favorite_border,
                          color: AppColors.danger,
                          size: 21,
                        ),
                      ),
                    ],
                  ),
                  Text(doctor.specialtyLabel, style: context.regular11TextSub),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 13,
                        color: AppColors.warning,
                      ),
                      const SizedBox(width: 3),
                      Expanded(
                        child: Text(
                          appStrings.commonUi.doctorRating(
                            rating: doctor.rating.toStringAsFixed(1),
                            count: doctor.patientStories,
                          ),
                          style: context.regular11TextSub,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  Text(
                    appStrings.commonUi.moneyValue(
                      amount: '\$${doctor.price.toStringAsFixed(2)}',
                    ),
                    style: context.regular11Primary,
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: FilledButton(
                      onPressed: doctor.isAvailable
                          ? () => context.push(
                              AppRouter.selectTimePath(doctor.id),
                              extra: doctor,
                            )
                          : null,
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(76, 32),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                      ),
                      child: Text(
                        appStrings.bookNow,
                        style: context.medium11White,
                      ),
                    ),
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
