import 'package:shopping_app/features/onboarding/model/onboarding_dto.dart';

abstract interface class OnboardingDataSourceInterface {
  List<OnboardingDto> getOnboardingList();
  // Future<void> saveFirstTime();
  // Future<bool> isFirstTime();
}
