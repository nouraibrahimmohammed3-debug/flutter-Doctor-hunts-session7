import 'package:doctor_hunt/generated/assets.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';

class DoctorHuntLogo extends StatelessWidget {
  final String? appStrings;

  const DoctorHuntLogo({super.key, this.appStrings});
  @override
  Widget build(BuildContext context) {
    var appStrings = context.t;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          AppAssets.imagesLogoPng,
          width: 70,
          height: 70,
          fit: BoxFit.contain,
        ),
        const Gap(10),
        Text(
          this.appStrings ?? appStrings.appName,
          style: context.bold24TextMain,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
