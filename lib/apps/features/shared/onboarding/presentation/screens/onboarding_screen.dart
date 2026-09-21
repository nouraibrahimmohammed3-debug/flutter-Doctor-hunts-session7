import 'package:doctor_hunt/apps/core/router/app_router.dart';
import 'package:doctor_hunt/apps/core/widgets/primary_button.dart';
import 'package:doctor_hunt/apps/features/shared/onboarding/data/services/onboarding_service.dart';
import 'package:doctor_hunt/apps/features/shared/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:doctor_hunt/apps/features/shared/onboarding/presentation/cubit/onboarding_state.dart';
import 'package:doctor_hunt/apps/features/shared/onboarding/presentation/widgets/onboarding_item.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appStrings = t;
    return BlocProvider(
      create: (context) => OnboardingCubit(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: OnboardingService.pages.length,
                      onPageChanged: (pageIndex) {
                        context.read<OnboardingCubit>().changePage(pageIndex);
                      },
                      itemBuilder: (context, index) {
                        return OnboardingItem(
                          item: OnboardingService.pages[index],
                        );
                      },
                    ),
                  ),
                  BlocBuilder<OnboardingCubit, OnboardingState>(
                    builder: (context, state) {
                      final bool isLastPage =
                          state.currentPage ==
                          OnboardingService.pages.length - 1;

                      return Padding(
                        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                OnboardingService.pages.length,
                                (index) {
                                  final bool isSelected =
                                      index == state.currentPage;

                                  return Container(
                                    width: isSelected ? 24 : 8,
                                    height: 8,
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? Theme.of(
                                              context,
                                            ).colorScheme.primary
                                          : Theme.of(
                                              context,
                                            ).colorScheme.outlineVariant,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 24),
                            PrimaryButton(
                              label: isLastPage
                                  ? appStrings.getStarted
                                  : appStrings.next,
                              onPressed: () {
                                if (isLastPage) {
                                  context.go(AppRouter.login);
                                  return;
                                }

                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                            ),
                            if (!isLastPage) ...[
                              const SizedBox(height: 8),
                              TextButton(
                                onPressed: () {
                                  context.go(AppRouter.login);
                                },
                                child: Text(
                                  appStrings.skip,
                                  style: context.regular14TextSub,
                                ),
                              ),
                            ],
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
