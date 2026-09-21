import 'package:flutter_bloc/flutter_bloc.dart';

import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(const OnboardingState(currentPage: 0));

  void changePage(int pageIndex) {
    if (pageIndex == state.currentPage) return;

    emit(OnboardingState(currentPage: pageIndex));
  }
}
