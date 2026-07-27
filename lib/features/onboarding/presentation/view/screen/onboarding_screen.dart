import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/common/widgets/app_btns.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/core/routing/app_routes.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_theme.dart';
import 'package:shopping_app/features/onboarding/data/model/onboarding_data.dart';
import 'package:shopping_app/features/onboarding/presentation/view_model/cubit/onboarding_cubit.dart';
import 'package:shopping_app/features/onboarding/presentation/view_model/cubit/onboarding_state.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          serviceLocator<
            OnboardingCubit
          >(), // TODO: HERE -> at routes+ bloc.value
      child: Builder(
        builder: (context) {
          return BlocListener<OnboardingCubit, OnboardingState>(
            listener: (context, state) {
              if (state is OnboardingCompleted) {
                Navigator.pushReplacementNamed(context, AppRoutes.helloRoute);
              }
            },
            child: Scaffold(
              body: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          context.read<OnboardingCubit>().intent(
                            IntentFinishOnboarding(),
                          );
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.helloRoute,
                          );
                        },
                        child: Text(
                          'Skip',
                          style: AppTheme.lightTheme.textTheme.bodyMedium,
                        ),
                      ),
                    ),

                    Expanded(
                      child: PageView.builder(
                        onPageChanged: (value) {
                          context.read<OnboardingCubit>().intent(
                            IntentOnboardingPageChanged(value),
                          );
                        },

                        controller: _pageController,
                        itemCount: onboardingList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSpacing.x3,
                              vertical: AppSpacing.x2,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                onboardingList[index].image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    BlocBuilder<OnboardingCubit, OnboardingState>(
                      builder: (context, state) {
                        final cubit = context.read<OnboardingCubit>();
                        final currentIndex = state is OnboardingPageChanged
                            ? state.index
                            : cubit.currentIndex;

                        return Column(
                          children: [
                            SmoothPageIndicator(
                              controller: _pageController,
                              count: onboardingList.length,
                              effect: SwapEffect(
                                dotWidth: 10,
                                dotHeight: 10,
                                activeDotColor: AppColors.body,
                                dotColor: AppColors.dotColor,
                              ),
                            ),
                            SizedBox(height: 40),
                            Text(
                              onboardingList[currentIndex].title,
                              style:
                                  AppTheme.lightTheme.textTheme.headlineLarge,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: AppSpacing.x2,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: AppSpacing.x4,
                              ),
                              child: Text(
                                onboardingList[currentIndex].description,
                                style: AppTheme.lightTheme.textTheme.labelSmall,
                                textAlign: TextAlign.center,
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(24),
                              child: PrimaryBtn(
                                onPressed: () {
                                  final isLastPage =
                                      currentIndex == onboardingList.length - 1;
                                  final cubit = context.read<OnboardingCubit>();
                                  if (isLastPage) {
                                    cubit.intent(IntentFinishOnboarding());
                                    Navigator.pushReplacementNamed(
                                      context,
                                      AppRoutes.helloRoute,
                                    );
                                    return;
                                  }

                                  _pageController.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                  );

                                  cubit.intent(
                                    IntentOnboardingPageChanged(
                                      currentIndex + 1,
                                    ),
                                  );
                                },
                                child: Text(
                                  currentIndex == onboardingList.length - 1
                                      ? 'Get Started'
                                      : 'Next',
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
