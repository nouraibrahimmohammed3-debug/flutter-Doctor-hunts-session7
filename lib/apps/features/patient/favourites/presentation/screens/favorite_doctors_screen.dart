import 'package:doctor_hunt/apps/core/router/app_router.dart';
import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/apps/features/patient/favourites/presentation/cubit/favorites_cubit.dart';
import 'package:doctor_hunt/apps/features/patient/favourites/presentation/cubit/favorites_state.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/data/models/doctor_model.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/presentation/widgets/doctor_image.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';
import 'package:doctor_hunt/apps/core/widgets/doctor_hunt_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FavoriteDoctorsScreen extends StatefulWidget {
  const FavoriteDoctorsScreen({super.key});

  @override
  State<FavoriteDoctorsScreen> createState() => _FavoriteDoctorsScreenState();
}

class _FavoriteDoctorsScreenState extends State<FavoriteDoctorsScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appStrings = context.t;

    return Scaffold(
      appBar: AppBar(
        title: Text(appStrings.favorites, style: context.semiBold16TextMain),
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
                  controller: _searchController,
                  onChanged: context.read<FavoritesCubit>().search,
                  decoration: InputDecoration(
                    hintText: appStrings.searchDoctor,
                    prefixIcon: const Icon(
                      Icons.search,
                      color: AppColors.textPlaceholder,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        _searchController.clear();
                        context.read<FavoritesCubit>().search('');
                      },
                      icon: const Icon(
                        Icons.close,
                        color: AppColors.textPlaceholder,
                      ),
                    ),
                    filled: true,
                    fillColor: AppColors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: BlocBuilder<FavoritesCubit, FavoritesState>(
                    builder: (context, state) {
                      if (state.status == FavoritesStatus.initial ||
                          state.status == FavoritesStatus.loading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state.status == FavoritesStatus.failure) {
                        return Center(
                          child: Text(
                            state.errorMessage ??
                                appStrings.commonUi.doctorsLoadFailed,
                            style: context.regular14TextSub,
                            textAlign: TextAlign.center,
                          ),
                        );
                      }

                      final doctors = state.filteredDoctors;

                      if (doctors.isEmpty) {
                        return Center(
                          child: Text(
                            state.searchText.trim().isEmpty
                                ? appStrings.noFavoriteDoctors
                                : appStrings.noDoctorsFound,
                            style: context.regular14TextSub,
                          ),
                        );
                      }

                      return GridView.builder(
                        itemCount: doctors.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              mainAxisExtent: 195,
                            ),
                        itemBuilder: (context, index) {
                          final doctor = doctors[index];

                          return FavoriteDoctorCard(
                            doctor: doctor,
                            onTap: () {
                              context.push(
                                AppRouter.doctorDetailsPath(doctor.id),
                                extra: doctor,
                              );
                            },
                            onFavoriteTap:
                                state.pendingDoctorIds.contains(doctor.id)
                                ? null
                                : () {
                                    context
                                        .read<FavoritesCubit>()
                                        .toggleFavorite(doctor.id);
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
      bottomNavigationBar: DoctorHuntNavigationBar.patient(
        context: context,
        selectedIndex: 1,
      ),
    );
  }
}

class FavoriteDoctorCard extends StatelessWidget {
  const FavoriteDoctorCard({
    super.key,
    required this.doctor,
    required this.onTap,
    required this.onFavoriteTap,
  });

  final DoctorModel doctor;
  final VoidCallback onTap;
  final VoidCallback? onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(color: AppColors.boxShadow, blurRadius: 10),
            ],
          ),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: SizedBox(
                      width: 82,
                      height: 82,
                      child: DoctorImage(imagePath: doctor.imagePath),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    doctor.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: context.semiBold16TextMain,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    doctor.specialtyLabel,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: context.regular11TextSub.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.star,
                        size: 15,
                        color: AppColors.warning,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        doctor.rating.toStringAsFixed(1),
                        style: context.regular11TextSub,
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  onPressed: onFavoriteTap,
                  icon: const Icon(Icons.favorite, color: AppColors.danger),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
