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
          appStrings ?? context.t.appName,
          style: context.bold24TextMain,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// import '../../../../../generated/app_colors.dart';

// class DoctorHuntLogo extends StatelessWidget {
//   const DoctorHuntLogo({this.compact = false, super.key});
//   final bool compact;

//   @override
//   Widget build(BuildContext context) {
//     final size = compact ? 36.0 : 56.0;
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           width: size,
//           height: size,
//           decoration: BoxDecoration(
//             border: Border.all(color: AppColors.primary, width: compact ? 3 : 4),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Icon(Icons.add_rounded, color: AppColors.primary, size: size * .72),
//         ),
//         const SizedBox(height: 10),
//         Text('Doctor Hunt', style: TextStyle(fontSize: compact ? 16 : 21, fontWeight: FontWeight.w700)),
//       ],
//     );
//   }
// }
