import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:doctor_hunt/apps/core/di/injection_container.dart';
import 'package:doctor_hunt/apps/core/router/app_router.dart';
import 'package:go_router/go_router.dart';
import 'package:doctor_hunt/apps/features/shared/auth/domain/entities/user_role.dart';
import 'package:doctor_hunt/apps/features/shared/auth/presentation/bloc/sign_in/auth_bloc.dart';
import 'package:doctor_hunt/apps/features/shared/profile/data/profile_service.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import '../cubit/profile_cubit.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key, this.pickPhotoOnOpen = false});
  final bool pickPhotoOnOpen;
  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => ProfileCubit(
      getIt<ProfileService>(),
      context.read<AuthBloc>().state.user!,
    ),
    child: _EditProfileForm(pickPhotoOnOpen: pickPhotoOnOpen),
  );
}

class _EditProfileForm extends StatefulWidget {
  const _EditProfileForm({required this.pickPhotoOnOpen});
  final bool pickPhotoOnOpen;
  @override
  State<_EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<_EditProfileForm> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController phone;
  DateTime? birthDate;
  late String gender;
  @override
  void initState() {
    super.initState();
    final user = context.read<ProfileCubit>().user;
    name = TextEditingController(text: user.name);
    email = TextEditingController(text: user.email);
    phone = TextEditingController(text: user.phone);
    birthDate = user.dateOfBirth;
    gender = user.gender;
    if (widget.pickPhotoOnOpen) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) context.read<ProfileCubit>().pickPhoto();
      });
    }
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appStrings = context.t;
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state.saved) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(appStrings.profileForm.saved)));
        }
      },
      builder: (context, state) => PopScope(
        canPop: !state.busy,
        child: Scaffold(
          appBar: AppBar(
            title: Text(appStrings.profileForm.edit),
            centerTitle: true,
            automaticallyImplyLeading: !state.busy,
          ),
          body: Form(
            key: formKey,
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                Center(
                  child: TextButton(
                    onPressed: state.busy
                        ? null
                        : context.read<ProfileCubit>().pickPhoto,
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 48,
                          backgroundImage: state.photoUrl.isEmpty
                              ? null
                              : NetworkImage(state.photoUrl),
                          child: state.photoUrl.isEmpty
                              ? const Icon(Icons.person, size: 48)
                              : null,
                        ),
                        const SizedBox(height: 8),
                        Text(appStrings.profileForm.photo),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                if (context.read<AuthBloc>().state.activeRole == UserRole.admin)
                  ListTile(
                    title: Text(appStrings.location),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: state.busy
                        ? null
                        : () => context.push(AppRouter.clinicLocation),
                  ),
                TextFormField(
                  controller: name,
                  enabled: !state.busy,
                  decoration: InputDecoration(
                    labelText: appStrings.profileForm.name,
                  ),
                  validator: (value) => value?.trim().isEmpty != false
                      ? appStrings.requiredField
                      : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: email,
                  readOnly: true,
                  enableInteractiveSelection: true,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: appStrings.profileForm.email,
                    suffixIcon: const Icon(Icons.lock_outline),
                    helperText: appStrings.commonUi.emailReadOnly,
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: phone,
                  enabled: !state.busy,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: appStrings.profileForm.phone,
                  ),
                ),
                const SizedBox(height: 16),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(appStrings.profileForm.birthDate),
                  subtitle: Text(
                    birthDate == null
                        ? '-'
                        : DateFormat.yMMMd(
                            LocaleSettings.currentLocale.languageCode,
                          ).format(birthDate!),
                  ),
                  trailing: const Icon(Icons.calendar_month),
                  onTap: state.busy
                      ? null
                      : () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: birthDate ?? DateTime(2000),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (date != null && mounted) {
                            setState(() {
                              birthDate = date;
                            });
                          }
                        },
                ),
                DropdownButtonFormField<String>(
                  initialValue: ['', 'male', 'female', 'other'].contains(gender)
                      ? gender
                      : '',
                  decoration: InputDecoration(
                    labelText: appStrings.profileForm.gender,
                  ),
                  items: [
                    DropdownMenuItem(value: '', child: const Text('-')),
                    DropdownMenuItem(
                      value: 'male',
                      child: Text(appStrings.profileForm.male),
                    ),
                    DropdownMenuItem(
                      value: 'female',
                      child: Text(appStrings.profileForm.female),
                    ),
                    DropdownMenuItem(
                      value: 'other',
                      child: Text(appStrings.profileForm.other),
                    ),
                  ],
                  onChanged: state.busy
                      ? null
                      : (value) => setState(() {
                          gender = value ?? '';
                        }),
                ),
                if (state.error != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      state.error!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: state.busy
                      ? null
                      : () {
                          if (formKey.currentState!.validate()) {
                            context.read<ProfileCubit>().save(
                              name: name.text,
                              phone: phone.text,
                              birthDate: birthDate,
                              gender: gender,
                            );
                          }
                        },
                  child: state.busy
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(appStrings.profileForm.save),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
