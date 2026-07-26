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
import '../../features/hello/data/repos/hello_data_source_imp.dart' as _i474;
import '../../features/hello/data/repos/hello_repo_imp.dart' as _i138;
import '../../features/hello/domain/repo/hello_data_source_interface.dart'
    as _i289;
import '../../features/hello/domain/repo/hello_repo_interface.dart' as _i907;
import '../../features/hello/domain/usecases/has_visited_hello_use_case.dart'
    as _i603;
import '../../features/hello/domain/usecases/mark_hello_as_visited_use_case.dart'
    as _i189;
import '../../features/hello/presentation/view_model/hello_cubit.dart' as _i380;
import '../../features/onboarding/data/data_source/onboarding_data_source_imp.dart'
    as _i180;
import '../../features/onboarding/data/data_source/onboarding_data_source_interface.dart'
    as _i4;
import '../../features/onboarding/data/repo/onboarding_repo_imp.dart' as _i371;
import '../../features/onboarding/domain/repo/onboarding_repo_interface.dart'
    as _i398;
import '../../features/onboarding/domain/use_case/is_onboarding_seen_usecase.dart'
    as _i608;
import '../../features/onboarding/domain/use_case/save_onboarding_seen_usecase.dart'
    as _i848;
import '../../features/onboarding/presentation/view_model/cubit/onboarding_cubit.dart'
    as _i917;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i437.AppSectionCubit>(() => _i437.AppSectionCubit());
    gh.factory<_i289.HelloDataSourceInterface>(
      () => _i474.HelloDataSourceImp(),
    );
    gh.factory<_i907.HelloRepoInterface>(
      () => _i138.HelloRepoImp(gh<_i289.HelloDataSourceInterface>()),
    );
    gh.factory<_i4.OnboardingDataSourceInterface>(
      () => _i180.OnboardingDataSourceImp(),
    );
    gh.factory<_i398.OnboardingRepoInterface>(
      () => _i371.OnboardingRepoImp(
        onboardingDataSourceInterface: gh<_i4.OnboardingDataSourceInterface>(),
      ),
    );
    gh.factory<_i603.HasVisitedHelloUseCase>(
      () => _i603.HasVisitedHelloUseCase(gh<_i907.HelloRepoInterface>()),
    );
    gh.factory<_i189.MarkHelloAsVisitedUseCase>(
      () => _i189.MarkHelloAsVisitedUseCase(gh<_i907.HelloRepoInterface>()),
    );
    gh.factory<_i380.HelloCubit>(
      () => _i380.HelloCubit(
        gh<_i603.HasVisitedHelloUseCase>(),
        gh<_i189.MarkHelloAsVisitedUseCase>(),
      ),
    );
    gh.factory<_i608.IsOnboardingSeenUseCase>(
      () => _i608.IsOnboardingSeenUseCase(gh<_i398.OnboardingRepoInterface>()),
    );
    gh.factory<_i848.SaveOnboardingSeenUseCase>(
      () =>
          _i848.SaveOnboardingSeenUseCase(gh<_i398.OnboardingRepoInterface>()),
    );
    gh.factory<_i917.OnboardingCubit>(
      () => _i917.OnboardingCubit(
        gh<_i848.SaveOnboardingSeenUseCase>(),
        gh<_i608.IsOnboardingSeenUseCase>(),
      ),
    );
    return this;
  }
}
