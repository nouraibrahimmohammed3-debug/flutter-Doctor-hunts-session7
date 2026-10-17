import 'package:doctor_hunt/apps/core/router/app_router.dart';
import 'package:doctor_hunt/apps/features/shared/auth/presentation/bloc/sign_in/auth_bloc.dart';
import 'package:doctor_hunt/apps/features/shared/profile/presentation/screens/settings_screen.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PatientHomeMenu extends StatefulWidget {
  const PatientHomeMenu({super.key, required this.builder});

  final Widget Function(BuildContext context, VoidCallback openMenu) builder;

  @override
  State<PatientHomeMenu> createState() => _PatientHomeMenuState();
}

class _PatientHomeMenuState extends State<PatientHomeMenu>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 280),
  );
  bool _open = false;

  void _toggle(bool open) {
    setState(() => _open = open);
    if (open) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  void _navigate(String path) {
    _toggle(false);
    if (path != AppRouter.home) context.push(path);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appStrings = context.t;
    final user = context.select((AuthBloc bloc) => bloc.state.user);
    final rtl = Directionality.of(context) == TextDirection.rtl;
    return PopScope(
      canPop: !_open,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && _open) _toggle(false);
      },
      child: Material(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            return Stack(
              fit: StackFit.expand,
              children: [
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF7183A5), Color(0xFF506083)],
                    ),
                  ),
                ),
                ExcludeSemantics(
                  excluding: !_open,
                  child: SafeArea(
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: SizedBox(
                        width: width * .72,
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                            20,
                            24,
                            12,
                            12,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () => _navigate(AppRouter.profile),
                                borderRadius: BorderRadius.circular(12),
                                child: Semantics(
                                  button: true,
                                  label: appStrings.profile,
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 22,
                                        backgroundColor: Colors.white24,
                                        foregroundImage:
                                            user?.photoUrl.isNotEmpty == true
                                            ? NetworkImage(user!.photoUrl)
                                            : null,
                                        child: const Icon(
                                          Icons.person,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              user?.name ?? '',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            if (user?.phone.isNotEmpty ==
                                                true) ...[
                                              const SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.phone,
                                                    size: 12,
                                                    color: Colors.white,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Expanded(
                                                    child: Text(
                                                      user!.phone,
                                                      textDirection:
                                                          TextDirection.ltr,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 48),
                              Expanded(
                                child: ListView(
                                  padding: EdgeInsets.zero,
                                  children: [
                                    _MenuItem(
                                      icon: Icons.person,
                                      label: appStrings.home,
                                      onTap: () => _navigate(AppRouter.home),
                                    ),
                                    _MenuItem(
                                      icon: Icons.favorite,
                                      label: appStrings.favorites,
                                      onTap: () =>
                                          _navigate(AppRouter.favorites),
                                    ),
                                    _MenuItem(
                                      icon: Icons.calendar_month,
                                      label: appStrings.myAppointments,
                                      onTap: () =>
                                          _navigate(AppRouter.appointments),
                                    ),
                                    _MenuItem(
                                      icon: Icons.settings,
                                      label: appStrings.preferences.title,
                                      onTap: () =>
                                          _navigate(AppRouter.settings),
                                    ),
                                  ],
                                ),
                              ),
                              _MenuItem(
                                icon: Icons.logout,
                                label: appStrings.preferences.logout,
                                showArrow: false,
                                onTap: () => confirmLogout(context),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                AnimatedBuilder(
                  animation: _controller,
                  child: widget.builder(context, () => _toggle(true)),
                  builder: (context, child) {
                    final progress = Curves.easeInOut.transform(
                      _controller.value,
                    );
                    return Transform.translate(
                      offset: Offset(
                        width * .76 * progress * (rtl ? -1 : 1),
                        0,
                      ),
                      child: Transform.scale(
                        scale: 1 - .30 * progress,
                        alignment: rtl
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(28 * progress),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              ExcludeSemantics(
                                excluding: _open,
                                child: IgnorePointer(
                                  ignoring: _open,
                                  child: child,
                                ),
                              ),
                              if (_open)
                                Semantics(
                                  button: true,
                                  label: appStrings.closeMenu,
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () => _toggle(false),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.showArrow = true,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool showArrow;

  @override
  Widget build(BuildContext context) => ListTile(
    contentPadding: EdgeInsets.zero,
    leading: Icon(icon, color: Colors.white, size: 22),
    title: Text(
      label,
      style: const TextStyle(color: Colors.white, fontSize: 16),
    ),
    trailing: showArrow
        ? const Icon(Icons.chevron_right, color: Colors.white, size: 20)
        : null,
    onTap: onTap,
  );
}
