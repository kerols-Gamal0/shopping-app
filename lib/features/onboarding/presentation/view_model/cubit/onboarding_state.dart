part of 'onboarding_cubit.dart';

@immutable
sealed class OnboardingState {}

final class OnboardingInitial extends OnboardingState {}

final class OnboardingLoading extends OnboardingState {}

final class OnboardingLoaded extends OnboardingState {
  final List<OnboardingDto> onboardingList;
  OnboardingLoaded({required this.onboardingList});
}

final class OnboardingError extends OnboardingState {
  final String error;
  OnboardingError({required this.error});
}

final class OnboardingFinished extends OnboardingState {}
