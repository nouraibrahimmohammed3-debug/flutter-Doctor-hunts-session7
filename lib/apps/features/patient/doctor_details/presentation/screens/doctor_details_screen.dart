import 'package:doctor_hunt/apps/core/router/app_router.dart';
import 'package:doctor_hunt/apps/core/widgets/doctor_hunt_app_bar.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_hunt/apps/core/di/injection_container.dart';
import 'package:doctor_hunt/apps/features/shared/appointments/data/appointment_service.dart';
import 'package:doctor_hunt/apps/features/patient/favourites/presentation/cubit/favorites_cubit.dart';
import 'package:doctor_hunt/apps/features/patient/favourites/presentation/cubit/favorites_state.dart';
import 'package:go_router/go_router.dart';

import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/data/models/doctor_model.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/presentation/widgets/doctor_image.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';

class DoctorDetailsScreen extends StatelessWidget {
  const DoctorDetailsScreen({required this.doctor, super.key});

  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    var appStrings = context.t;

    return Scaffold(
      appBar: DoctorHuntAppBar(
        title: appStrings.doctorDetails,
        showBackButton: true,
        onBackPressed: () {
          if (context.canPop()) {
            context.pop();
          } else {
            context.go(AppRouter.home);
          }
        },
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            _DoctorSummary(doctor: doctor),
            const SizedBox(height: 18),
            _DoctorStats(doctor: doctor),
            const SizedBox(height: 22),
            Text(appStrings.services, style: context.semiBold16TextMain),
            const SizedBox(height: 12),
            _ServiceItem(number: 1, text: appStrings.serviceOne),
            _ServiceItem(number: 2, text: appStrings.serviceTwo),
            _ServiceItem(number: 3, text: appStrings.serviceThree),
            const SizedBox(height: 22),
            Text(
              appStrings.doctorReviews.title,
              style: context.semiBold16TextMain,
            ),
            const SizedBox(height: 12),
            StreamBuilder<List<Map<String, dynamic>>>(
              stream: getIt<AppointmentService>().watchReviews(doctor.id),
              builder: (context, snapshot) {
                if (snapshot.hasError) return Text(appStrings.retry);
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.data!.isEmpty) {
                  return Text(appStrings.doctorReviews.empty);
                }
                return Column(
                  children: [
                    for (final review in snapshot.data!)
                      Card(
                        child: ListTile(
                          title: Text(review['patientName'] as String? ?? ''),
                          subtitle: Text(review['comment'] as String? ?? ''),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.star, color: AppColors.warning),
                              Text('${review['rating']}/5'),
                            ],
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
            const SizedBox(height: 22),
            Text(appStrings.location, style: context.semiBold16TextMain),
            const SizedBox(height: 12),
            StreamBuilder<String>(
              stream: getIt<AppointmentService>().watchClinicLocation(),
              builder: (_, snapshot) => Text(
                snapshot.hasError
                    ? appStrings.commonUi.clinicLoadFailed
                    : snapshot.data?.isNotEmpty == true
                    ? snapshot.data!
                    : appStrings.commonUi.clinicNotConfigured,
              ),
            ),
            Container(
              height: 190,
              decoration: BoxDecoration(
                color: AppColors.secondaryLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.map_outlined,
                    size: 88,
                    color: AppColors.secondary,
                  ),
                  Icon(Icons.location_on, size: 34, color: AppColors.primary),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DoctorSummary extends StatelessWidget {
  const _DoctorSummary({required this.doctor});

  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    var appStrings = context.t;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: AppColors.boxShadow, blurRadius: 10),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 74,
                  height: 84,
                  child: DoctorImage(imagePath: doctor.imagePath),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(doctor.name, style: context.semiBold16TextMain),
                    Text(
                      doctor.specialtyLabel,
                      style: context.regular11TextSub,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          doctor.rating >= index + 1
                              ? Icons.star
                              : doctor.rating > index
                              ? Icons.star_half
                              : Icons.star_border,
                          size: 15,
                          color: AppColors.warning,
                        ),
                      ),
                    ),
                    Text(
                      appStrings.commonUi.doctorRating(
                        rating: doctor.rating.toStringAsFixed(1),
                        count: doctor.patientStories,
                      ),
                      style: context.regular11TextSub,
                    ),
                  ],
                ),
              ),
              BlocConsumer<FavoritesCubit, FavoritesState>(
                listenWhen: (previous, current) =>
                    current.errorMessage != null &&
                    previous.errorMessage != current.errorMessage,
                listener: (context, state) => ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.errorMessage!))),
                builder: (context, state) => IconButton(
                  onPressed:
                      state.status != FavoritesStatus.success ||
                          state.pendingDoctorIds.contains(doctor.id)
                      ? null
                      : () => context.read<FavoritesCubit>().toggleFavorite(
                          doctor.id,
                        ),
                  icon: Icon(
                    state.favoriteDoctorIds.contains(doctor.id)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: AppColors.danger,
                    size: 21,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: !doctor.isAvailable
                      ? null
                      : () {
                          context.push(
                            AppRouter.selectTimePath(doctor.id),
                            extra: doctor,
                          );
                        },
                  child: Text(appStrings.bookNow, style: context.medium14White),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                appStrings.commonUi.moneyValue(
                  amount: '\$${doctor.price.toStringAsFixed(2)}',
                ),
                style: context.medium14Primary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DoctorStats extends StatelessWidget {
  const _DoctorStats({required this.doctor});

  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    var appStrings = context.t;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: AppColors.boxShadow, blurRadius: 10),
        ],
      ),
      child: Row(
        children: [
          _Stat(
            value: doctor.rating.toStringAsFixed(1),
            label: appStrings.doctorReviews.rating,
          ),
          const _Divider(),
          _Stat(
            value: '${doctor.patientStories}',
            label: appStrings.doctorReviews.count,
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(value, style: context.semiBold16TextMain),
          Text(label, style: context.regular11TextSub),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 34, child: VerticalDivider());
  }
}

class _ServiceItem extends StatelessWidget {
  const _ServiceItem({required this.number, required this.text});

  final int number;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$number.', style: context.medium12Primary),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: context.regular12TextSub)),
        ],
      ),
    );
  }
}
