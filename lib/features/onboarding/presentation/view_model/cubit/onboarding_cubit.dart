import 'package:bloc/bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/features/onboarding/domain/use_case/save_onboarding_seen_usecase.dart';
import 'package:shopping_app/features/onboarding/presentation/view_model/cubit/onboarding_state.dart';

@injectable
class OnboardingCubit extends Cubit<OnboardingState> {
  final SaveOnboardingSeenUseCase saveOnboardingSeenUseCase;

  OnboardingCubit(this.saveOnboardingSeenUseCase) : super(OnboardingInitial());

  int currentIndex = 0;

  void changePage(int index) {
    currentIndex = index;
    emit(OnboardingPageChanged(index));
  }

  void intent(OnboardingIntent intent) async {
    switch (intent) {
      case IntentOnboardingPageChanged():
        changePage(intent.index);
        break;
      case IntentFinishOnboarding():
        await finishOnboarding();
        break;
    }
  }

  Future<void> finishOnboarding() async {
    emit(OnboardingSaving());
    try {
      await saveOnboardingSeenUseCase.invoke();
      emit(OnboardingCompleted());
    } catch (e) {
      emit(OnboardingError(e.toString()));
    }
  }
}

sealed class OnboardingIntent {}

final class IntentOnboardingPageChanged extends OnboardingIntent {
  final int index;

  IntentOnboardingPageChanged(this.index);
}

final class IntentFinishOnboarding extends OnboardingIntent {}
