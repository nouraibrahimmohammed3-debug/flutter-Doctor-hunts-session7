import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../router/app_router.dart';
import 'package:doctor_hunt/generated/strings.g.dart';

class DoctorHuntNavigationBar extends StatelessWidget {
  const DoctorHuntNavigationBar({
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.destinations,
    super.key,
  });
  factory DoctorHuntNavigationBar.patient({
    required BuildContext context,
    required int selectedIndex,
  }) {
    var appStrings = context.t;
    return DoctorHuntNavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: (index) => context.go(
        [
          AppRouter.home,
          AppRouter.findDoctors,
          AppRouter.appointments,
          AppRouter.profile,
        ][index],
      ),
      destinations: [
        NavigationDestination(
          icon: const Icon(Icons.home_outlined),
          label: appStrings.home,
        ),
        NavigationDestination(
          icon: const Icon(Icons.medical_services_outlined),
          label: appStrings.doctor,
        ),
        NavigationDestination(
          icon: Icon(Icons.calendar_month_outlined),
          label: appStrings.mvp.appointments,
        ),
        NavigationDestination(
          icon: const Icon(Icons.person_outline),
          label: appStrings.profile,
        ),
      ],
    );
  }
  factory DoctorHuntNavigationBar.admin({
    required BuildContext context,
    required int selectedIndex,
  }) {
    var appStrings = context.t;
    return DoctorHuntNavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: (index) => context.go(
        [
          AppRouter.adminDoctor,
          AppRouter.adminAppointments,
          AppRouter.adminSettings,
        ][index],
      ),
      destinations: [
        NavigationDestination(
          icon: const Icon(Icons.medical_services_outlined),
          label: appStrings.doctor,
        ),
        NavigationDestination(
          icon: Icon(Icons.calendar_month_outlined),
          label: appStrings.mvp.appointments,
        ),
        NavigationDestination(
          icon: const Icon(Icons.settings_outlined),
          label: appStrings.preferences.title,
        ),
      ],
    );
  }
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final List<Widget> destinations;
  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
    child: NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      destinations: destinations,
    ),
  );
}
