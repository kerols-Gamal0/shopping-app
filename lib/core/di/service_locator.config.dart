// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/account/data/repo/account_data_source_imp.dart' as _i831;
import '../../features/account/data/repo/account_repo_imp.dart' as _i781;
import '../../features/account/domain/repo/account_repo_interface.dart'
    as _i684;
import '../../features/account/domain/use_cases/edit_user_data_usecase.dart'
    as _i588;
import '../../features/account/domain/use_cases/get_user_data_usecase.dart'
    as _i140;
import '../../features/account/presentation/view_model/account_cubit.dart'
    as _i802;
import '../../features/app_section/view_model/app_section_cubit.dart' as _i437;
import '../../features/category/data/repo/category_data_source_imp.dart'
    as _i758;
import '../../features/category/data/repo/category_repo_imp.dart' as _i610;
import '../../features/category/domain/repo/category_data_source_interface.dart'
    as _i575;
import '../../features/category/domain/repo/category_repo_interface.dart'
    as _i889;
import '../../features/category/domain/usecase/get_category_products_use_case.dart'
    as _i1029;
import '../../features/category/presentation/view_model/category_cubit/category_cubit.dart'
    as _i662;
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
import '../../features/home/data/repo/home_data_source_remote_impl.dart'
    as _i576;
import '../../features/home/data/repo/home_repo_impl.dart' as _i1024;
import '../../features/home/domain/repo/home_data_source_interface.dart'
    as _i273;
import '../../features/home/domain/repo/home_repo_interface.dart' as _i1027;
import '../../features/home/domain/use_case/get_categories_usecase.dart'
    as _i315;
import '../../features/home/domain/use_case/get_products_usecase.dart' as _i111;
import '../../features/home/presentation/view_model/categories_cubit.dart'
    as _i550;
import '../../features/home/presentation/view_model/products_cubit.dart'
    as _i915;
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
import '../network/dio_module.dart' as _i614;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioModule = _$DioModule();
    gh.lazySingleton<_i361.Dio>(() => dioModule.provideDio());
    gh.lazySingleton<_i437.AppSectionCubit>(() => _i437.AppSectionCubit());
    gh.factory<_i575.CategoryDataSourceInterface>(
      () => _i758.CategoryDataSourceImp(gh<_i361.Dio>()),
    );
    gh.factory<_i889.CategoryRepoInterface>(
      () => _i610.CategoryRepoImp(gh<_i575.CategoryDataSourceInterface>()),
    );
    gh.factory<_i289.HelloDataSourceInterface>(
      () => _i474.HelloDataSourceImp(),
    );
    gh.factory<_i907.HelloRepoInterface>(
      () => _i138.HelloRepoImp(gh<_i289.HelloDataSourceInterface>()),
    );
    gh.factory<_i4.OnboardingDataSourceInterface>(
      () => _i180.OnboardingDataSourceImp(),
    );
    gh.factory<_i1029.GetCategoryProductsUseCase>(
      () =>
          _i1029.GetCategoryProductsUseCase(gh<_i889.CategoryRepoInterface>()),
    );
    gh.lazySingleton<_i273.HomeDataSourceInterface>(
      () => _i576.HomeDataSourceRemoteImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i831.AccountRemoteDataSource>(
      () => _i831.AccountRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.factory<_i398.OnboardingRepoInterface>(
      () => _i371.OnboardingRepoImp(
        onboardingDataSourceInterface: gh<_i4.OnboardingDataSourceInterface>(),
      ),
    );
    gh.factory<_i662.CategoryCubit>(
      () => _i662.CategoryCubit(gh<_i1029.GetCategoryProductsUseCase>()),
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
    gh.lazySingleton<_i1027.HomeRepoInterface>(
      () => _i1024.HomeRepoImpl(gh<_i273.HomeDataSourceInterface>()),
    );
    gh.factory<_i608.IsOnboardingSeenUseCase>(
      () => _i608.IsOnboardingSeenUseCase(gh<_i398.OnboardingRepoInterface>()),
    );
    gh.factory<_i848.SaveOnboardingSeenUseCase>(
      () =>
          _i848.SaveOnboardingSeenUseCase(gh<_i398.OnboardingRepoInterface>()),
    );
    gh.lazySingleton<_i684.AccountRepoInterface>(
      () => _i781.AccountRepoImpl(gh<_i831.AccountRemoteDataSource>()),
    );
    gh.factory<_i588.EditUserDataUseCase>(
      () => _i588.EditUserDataUseCase(gh<_i684.AccountRepoInterface>()),
    );
    gh.factory<_i140.GetUserDataUseCase>(
      () => _i140.GetUserDataUseCase(gh<_i684.AccountRepoInterface>()),
    );
    gh.factory<_i315.GetCategoriesUseCase>(
      () => _i315.GetCategoriesUseCase(gh<_i1027.HomeRepoInterface>()),
    );
    gh.factory<_i111.GetProductsUseCase>(
      () => _i111.GetProductsUseCase(gh<_i1027.HomeRepoInterface>()),
    );
    gh.factory<_i917.OnboardingCubit>(
      () => _i917.OnboardingCubit(
        gh<_i848.SaveOnboardingSeenUseCase>(),
        gh<_i608.IsOnboardingSeenUseCase>(),
      ),
    );
    gh.factory<_i915.ProductsCubit>(
      () => _i915.ProductsCubit(gh<_i111.GetProductsUseCase>()),
    );
    gh.factory<_i550.CategoriesCubit>(
      () => _i550.CategoriesCubit(gh<_i315.GetCategoriesUseCase>()),
    );
    gh.factory<_i802.AccountCubit>(
      () => _i802.AccountCubit(
        gh<_i140.GetUserDataUseCase>(),
        gh<_i588.EditUserDataUseCase>(),
      ),
    );
    return this;
  }
}

class _$DioModule extends _i614.DioModule {}
