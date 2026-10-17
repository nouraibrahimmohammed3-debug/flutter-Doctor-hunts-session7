import 'package:doctor_hunt/apps/core/extensions/localized_error.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../../core/di/injection_container.dart';
import '../../../../shared/appointments/data/appointment_service.dart';
import '../../../../shared/auth/presentation/bloc/sign_in/auth_bloc.dart';
import '../../../../shared/doctors/data/models/doctor_model.dart';
import '../widgets/appointment_success_card.dart';

class BookingState {
  const BookingState({this.saving = false, this.saved = false, this.error});
  final bool saving;
  final bool saved;
  final String? error;
}

class BookingCubit extends Cubit<BookingState> {
  BookingCubit(this.service) : super(const BookingState());
  final AppointmentService service;
  Future<void> confirm(
    DoctorModel doctor,
    DateTime startsAt,
    AuthBloc auth,
  ) async {
    if (state.saving || state.saved) return;
    final patient = auth.state.user;
    if (patient == null) return;
    emit(const BookingState(saving: true));
    try {
      await service.book(doctor: doctor, patient: patient, startsAt: startsAt);
      if (!isClosed) emit(const BookingState(saved: true));
    } catch (error) {
      if (!isClosed) emit(BookingState(error: localizedError(error)));
    }
  }
}

class ReviewAppointmentScreen extends StatelessWidget {
  const ReviewAppointmentScreen({
    required this.doctor,
    required this.date,
    required this.time,
    super.key,
  });
  final DoctorModel doctor;
  final DateTime date;
  final TimeOfDay time;
  @override
  Widget build(BuildContext context) {
    var appStrings = context.t;
    return BlocProvider(
      create: (_) => BookingCubit(getIt<AppointmentService>()),
      child: BlocConsumer<BookingCubit, BookingState>(
        listener: (context, state) async {
          if (!state.saved) return;
          await showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (_) => AppointmentSuccessCard(
              doctor: doctor,
              selectedDate: date,
              selectedTime: time,
            ),
          );
          if (context.mounted) Navigator.of(context).pop(true);
        },
        builder: (context, state) => PopScope(
          canPop: !state.saving,
          child: Scaffold(
            appBar: AppBar(
              title: Text(appStrings.mvp.reviewAppointment),
              automaticallyImplyLeading: !state.saving,
            ),
            body: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                Text(
                  doctor.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(doctor.specialtyLabel),
                const SizedBox(height: 20),
                Text(
                  DateFormat(
                    'EEE, d MMM yyyy',
                    LocaleSettings.currentLocale.languageCode,
                  ).format(date),
                ),
                Text(
                  appStrings.commonUi.riyadhTime(time: time.format(context)),
                ),
                const SizedBox(height: 16),
                Text(
                  appStrings.commonUi.feeValue(
                    amount: '\$${doctor.price.toStringAsFixed(2)}',
                  ),
                ),
                const SizedBox(height: 16),
                Text(appStrings.mvp.clinicLocation),
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
                if (state.error != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      state.error!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: state.saving || state.saved
                      ? null
                      : () => context.read<BookingCubit>().confirm(
                          doctor,
                          DateTime.utc(
                            date.year,
                            date.month,
                            date.day,
                            time.hour,
                            time.minute,
                          ).subtract(const Duration(hours: 3)),
                          context.read<AuthBloc>(),
                        ),
                  child: Text(
                    state.saving
                        ? appStrings.commonUi.confirming
                        : appStrings.commonUi.confirmBooking,
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
