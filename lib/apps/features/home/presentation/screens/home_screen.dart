import 'package:doctor_hunt/apps/core/router/app_router.dart';
import 'package:doctor_hunt/generated/assets.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/apps/features/doctors/data/models/doctor_model.dart';
import 'package:doctor_hunt/apps/features/doctors/data/services/doctors_service.dart';
import 'package:doctor_hunt/apps/features/doctors/presentation/widgets/doctor_image.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final popular = DoctorsService.doctors
        .where((doctor) => doctor.isPopular)
        .toList();
    final featured = DoctorsService.doctors.where((d) => d.isFeatured).toList();

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 24),
          children: [
            HomeHeader(onSearchTap: () => context.go(AppRouter.findDoctors)),
            const SizedBox(height: 22),
            const CategoriesSection(),
            const SizedBox(height: 22),
            DoctorsSection(
              title: t.popularDoctors,
              doctors: popular,
              largeCards: true,
              onSeeAll: () => context.push(AppRouter.findDoctors),
              onDoctorTap: (doctor) =>
                  context.push(AppRouter.doctorDetailsPath(doctor.id)),
            ),
            const SizedBox(height: 22),
            DoctorsSection(
              title: t.featureDoctors,
              doctors: featured,
              onSeeAll: () => context.push(AppRouter.findDoctors),
              onDoctorTap: (doctor) =>
                  context.push(AppRouter.doctorDetailsPath(doctor.id)),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        onDestinationSelected: (int index) {
          if (index == 0) {
            context.go(AppRouter.home);
          } else if (index == 1) {
            context.go(AppRouter.favorites);
          }
        },
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: t.home),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            label: t.favorites,
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            label: t.messages,
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: t.profile,
          ),
        ],
      ),
    );
  }
}

class HomeHeader extends StatelessWidget {
  const HomeHeader({required this.onSearchTap});

  final VoidCallback onSearchTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24.0, 18, 24.0, 20),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(22)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(t.homeGreeting, style: context.regular12White),
                    const SizedBox(height: 3),
                    Text(t.findYourDoctor, style: context.bold20White),
                  ],
                ),
              ),
              const CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.white,
                child: Icon(Icons.person_outline, color: AppColors.primary),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            readOnly: true,
            onTap: onSearchTap,
            decoration: InputDecoration(
              hintText: t.searchDoctor,
              prefixIcon: const Icon(Icons.search, size: 20),
              suffixIcon: const Icon(Icons.close, size: 18),
              filled: true,
              fillColor: AppColors.white,
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      (t.dental, AppAssets.imagesCategoriesDentalPng),
      (t.cardiology, ''),
      (t.ophthalmology, AppAssets.imagesCategoriesOphthalmologyPng),
      (t.generalMedicine, ''),
    ];

    const fallbackIcons = [
      Icons.medical_services_outlined,
      Icons.favorite_outline,
      Icons.visibility_outlined,
      Icons.health_and_safety_outlined,
    ];

    const colors = [
      AppColors.primary,
      AppColors.danger,
      AppColors.warning,
      AppColors.secondary,
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(t.categories, style: context.semiBold16TextMain),
          const SizedBox(height: 12),
          SizedBox(
            height: 105,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final title = category.$1;
                final imagePath = category.$2;

                return Padding(
                  padding: EdgeInsets.only(
                    right: index == categories.length - 1 ? 0 : 10,
                  ),
                  child: SizedBox(
                    width: 75,
                    child: Column(
                      children: [
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: imagePath.isNotEmpty
                                ? Image.asset(imagePath, fit: BoxFit.contain)
                                : DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: colors[index].withValues(
                                        alpha: 0.12,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        fallbackIcons[index],
                                        color: colors[index],
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.regular11TextSub,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DoctorsSection extends StatelessWidget {
  const DoctorsSection({
    required this.title,
    required this.doctors,
    required this.onSeeAll,
    required this.onDoctorTap,
    this.largeCards = false,
  });

  final String title;
  final List<DoctorModel> doctors;
  final VoidCallback onSeeAll;
  final ValueChanged<DoctorModel> onDoctorTap;
  final bool largeCards;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.4),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: Text(title, style: context.semiBold16TextMain)),
              TextButton(
                onPressed: onSeeAll,
                child: Text(t.seeAll, style: context.regular11TextSub),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: largeCards ? 205 : 150,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: doctors.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final doctor = doctors[index];
                return HomeDoctorCard(
                  doctor: doctor,
                  large: largeCards,
                  onTap: () => onDoctorTap(doctor),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class HomeDoctorCard extends StatelessWidget {
  const HomeDoctorCard({
    required this.doctor,
    required this.large,
    required this.onTap,
  });

  final DoctorModel doctor;
  final bool large;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: large ? 158 : 105,
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: AppColors.boxShadow,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: SizedBox(
                  width: double.infinity,
                  child: DoctorImage(imagePath: doctor.imagePath),
                ),
              ),
            ),
            const SizedBox(height: 7),
            Text(
              doctor.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.semiBold12TextMain,
            ),
            const SizedBox(height: 2),
            Text(
              doctor.specialization,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.regular11TextSub,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (_) =>
                    const Icon(Icons.star, size: 12, color: AppColors.warning),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
