import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_hunt/apps/features/patient/favourites/presentation/cubit/favorites_cubit.dart';
import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/data/models/doctor_model.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/presentation/widgets/doctor_image.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';

class DoctorsSection extends StatelessWidget {
  const DoctorsSection({
    super.key,
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
    var appStrings = context.t;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: Text(title, style: context.semiBold16TextMain)),
              TextButton(
                onPressed: onSeeAll,
                child: Text(appStrings.seeAll, style: context.regular11TextSub),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: largeCards ? 270 : 132,
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
    super.key,
    required this.doctor,
    required this.large,
    required this.onTap,
  });

  final DoctorModel doctor;
  final bool large;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    var appStrings = context.t;
    final favorite = context.select(
      (FavoritesCubit bloc) => bloc.state.favoriteDoctorIds.contains(doctor.id),
    );
    final pending = context.select(
      (FavoritesCubit bloc) => bloc.state.pendingDoctorIds.contains(doctor.id),
    );
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: large ? 180 : 100,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: AppColors.boxShadow,
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            if (!large)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    constraints: const BoxConstraints(
                      minWidth: 36,
                      minHeight: 32,
                    ),
                    padding: EdgeInsets.zero,
                    tooltip: appStrings.favorites,
                    onPressed: pending
                        ? null
                        : () => context.read<FavoritesCubit>().toggleFavorite(
                            doctor.id,
                          ),
                    icon: Icon(
                      favorite ? Icons.favorite : Icons.favorite_border,
                      color: favorite ? Colors.red : AppColors.textSub,
                      size: 14,
                    ),
                  ),
                  const Icon(Icons.star, color: AppColors.warning, size: 12),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 8),
                    child: Text(
                      doctor.rating.toStringAsFixed(1),
                      style: context.medium11TextMain,
                    ),
                  ),
                ],
              ),
            Expanded(
              child: large
                  ? SizedBox(
                      width: double.infinity,
                      child: DoctorImage(imagePath: doctor.imagePath),
                    )
                  : Center(
                      child: ClipOval(
                        child: SizedBox(
                          width: 56,
                          height: 56,
                          child: DoctorImage(imagePath: doctor.imagePath),
                        ),
                      ),
                    ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                6,
                large ? 10 : 6,
                6,
                large ? 12 : 14,
              ),
              child: Column(
                children: [
                  Text(
                    doctor.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: large
                        ? context.semiBold16TextMain
                        : context.semiBold11TextMain,
                  ),
                  if (large) ...[
                    const SizedBox(height: 3),
                    Text(
                      doctor.specialtyLabel,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.regular11TextSub,
                    ),
                    const SizedBox(height: 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        5,
                        (index) => Icon(
                          index < doctor.rating.round()
                              ? Icons.star
                              : Icons.star_border,
                          size: 13,
                          color: AppColors.warning,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
