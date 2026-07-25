// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/onboarding/data/data_source/onboarding_data_source_imp.dart'
    as _i180;
import '../../features/onboarding/data/data_source/onboarding_data_source_interface.dart'
    as _i4;
import '../../features/onboarding/data/repo/onboarding_repo_imp.dart' as _i371;
import '../../features/onboarding/domain/repo/onboarding_repo_interface.dart'
    as _i398;
import '../../features/onboarding/domain/use_case/save_onboarding_seen_usecase.dart'
    as _i848;
import '../../features/onboarding/presentation/view_model/cubit/onboarding_cubit.dart'
    as _i917;
import '../../features/app_section/view_model/app_section_cubit.dart' as _i437;
import '../../features/onboarding/repo/data_source/onboarding_data_source_imp.dart'
    as _i260;
import '../../features/onboarding/repo/data_source/onboarding_data_source_interface.dart'
    as _i65;
import '../../features/onboarding/repo/repo/onboarding_repo_imp.dart' as _i480;
import '../../features/onboarding/repo/repo/onboarding_repo_interface.dart'
    as _i688;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i4.OnboardingDataSourceInterface>(
      () => _i180.OnboardingDataSourceImp(),
    gh.lazySingleton<_i437.AppSectionCubit>(() => _i437.AppSectionCubit());
    gh.factory<_i827.SharedPref>(() => _i827.SharedPref());
    gh.factory<_i65.OnboardingDataSourceInterface>(
      () => _i260.OnboardingDataSourceImp(),
    );
    gh.factory<_i917.OnboardingCubit>(
      () => _i917.OnboardingCubit(gh<_i848.SaveOnboardingSeenUseCase>()),
    );
    gh.factory<_i398.OnboardingRepoInterface>(
      () => _i371.OnboardingRepoImp(
        onboardingDataSourceInterface: gh<_i4.OnboardingDataSourceInterface>(),
      ),
    );
    return this;
  }
}
