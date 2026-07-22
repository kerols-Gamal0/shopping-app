import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopping_app/features/onboarding/model/onboarding_dto.dart';

import 'package:shopping_app/features/onboarding/repo/repo/onboarding_repo_interface.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit(this._onboardingRepoImp) : super(OnboardingInitial());
  final OnboardingRepoInterface _onboardingRepoImp;
  // void processIntent(IntentOnboarding intent) {

  //     // case FetchOnboardingList():
  //       _fetchOnboardingList();
  // }
  // break;
  //   case SkipOnboarding():
  //     _skipOnboarding();
  //     break;
  // }

  void fetchOnboardingList() {
    try {
      final onboardingList = _onboardingRepoImp.getOnboardingList();
      emit(OnboardingLoaded(onboardingList: onboardingList));
    } catch (e) {
      emit(OnboardingError(error: e.toString()));
    }
  }
}

//   void _skipOnboarding() {
//     emit(OnboardingLoading());
//     try {
//       _onboardingRepoImp.saveFirstTime();
//       emit(OnboardingFinished());
//     } catch (e) {
//       emit(OnboardingError(error: e.toString()));
//     }
//   }
// }

sealed class IntentOnboarding {}

class FetchOnboardingList extends IntentOnboarding {}

// class SkipOnboarding extends IntentOnboarding {}
