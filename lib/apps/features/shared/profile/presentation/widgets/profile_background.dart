import 'package:flutter/material.dart';

class ProfileBackground extends StatelessWidget {
  const ProfileBackground({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFEAF8FF),
          Colors.white,
          Colors.white,
          Color(0xFFBCEBDD),
        ],
        stops: [0, .25, .65, 1],
      ),
    ),
    child: child,
  );
}
