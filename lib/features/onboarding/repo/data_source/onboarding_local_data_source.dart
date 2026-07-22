import 'package:shopping_app/core/constants/app_onboarding_image.dart';

import 'package:shopping_app/features/onboarding/repo/data_source/onboarding_data_source_interface.dart';
import 'package:shopping_app/features/onboarding/model/onboarding_dto.dart';

class OnboardingLocalDataSourceImpl implements OnboardingDataSourceInterface {
  // final SharedPref _sharedPref;
  // OnboardingLocalDataSourceImpl({required this._sharedPref});
  @override
  List<OnboardingDto> getOnboardingList() {
    return [
      OnboardingDto(
        image: AppOnboardingImage.onBoarding1,
        title: "Discover Trends",
        description: "Now we are here to provide variety of the best fashion",
      ),
      OnboardingDto(
        image: AppOnboardingImage.onBoarding2,
        title: "Latest out fit",
        description: "Express your self through the art of the fashionism",
      ),
    ];
  }

  //   @override
  //   Future<bool> isFirstTime() async{

  // return await _sharedPref.isFirstTime();
  //   }

  //   @override
  //   Future<void> saveFirstTime() {
  //    return  _sharedPref.saveFirstTime();
  //   }
}
