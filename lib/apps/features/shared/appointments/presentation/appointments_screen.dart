import 'package:doctor_hunt/apps/core/extensions/localized_error.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:doctor_hunt/apps/core/widgets/doctor_hunt_navigation_bar.dart';
import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/data/services/doctors_firestore_service.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/data/models/doctor_model.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/presentation/widgets/doctor_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:doctor_hunt/apps/core/di/injection_container.dart';
import 'package:doctor_hunt/apps/features/shared/auth/presentation/bloc/sign_in/auth_bloc.dart';
import '../data/appointment_service.dart';
import 'review_screen.dart';

class AppointmentsState {
  const AppointmentsState({
    this.items = const [],
    this.loading = true,
    this.pending = const {},
    this.error,
  });
  final List<Appointment> items;
  final bool loading;
  final Set<String> pending;
  final String? error;
}

class AppointmentsCubit extends Cubit<AppointmentsState> {
  AppointmentsCubit(this.service, {String? patientId, String? doctorId})
    : super(const AppointmentsState()) {
    _subscription = service
        .watchAppointments(patientId: patientId, doctorId: doctorId)
        .listen(
          (items) => emit(
            AppointmentsState(
              items: items,
              loading: false,
              pending: state.pending,
            ),
          ),
          onError: (Object error) => emit(
            AppointmentsState(
              items: state.items,
              loading: false,
              error: localizedError(error),
            ),
          ),
        );
  }
  final AppointmentService service;
  late final StreamSubscription<List<Appointment>> _subscription;
  Future<void> change(Appointment appointment, AppointmentStatus status) async {
    if (state.pending.contains(appointment.id)) return;
    emit(
      AppointmentsState(
        items: state.items,
        loading: false,
        pending: {...state.pending, appointment.id},
      ),
    );
    String? error;
    try {
      await service.changeStatus(appointment, status);
    } catch (exception) {
      error = localizedError(exception);
    }
    if (!isClosed) {
      emit(
        AppointmentsState(
          items: state.items,
          loading: false,
          pending: {...state.pending}..remove(appointment.id),
          error: error,
        ),
      );
    }
  }

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }
}

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({
    this.admin = false,
    this.doctorId,
    this.doctorName,
    super.key,
  });
  final bool admin;
  final String? doctorId;
  final String? doctorName;
  @override
  Widget build(BuildContext context) {
    var appStrings = context.t;

    final user = context.read<AuthBloc>().state.user!;
    final filters = <AppointmentStatus?>[
      if (admin) null,
      ...AppointmentStatus.values,
    ];
    return BlocProvider(
      create: (_) => AppointmentsCubit(
        getIt<AppointmentService>(),
        patientId: admin ? null : user.uid,
        doctorId: doctorId,
      ),
      child: DefaultTabController(
        length: filters.length,
        child: Scaffold(
          bottomNavigationBar: doctorId != null
              ? null
              : admin
              ? DoctorHuntNavigationBar.admin(
                  context: context,
                  selectedIndex: 1,
                )
              : DoctorHuntNavigationBar.patient(
                  context: context,
                  selectedIndex: 2,
                ),
          appBar: AppBar(
            title: Text(
              doctorName == null
                  ? appStrings.commonUi.appointments
                  : appStrings.commonUi.doctorAppointments(name: doctorName!),
            ),
            bottom: TabBar(
              isScrollable: admin,
              tabs: [
                for (final filter in filters)
                  Tab(
                    text: filter == null
                        ? appStrings.commonUi.all
                        : _label(filter),
                  ),
              ],
            ),
          ),
          body: BlocConsumer<AppointmentsCubit, AppointmentsState>(
            listener: (context, state) {
              if (state.error != null) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.error!)));
              }
            },
            builder: (context, state) {
              if (state.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.error != null && state.items.isEmpty) {
                return Center(child: Text(state.error!));
              }
              return TabBarView(
                children: [
                  for (final filter in filters)
                    _AppointmentList(
                      items: state.items
                          .where(
                            (item) => filter == null || item.status == filter,
                          )
                          .toList(),
                      admin: admin,
                      pending: state.pending,
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

String _label(AppointmentStatus status) {
  var appStrings = t;
  return switch (status) {
    AppointmentStatus.upcoming => appStrings.mvp.upcoming,
    AppointmentStatus.completed => appStrings.mvp.completed,
    AppointmentStatus.cancelled => appStrings.mvp.cancelled,
  };
}

class _AppointmentList extends StatelessWidget {
  const _AppointmentList({
    required this.items,
    required this.admin,
    required this.pending,
  });
  final List<Appointment> items;
  final bool admin;
  final Set<String> pending;
  @override
  Widget build(BuildContext context) {
    var appStrings = context.t;

    if (items.isEmpty) {
      return Center(child: Text(appStrings.mvp.noAppointments));
    }
    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final appointment = items[index];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    StreamBuilder<DoctorModel?>(
                      stream: getIt<DoctorsFirestoreService>().watchDoctor(
                        appointment.doctorId,
                      ),
                      builder: (_, snapshot) => ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: SizedBox(
                          width: 62,
                          height: 64,
                          child: DoctorImage(
                            imagePath: snapshot.data?.imagePath ?? '',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            admin
                                ? appointment.patientName
                                : appointment.doctorName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          if (admin)
                            Text(
                              appointment.doctorName,
                              style: const TextStyle(fontSize: 12),
                            ),
                          Text(
                            appointment.specialtyLabel,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textSub,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: appointment.status == AppointmentStatus.cancelled
                            ? AppColors.dangerLight
                            : AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        '● ${_label(appointment.status)}',
                        style: TextStyle(
                          fontSize: 9,
                          color:
                              appointment.status == AppointmentStatus.cancelled
                              ? AppColors.danger
                              : AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Divider(height: 1),
                ),
                Row(
                  children: [
                    Expanded(
                      child: _AppointmentInfo(
                        icon: Icons.calendar_month,
                        label: appStrings.commonUi.appointmentDate,
                        value: DateFormat(
                          'dd MMM yyyy',
                          LocaleSettings.currentLocale.languageCode,
                        ).format(riyadhTime(appointment.startsAt)),
                      ),
                    ),
                    Expanded(
                      child: _AppointmentInfo(
                        icon: Icons.access_time,
                        label: appStrings.commonUi.appointmentTime,
                        value: DateFormat(
                          'hh:mm a',
                          LocaleSettings.currentLocale.languageCode,
                        ).format(riyadhTime(appointment.startsAt)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _AppointmentInfo(
                  icon: Icons.monetization_on_outlined,
                  label: appStrings.commonUi.consultationFee,
                  value: appStrings.commonUi.moneyValue(
                    amount: '\$${appointment.fee.toStringAsFixed(2)}',
                  ),
                ),
                const SizedBox(height: 12),
                if (!admin && appointment.status == AppointmentStatus.completed)
                  if (appointment.reviewRating != null) ...[
                    Text(
                      appStrings.commonUi.yourRating(
                        rating: appointment.reviewRating!,
                      ),
                    ),
                    if (appointment.reviewComment.isNotEmpty)
                      Text(appointment.reviewComment),
                  ] else
                    OutlinedButton.icon(
                      icon: const Icon(Icons.star_outline),
                      label: Text(appStrings.mvp.rateDoctor),
                      onPressed: () async {
                        final saved = await Navigator.of(context).push<bool>(
                          MaterialPageRoute(
                            builder: (_) =>
                                ReviewScreen(appointment: appointment),
                          ),
                        );
                        if (saved == true && context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(appStrings.mvp.thankYou)),
                          );
                        }
                      },
                    ),
                OutlinedButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) =>
                          AppointmentDetailsScreen(appointment: appointment),
                    ),
                  ),
                  child: Text(appStrings.mvp.viewDetails),
                ),
                if (appointment.status == AppointmentStatus.upcoming)
                  Wrap(
                    spacing: 8,
                    children: [
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.danger,
                          backgroundColor: AppColors.dangerLight,
                          side: const BorderSide(color: AppColors.danger),
                        ),
                        onPressed: pending.contains(appointment.id)
                            ? null
                            : () async {
                                final confirmed = await showDialog<bool>(
                                  context: context,
                                  builder: (dialogContext) => AlertDialog(
                                    title: Text(appStrings.mvp.cancelQuestion),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(dialogContext, false),
                                        child: Text(
                                          appStrings.mvp.keepAppointment,
                                        ),
                                      ),
                                      FilledButton(
                                        onPressed: () =>
                                            Navigator.pop(dialogContext, true),
                                        child: Text(
                                          appStrings.mvp.cancelAppointment,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                                if (confirmed == true && context.mounted) {
                                  context.read<AppointmentsCubit>().change(
                                    appointment,
                                    AppointmentStatus.cancelled,
                                  );
                                }
                              },
                        child: Text(appStrings.mvp.cancelAppointment),
                      ),
                      if (admin)
                        FilledButton(
                          onPressed: pending.contains(appointment.id)
                              ? null
                              : () => context.read<AppointmentsCubit>().change(
                                  appointment,
                                  AppointmentStatus.completed,
                                ),
                          child: Text(appStrings.mvp.markCompleted),
                        ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _AppointmentInfo extends StatelessWidget {
  const _AppointmentInfo({
    required this.icon,
    required this.label,
    required this.value,
  });
  final IconData icon;
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Container(
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: AppColors.primaryLight,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Icon(icon, color: AppColors.primary, size: 16),
      ),
      const SizedBox(width: 8),
      Flexible(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 10, color: AppColors.textSub),
            ),
            Text(
              value,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    ],
  );
}

class AppointmentDetailsScreen extends StatelessWidget {
  const AppointmentDetailsScreen({required this.appointment, super.key});
  final Appointment appointment;
  @override
  Widget build(BuildContext context) {
    var appStrings = context.t;
    return Scaffold(
      appBar: AppBar(title: Text(appStrings.mvp.appointmentDetails)),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(appointment.patientName),
          Text(appointment.patientEmail),
          const SizedBox(height: 16),
          Text(appointment.doctorName),
          Text(appointment.specialtyLabel),
          Text(_label(appointment.status)),
          const SizedBox(height: 16),
          Text(
            appStrings.commonUi.riyadhTime(
              time: DateFormat(
                'dd MMM yyyy, hh:mm a',
                LocaleSettings.currentLocale.languageCode,
              ).format(riyadhTime(appointment.startsAt)),
            ),
          ),
          Text(
            appStrings.commonUi.feeValue(
              amount: '\$${appointment.fee.toStringAsFixed(2)}',
            ),
          ),
          const SizedBox(height: 16),
          Text(appStrings.mvp.clinicLocation),
          StreamBuilder<String>(
            stream: getIt<AppointmentService>().watchClinicLocation(),
            builder: (_, snapshot) => Text(
              snapshot.hasError
                  ? appStrings.commonUi.clinicLoadFailed
                  : snapshot.data ?? appStrings.commonUi.loading,
            ),
          ),
        ],
      ),
    );
  }
}

class ClinicLocationScreen extends StatefulWidget {
  const ClinicLocationScreen({super.key});
  @override
  State<ClinicLocationScreen> createState() => _ClinicLocationScreenState();
}

class _ClinicLocationScreenState extends State<ClinicLocationScreen> {
  final controller = TextEditingController();
  late final StreamSubscription<String> subscription;
  bool saving = false;
  bool loaded = false;
  String? error;
  @override
  void initState() {
    super.initState();
    subscription = getIt<AppointmentService>().watchClinicLocation().listen(
      (location) {
        if (!loaded && mounted) {
          setState(() {
            controller.text = location;
            loaded = true;
          });
        }
      },
      onError: (Object exception) {
        if (mounted) {
          setState(() {
            error = localizedError(exception);
          });
        }
      },
    );
  }

  @override
  void dispose() {
    subscription.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appStrings = context.t;
    return Scaffold(
      appBar: AppBar(title: Text(appStrings.mvp.clinicLocation)),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: controller,
              enabled: loaded && !saving,
              decoration: InputDecoration(
                labelText: appStrings.mvp.clinicField,
              ),
            ),
            Text(appStrings.commonUi.clinicInfo),
            if (error != null)
              Text(error!, style: const TextStyle(color: Colors.red)),
            FilledButton(
              onPressed: !loaded || saving
                  ? null
                  : () async {
                      if (controller.text.trim().isEmpty) {
                        setState(() {
                          error = appStrings.commonUi.enterClinicLocation;
                        });
                        return;
                      }
                      setState(() {
                        saving = true;
                        error = null;
                      });
                      try {
                        await getIt<AppointmentService>().saveClinicLocation(
                          controller.text,
                        );
                        if (context.mounted) Navigator.pop(context);
                      } catch (exception) {
                        if (mounted) {
                          setState(() {
                            saving = false;
                            error = localizedError(exception);
                          });
                        }
                      }
                    },
              child: Text(
                saving
                    ? appStrings.commonUi.saving
                    : appStrings.commonUi.saveChanges,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
