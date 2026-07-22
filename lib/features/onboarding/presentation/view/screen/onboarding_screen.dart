import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/common/widgets/app_btns.dart';
import 'package:shopping_app/core/constants/app_onboarding_image.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_theme.dart';
import 'package:shopping_app/features/onboarding/model/onboarding_dto.dart';
import 'package:shopping_app/features/onboarding/presentation/view_model/cubit/onboarding_cubit.dart';
import 'package:shopping_app/features/onboarding/repo/data_source/onboarding_local_data_source.dart';
import 'package:shopping_app/features/onboarding/repo/repo/onboarding_repo_imp.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PageController _pagecontroller = PageController();
    return BlocProvider(
      create: (context) => OnboardingCubit(
        OnboardingRepoImp(
          onboardingDataSourceInterface: OnboardingLocalDataSourceImpl(),
        ),
      )..fetchOnboardingList(),
      child: Scaffold(
        body: BlocBuilder<OnboardingCubit, OnboardingState>(
          builder: (context, state) {
            List<OnboardingDto> onboardingList = [];
            if (state is OnboardingLoaded) {
              onboardingList = state.onboardingList;
            }
            return SafeArea(
              child: Column(
                mainAxisAlignment: .center,
                children: [
                  Align(
                    alignment: .centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Skip',
                        style: AppTheme.lightTheme.textTheme.bodyMedium,
                      ),
                    ),
                  ),

                  Expanded(
                    child: PageView.builder(
                      onPageChanged: (value) {},
                      controller: _pagecontroller,
                      itemCount: onboardingList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(AppSpacing.x3),
                          child: Column(
                            mainAxisAlignment: .start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadiusGeometry.circular(16),
                                child: Image.asset(onboardingList[index].image),
                              ),
                              SizedBox(height: 10),
                              SmoothPageIndicator(
                                controller: _pagecontroller,
                                count: onboardingList.length,
                                effect: SwapEffect(
                                  dotWidth: 10,
                                  dotHeight: 10,
                                  activeDotColor: AppColors.body,
                                  dotColor: AppColors.dotColor,
                                ),
                              ),
                              SizedBox(height: 50),
                              Text(
                                onboardingList[index].title,
                                style:
                                    AppTheme.lightTheme.textTheme.headlineLarge,
                              ),
                              Text(
                                onboardingList[index].description,
                                style: AppTheme.lightTheme.textTheme.labelSmall,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: PrimaryBtn(
                      onPressed: () {
                        _pagecontroller.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.bounceIn,
                        );
                      },
                      child: Text('Next'),
                    ),
                  ),
                  SizedBox(height: 80),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
