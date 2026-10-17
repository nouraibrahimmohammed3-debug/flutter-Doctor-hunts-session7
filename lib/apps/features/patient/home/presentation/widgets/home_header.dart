import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_hunt/apps/features/shared/auth/presentation/bloc/sign_in/auth_bloc.dart';
import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.onSearchTap,
    required this.onMenuTap,
  });
  final VoidCallback onSearchTap;
  final VoidCallback onMenuTap;

  @override
  Widget build(BuildContext context) {
    var appStrings = context.t;

    final userName = context.select(
      (AuthBloc bloc) => bloc.state.user?.name.trim() ?? '',
    );
    final photoUrl = context.select(
      (AuthBloc bloc) => bloc.state.user?.photoUrl ?? '',
    );
    return Stack(
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 40),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appStrings.homeGreeting(name: userName),
                            style: context.regular12White,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            appStrings.findYourDoctor,
                            style: context.bold20White,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      tooltip: appStrings.menu,
                      onPressed: onMenuTap,
                      icon: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        foregroundImage: photoUrl.isEmpty
                            ? null
                            : NetworkImage(photoUrl),
                        child: const Icon(
                          Icons.person_outline,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
        Positioned(
          left: 12,
          right: 12,
          bottom: 0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0C000000),
                  blurRadius: 16,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: TextField(
              readOnly: true,
              onTap: onSearchTap,
              decoration: InputDecoration(
                hintText: appStrings.searchDoctor,
                prefixIcon: const Icon(Icons.search, size: 20),
                suffixIcon: const Icon(Icons.close, size: 18),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
