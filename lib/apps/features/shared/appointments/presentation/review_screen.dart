import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_hunt/apps/core/di/injection_container.dart';
import 'package:doctor_hunt/apps/features/shared/auth/presentation/bloc/sign_in/auth_bloc.dart';
import '../data/appointment_service.dart';
import 'review_cubit.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({required this.appointment, super.key});
  final Appointment appointment;
  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => ReviewCubit(getIt<AppointmentService>()),
    child: _ReviewForm(appointment: appointment),
  );
}

class _ReviewForm extends StatefulWidget {
  const _ReviewForm({required this.appointment});
  final Appointment appointment;
  @override
  State<_ReviewForm> createState() => _ReviewFormState();
}

class _ReviewFormState extends State<_ReviewForm> {
  final comment = TextEditingController();
  int rating = 0;
  @override
  void dispose() {
    comment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appStrings = context.t;
    return BlocConsumer<ReviewCubit, ReviewState>(
      listener: (context, state) {
        if (state.saved) Navigator.pop(context, true);
      },
      builder: (context, state) => PopScope(
        canPop: !state.saving,
        child: Scaffold(
          appBar: AppBar(
            title: Text(appStrings.mvp.rateDoctor),
            automaticallyImplyLeading: !state.saving,
          ),
          body: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Text(
                widget.appointment.doctorName,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 12),
              Text(appStrings.mvp.howWas),
              const SizedBox(height: 12),
              Wrap(
                children: [
                  for (var star = 1; star <= 5; star++)
                    IconButton(
                      tooltip: appStrings.commonUi.starCount(count: star),
                      onPressed: state.saving
                          ? null
                          : () => setState(() {
                              rating = star;
                            }),
                      icon: Icon(
                        star <= rating ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                        size: 36,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: comment,
                enabled: !state.saving,
                maxLength: 1000,
                minLines: 3,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: appStrings.mvp.optionalReview,
                  border: OutlineInputBorder(),
                ),
              ),
              if (state.error != null)
                Text(
                  state.error!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              const SizedBox(height: 16),
              Text(appStrings.mvp.oneReview),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: state.saving || rating == 0
                    ? null
                    : () {
                        final user = context.read<AuthBloc>().state.user;
                        if (user != null) {
                          context.read<ReviewCubit>().submit(
                            appointment: widget.appointment,
                            patientId: user.uid,
                            rating: rating,
                            comment: comment.text,
                          );
                        }
                      },
                child: state.saving
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(appStrings.mvp.submitReview),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
