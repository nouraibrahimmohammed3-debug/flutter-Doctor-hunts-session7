import 'package:doctor_hunt/apps/core/router/app_router.dart';
import 'package:doctor_hunt/apps/features/doctors/data/models/doctor_model.dart';
import 'package:doctor_hunt/apps/features/doctors/data/services/doctors_service.dart';
import 'package:doctor_hunt/apps/features/doctors/presentation/widgets/doctor_image.dart';
import 'package:doctor_hunt/apps/features/favourites/presentation/cubit/favorites_cubit.dart';
import 'package:doctor_hunt/apps/features/favourites/presentation/cubit/favorites_state.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';

class FavoriteDoctorsScreen extends StatelessWidget {
  const FavoriteDoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t.favorites, style: context.semiBold16TextMain),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              TextField(
                onChanged: (value) {
                  context.read<FavoritesCubit>().search(value);
                },
                decoration: InputDecoration(
                  hintText: t.searchDoctor,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppColors.textPlaceholder,
                  ),
                  suffixIcon: const Icon(
                    Icons.close,
                    color: AppColors.textPlaceholder,
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
                    final List<DoctorModel> doctors = DoctorsService.doctors
                        .where((doctor) {
                          final bool isFavorite = state.favoriteDoctorIds
                              .contains(doctor.id);

                          final String query = state.searchText;

                          final bool matchesSearch =
                              query.isEmpty ||
                              doctor.name.toLowerCase().contains(query) ||
                              doctor.specialization.toLowerCase().contains(
                                query,
                              );

                          return isFavorite && matchesSearch;
                        })
                        .toList();

                    if (doctors.isEmpty) {
                      return Center(
                        child: Text(
                          t.noFavoriteDoctors,
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
                            childAspectRatio: 0.82,
                          ),
                      itemBuilder: (context, index) {
                        final DoctorModel doctor = doctors[index];

                        return FavoriteDoctorCard(
                          doctor: doctor,
                          onTap: () {
                            context.push(
                              AppRouter.doctorDetailsPath(doctor.id),
                            );
                          },
                          onFavoriteTap: () {
                            context.read<FavoritesCubit>().toggleFavorite(
                              doctor.id,
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
      bottomNavigationBar: NavigationBar(
        selectedIndex: 1,
        onDestinationSelected: (index) {
          switch (index) {
            case 0:
              context.go(AppRouter.home);

            case 1:
              return;

            case 2:
              return;

            case 3:
              return;
          }
        },
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: t.home,
          ),
          NavigationDestination(
            icon: const Icon(Icons.favorite_border),
            selectedIcon: const Icon(Icons.favorite),
            label: t.favorites,
          ),
          NavigationDestination(
            icon: const Icon(Icons.chat_bubble_outline),
            selectedIcon: const Icon(Icons.chat_bubble),
            label: t.messages,
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline),
            selectedIcon: const Icon(Icons.person),
            label: t.profile,
          ),
        ],
      ),
    );
  }
}

class FavoriteDoctorCard extends StatelessWidget {
  const FavoriteDoctorCard({
    required this.doctor,
    required this.onTap,
    required this.onFavoriteTap,
  });

  final DoctorModel doctor;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;

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
                    doctor.specialization,
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
