import 'package:doctor_hunt/apps/core/di/injection_container.dart';
import 'package:doctor_hunt/apps/core/router/app_router.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/doctor_model.dart';
import '../cubit/doctor_load_cubit.dart';

class DoctorRouteScreen extends StatelessWidget {
  const DoctorRouteScreen({
    super.key,
    required this.doctorId,
    required this.title,
    required this.builder,
    this.initialDoctor,
  });
  final String doctorId;
  final String title;
  final DoctorModel? initialDoctor;
  final Widget Function(DoctorModel doctor) builder;

  @override
  Widget build(BuildContext context) {
    var appStrings = context.t;
    return BlocProvider(
      key: ValueKey(doctorId),
      create: (_) =>
          getIt<DoctorLoadCubit>(param1: doctorId, param2: initialDoctor)
            ..load(),
      child: BlocBuilder<DoctorLoadCubit, DoctorLoadState>(
        builder: (context, state) {
          if (state.doctor case final DoctorModel doctor) {
            return builder(doctor);
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(title),
              leading: BackButton(
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.go(AppRouter.home);
                  }
                },
              ),
            ),
            body: state.loading
                ? const Center(child: CircularProgressIndicator())
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            state.error ?? appStrings.doctors.notFound,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          FilledButton(
                            onPressed: context.read<DoctorLoadCubit>().load,
                            child: Text(appStrings.retry),
                          ),
                        ],
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
