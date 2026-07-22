import 'package:shopping_app/features/onboarding/model/onboarding_dto.dart';
import 'package:shopping_app/features/onboarding/repo/data_source/onboarding_data_source_interface.dart';
import 'package:shopping_app/features/onboarding/repo/repo/onboarding_repo_interface.dart';

class OnboardingRepoImp implements OnboardingRepoInterface {
  final OnboardingDataSourceInterface onboardingDataSourceInterface;
  OnboardingRepoImp({required this.onboardingDataSourceInterface});
  @override
  List<OnboardingDto> getOnboardingList() {
    return onboardingDataSourceInterface.getOnboardingList();
  }

  //   @override
  //   Future<void> saveFirstTime() {
  //  return onboardingDataSourceInterface.saveFirstTime();
  //   }

  //   @override
  //   Future<bool> isFirstTime() {
  //     return onboardingDataSourceInterface.isFirstTime();
  //   }
}
