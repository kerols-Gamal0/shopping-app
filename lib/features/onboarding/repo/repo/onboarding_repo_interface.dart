import 'package:shopping_app/features/onboarding/model/onboarding_dto.dart';

abstract class OnboardingRepoInterface {
  List<OnboardingDto> getOnboardingList();
  //  Future<void> saveFirstTime();

  // Future<bool> isFirstTime();
}
