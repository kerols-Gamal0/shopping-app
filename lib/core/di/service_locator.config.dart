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
    gh.factory<_i65.OnboardingDataSourceInterface>(
      () => _i260.OnboardingDataSourceImp(),
    );
    gh.factory<_i688.OnboardingRepoInterface>(
      () => _i480.OnboardingRepoImp(
        onboardingDataSourceInterface: gh<_i65.OnboardingDataSourceInterface>(),
      ),
    );
    gh.factory<_i289.HelloDataSourceInterface>(
      () => _i474.HelloDataSourceImp(),
    );
    gh.factory<_i907.HelloRepoInterface>(
      () => _i138.HelloRepoImp(gh<_i289.HelloDataSourceInterface>()),
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
    return this;
  }
}
