import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import 'package:doctor_hunt/apps/core/router/app_router.dart';
import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/apps/core/widgets/doctor_hunt_app_bar.dart';
import 'package:doctor_hunt/apps/features/admin/presentation/bloc/admin_doctors/admin_doctors_bloc.dart';
import 'package:doctor_hunt/apps/features/admin/presentation/bloc/admin_doctors/admin_doctors_event.dart';
import 'package:doctor_hunt/apps/features/admin/presentation/bloc/admin_doctors/admin_doctors_state.dart';
import 'package:doctor_hunt/apps/features/admin/presentation/widgets/admin_doctor_card.dart';
import 'package:doctor_hunt/apps/features/shared/doctors/data/models/doctor_model.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';

class AdminDoctorsScreen extends StatelessWidget {
  const AdminDoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminDoctorsBloc, AdminDoctorsState>(
      listenWhen: (previous, current) =>
          previous.successMessage != current.successMessage ||
          previous.errorMessage != current.errorMessage,
      listener: (context, state) {
        final message = state.successMessage ?? state.errorMessage;
        if (message != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
        }
      },
      child: Scaffold(
        appBar: DoctorHuntAppBar(
          title: t.doctors,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none)),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: BlocBuilder<AdminDoctorsBloc, AdminDoctorsState>(
              builder: (context, state) {
                final doctors = state.doctors;
                final activeCount = doctors.where((doctor) => doctor.isAvailable).length;
                return Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: t.searchDoctors,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: AppColors.alabaster),
                        ),
                      ),
                    ),
                    const Gap(12),
                    Row(
                      children: [
                        _CountCard(title: t.totalDoctors, value: doctors.length),
                        const Gap(14),
                        _CountCard(title: t.activeDoctors, value: activeCount),
                      ],
                    ),
                    const Gap(16),
                    Expanded(
                      child: state.status == AdminDoctorsStatus.loading && doctors.isEmpty
                          ? const Center(child: CircularProgressIndicator())
                          : state.status == AdminDoctorsStatus.failure && doctors.isEmpty
                              ? Center(child: Text(state.errorMessage ?? 'Failed to load doctors.'))
                              : ListView.separated(
                                  padding: const EdgeInsets.only(top: 12, bottom: 80),
                                  itemCount: doctors.length,
                                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                                  itemBuilder: (context, index) {
                                    final doctor = doctors[index];
                                    return _DoctorAdminTile(doctor: doctor);
                                  },
                                ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => context.push(AppRouter.createDoctor),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          icon: const Icon(Icons.add),
          label: Text(t.addDoctor),
        ),
      ),
    );
  }
}

class _CountCard extends StatelessWidget {
  const _CountCard({required this.title, required this.value});
  final String title;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 74,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.alabaster,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: context.regular14TextSub),
            const Gap(4),
            Text('$value', style: context.semiBold16TextMain),
          ],
        ),
      ),
    );
  }
}

class _DoctorAdminTile extends StatelessWidget {
  const _DoctorAdminTile({required this.doctor});
  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AdminDoctorsBloc>().state;
    final processing = state.processingDoctorId == doctor.id;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.alabaster),
      ),
      child: AdminDoctorCard(
        imagePath: doctor.imagePath,
        name: doctor.name,
        specialization: doctor.specialization,
        isAvailable: doctor.isAvailable,
        isProcessing: processing,
        onMorePressed: processing ? null : () => _showActions(context, doctor),
      ),
    );
  }

  void _showActions(BuildContext context, DoctorModel doctor) {
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit_outlined),
              title: Text(t.editDoctor),
              onTap: () {
                sheetContext.pop();
                context.push(AppRouter.createDoctor, extra: doctor);
              },
            ),
            ListTile(
              leading: Icon(doctor.isAvailable ? Icons.visibility_off : Icons.visibility),
              title: Text(doctor.isAvailable ? 'Disable availability' : 'Enable availability'),
              onTap: () {
                sheetContext.pop();
                context.read<AdminDoctorsBloc>().add(
                      AdminDoctorAvailabilityChanged(doctor.id, !doctor.isAvailable),
                    );
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline),
              title: const Text('Delete doctor'),
              onTap: () {
                sheetContext.pop();
                _confirmDelete(context, doctor);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, DoctorModel doctor) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete doctor?'),
        content: Text('Are you sure you want to delete ${doctor.name}?'),
        actions: [
          TextButton(onPressed: () => dialogContext.pop(false), child: const Text('Cancel')),
          FilledButton(onPressed: () => dialogContext.pop(true), child: const Text('Delete')),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      context.read<AdminDoctorsBloc>().add(AdminDoctorDeleted(doctor.id));
    }
  }
}
