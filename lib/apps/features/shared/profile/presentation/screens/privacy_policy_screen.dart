import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:flutter/material.dart';
import '../widgets/profile_background.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var appStrings = context.t;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFEAF8FF),
        title: Text(appStrings.privacyPolicy.title),
      ),
      body: ProfileBackground(
        child: SizedBox.expand(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appStrings.privacyPolicy.heading,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textSub,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  appStrings.privacyPolicy.draftNotice,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textMain,
                  ),
                ),
                const SizedBox(height: 16),
                _PolicyParagraph(text: appStrings.privacyPolicy.introduction),
                for (final text in [
                  appStrings.privacyPolicy.bulletOne,
                  appStrings.privacyPolicy.bulletTwo,
                  appStrings.privacyPolicy.bulletThree,
                  appStrings.privacyPolicy.bulletFour,
                ])
                  Padding(
                    padding: const EdgeInsets.only(top: 18),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 7),
                          child: Icon(
                            Icons.circle,
                            size: 6,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(child: _PolicyParagraph(text: text)),
                      ],
                    ),
                  ),
                const SizedBox(height: 20),
                _PolicyParagraph(text: appStrings.privacyPolicy.conclusion),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PolicyParagraph extends StatelessWidget {
  const _PolicyParagraph({required this.text});
  final String text;
  @override
  Widget build(BuildContext context) => Text(
    text,
    style: const TextStyle(
      color: AppColors.textSub,
      fontSize: 14,
      height: 1.65,
    ),
  );
}
