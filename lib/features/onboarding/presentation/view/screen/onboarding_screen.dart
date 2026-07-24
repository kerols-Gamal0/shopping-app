import 'package:flutter/material.dart';
import 'package:shopping_app/core/common/widgets/app_btns.dart';
import 'package:shopping_app/core/constants/app_onboarding_image.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_theme.dart';
import 'package:shopping_app/features/onboarding/model/onboarding_model.dart';
import 'package:shopping_app/features/onboarding/repo/repo/onboarding_repo_interface.dart';
import 'package:shopping_app/test_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pagecontroller = PageController();
  final OnboardingRepoInterface onboardingRepo = serviceLocator<OnboardingRepoInterface>();
  int indx = 0;
  List<OnboardingDataModel> onboardingList = getOnboardingList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Align(
              alignment: .centerRight,
              child: TextButton(
                onPressed: () async {
                  await onboardingRepo.saveOnboardingSeen();
                  if (!mounted) return;
                  Navigator.pushNamed(context, TestScreen.routeName);
                },
                child: Text('Skip', style: AppTheme.lightTheme.textTheme.bodyMedium),
              ),
            ),

            Expanded(
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    indx = value;
                  });
                },
                controller: _pagecontroller,
                itemCount: onboardingList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSpacing.x3, vertical: AppSpacing.x2),
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(16),
                      child: Image.asset(onboardingList[index].image, fit: BoxFit.cover),
                    ),
                  );
                },
              ),
            ),
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
            SizedBox(height: 40),
            Text(onboardingList[indx].title, style: AppTheme.lightTheme.textTheme.headlineLarge),
            Container(
              margin: EdgeInsets.symmetric(horizontal: AppSpacing.x2),
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.x4),
              child: Text(
                onboardingList[indx].description,
                style: AppTheme.lightTheme.textTheme.labelSmall,
                textAlign: .center,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24.0),
              child: PrimaryBtn(
                onPressed: () async {
                  if (indx < onboardingList.length - 1) {
                    _pagecontroller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                  } else {
                    await onboardingRepo.saveOnboardingSeen();

                    if (!mounted) return;

                    // Navigate to Login/Home
                    Navigator.pushNamed(context, TestScreen.routeName);
                  }
                },
                child: indx < onboardingList.length - 1 ? Text('Next') : Text('Get Started'),
              ),
            ),
            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pagecontroller.dispose();
    super.dispose();
  }
}

List<OnboardingDataModel> getOnboardingList() {
  return [
    OnboardingDataModel(
      image: AppOnboardingImage.onBoarding1,
      title: "Discover Trends",
      description: "Now we are here to provide variety of the best fashion",
    ),
    OnboardingDataModel(
      image: AppOnboardingImage.onBoarding2,
      title: "Latest out fit",
      description: "Express your self through the art of the fashionism",
    ),
  ];
}
