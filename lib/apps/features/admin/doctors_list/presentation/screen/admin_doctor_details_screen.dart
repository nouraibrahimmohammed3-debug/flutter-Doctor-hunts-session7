import 'package:doctor_hunt/apps/core/extensions/localized_error.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:doctor_hunt/apps/core/di/injection_container.dart';
import 'package:doctor_hunt/apps/core/router/app_router.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/data/models/doctor_model.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/data/services/doctors_firestore_service.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/presentation/widgets/doctor_image.dart';
import 'package:doctor_hunt/generated/strings.g.dart';

class AdminDoctorDetailsState {
  const AdminDoctorDetailsState({
    this.doctor,
    this.loading = true,
    this.saving = false,
    this.error,
  });
  final DoctorModel? doctor;
  final bool loading;
  final bool saving;
  final String? error;
}

class AdminDoctorDetailsCubit extends Cubit<AdminDoctorDetailsState> {
  AdminDoctorDetailsCubit(this.service, String id)
    : super(const AdminDoctorDetailsState()) {
    subscription = service.watchDoctor(id).listen(
      (doctor) {
        var appStrings = t;
        return emit(
          AdminDoctorDetailsState(
            doctor: doctor,
            loading: false,
            saving: state.saving,
            error: doctor == null ? appStrings.doctors.notFound : null,
          ),
        );
      },
      onError: (Object error) => emit(
        AdminDoctorDetailsState(
          doctor: state.doctor,
          loading: false,
          error: localizedError(error),
        ),
      ),
    );
  }
  final DoctorsFirestoreService service;
  late final StreamSubscription<DoctorModel?> subscription;
  Future<void> toggle(bool active) async {
    final doctor = state.doctor;
    if (doctor == null || state.saving) return;
    emit(AdminDoctorDetailsState(doctor: doctor, loading: false, saving: true));
    try {
      await service.updateDoctorAvailability(doctor.id, active);
      if (!isClosed) {
        emit(AdminDoctorDetailsState(doctor: state.doctor, loading: false));
      }
    } catch (error) {
      if (!isClosed) {
        emit(
          AdminDoctorDetailsState(
            doctor: state.doctor,
            loading: false,
            error: localizedError(error),
          ),
        );
      }
    }
  }

  @override
  Future<void> close() async {
    await subscription.cancel();
    return super.close();
  }
}

class AdminDoctorDetailsScreen extends StatelessWidget {
  const AdminDoctorDetailsScreen({required this.doctorId, super.key});
  final String doctorId;
  @override
  Widget build(BuildContext context) {
    var appStrings = context.t;
    return BlocProvider(
      create: (_) =>
          AdminDoctorDetailsCubit(getIt<DoctorsFirestoreService>(), doctorId),
      child: BlocBuilder<AdminDoctorDetailsCubit, AdminDoctorDetailsState>(
        builder: (context, state) {
          final doctor = state.doctor;
          return Scaffold(
            appBar: AppBar(title: Text(appStrings.doctorDetails)),
            body: state.loading
                ? const Center(child: CircularProgressIndicator())
                : doctor == null
                ? Center(
                    child: Text(state.error ?? appStrings.doctors.notFound),
                  )
                : ListView(
                    padding: const EdgeInsets.all(24),
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: DoctorImage(
                                    imagePath: doctor.imagePath,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                doctor.name,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              Text(doctor.specialtyLabel),
                              SwitchListTile(
                                title: Text(
                                  doctor.isAvailable
                                      ? appStrings.commonUi.active
                                      : appStrings.commonUi.inactive,
                                ),
                                value: doctor.isAvailable,
                                onChanged: state.saving
                                    ? null
                                    : context
                                          .read<AdminDoctorDetailsCubit>()
                                          .toggle,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ListTile(
                        title: Text(appStrings.doctorReviews.rating),
                        subtitle: Text(
                          '${doctor.rating.toStringAsFixed(1)} / 5 - ${doctor.patientStories} ${appStrings.doctorReviews.count}',
                        ),
                      ),
                      ListTile(
                        title: Text(appStrings.mvp.consultationFee),
                        subtitle: Text(
                          appStrings.commonUi.moneyValue(
                            amount: '\$${doctor.price.toStringAsFixed(2)}',
                          ),
                        ),
                      ),
                      if (state.error != null)
                        Text(
                          state.error!,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      const SizedBox(height: 24),
                      FilledButton(
                        onPressed: state.saving
                            ? null
                            : () => context.push(
                                AppRouter.editDoctor,
                                extra: doctor,
                              ),
                        child: Text(appStrings.editDoctor),
                      ),
                      OutlinedButton.icon(
                        onPressed: state.saving
                            ? null
                            : () => context.push(
                                AppRouter.doctorAvailability,
                                extra: doctor,
                              ),
                        icon: const Icon(Icons.schedule),
                        label: Text(appStrings.mvp.manageAvailability),
                      ),
                      OutlinedButton.icon(
                        onPressed: state.saving
                            ? null
                            : () => context.push(
                                AppRouter.adminAppointments,
                                extra: doctor,
                              ),
                        icon: const Icon(Icons.calendar_month),
                        label: Text(appStrings.mvp.appointments),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
