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
    gh.lazySingleton<_i437.AppSectionCubit>(() => _i437.AppSectionCubit());
    gh.factory<_i65.OnboardingDataSourceInterface>(
      () => _i260.OnboardingDataSourceImp(),
    );
    gh.factory<_i688.OnboardingRepoInterface>(
      () => _i480.OnboardingRepoImp(
        onboardingDataSourceInterface: gh<_i65.OnboardingDataSourceInterface>(),
      ),
    );
    return this;
  }
}
