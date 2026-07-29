import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/common/screens/error_404_screen.dart';
import 'package:shopping_app/core/common/screens/launcher_screen.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/core/routing/app_routes.dart';
import 'package:shopping_app/features/category/presentation/view/category_screen.dart';
import 'package:shopping_app/features/category/presentation/view_model/category_cubit/category_cubit.dart';
import 'package:shopping_app/features/category/presentation/view_model/category_cubit/category_intent.dart';
import 'package:shopping_app/features/hello/presentation/view/screens/hello_screen.dart';
import 'package:shopping_app/features/auth/login_screen.dart';
import 'package:shopping_app/features/auth/register_screen.dart';
import 'package:shopping_app/features/hello/presentation/view_model/hello_cubit.dart';
import 'package:shopping_app/features/account/presentation/account.dart';
import 'package:shopping_app/features/app_section/view/app_section_screen.dart';
import 'package:shopping_app/features/app_section/view_model/app_section_cubit.dart';
import 'package:shopping_app/features/cart/presentation/cart.dart';
import 'package:shopping_app/features/favourite/presentation/favourite.dart';
import 'package:shopping_app/features/onboarding/presentation/view/screen/onboarding_screen.dart';
import 'package:shopping_app/features/onboarding/presentation/view_model/cubit/onboarding_cubit.dart';
import 'package:shopping_app/features/product_details_screen/presentation/view/product_details_screen.dart';

class AppRouter {
  AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    // final arguments = setting.arguments;
    switch (settings.name) {
      case AppRoutes.appSection:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AppSectionCubit(),
            child: AppSectionScreen(),
          ),
        );
      case AppRoutes.cartScreen:
        return MaterialPageRoute(builder: (context) => const CartScreen());
      case AppRoutes.favouriteScreen:
        return MaterialPageRoute(builder: (context) => const FavouriteScreen());
      case AppRoutes.accountScreen:
        return MaterialPageRoute(builder: (context) => const AccountScreen());
      case AppRoutes.onboardingRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => serviceLocator<OnboardingCubit>(),
            child: OnboardingScreen(),
          ),
        );

      case AppRoutes.helloRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<HelloCubit>(
            create: (context) => serviceLocator<HelloCubit>(),
            child: HelloScreen(),
          ),
        );
      case AppRoutes.launcherRoute:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<OnboardingCubit>(
                create: (context) => serviceLocator<OnboardingCubit>(),
              ),
              BlocProvider<HelloCubit>(
                create: (context) => serviceLocator<HelloCubit>(),
              ),
            ],
            child: LauncherScreen(),
          ),
        );
      case AppRoutes.loginRoute:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case AppRoutes.registerRoute:
        return MaterialPageRoute(builder: (context) => RegisterScreen());
      case AppRoutes.productDetailsRoute:
        final productId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) => ProductDetailsScreen(productId: productId),
        );

      case AppRoutes.productByCategoryRoute:
        final categoryName = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => serviceLocator<CategoryCubit>()
              ..processIntent(
                FetchCategoryProductsIntent(categoryName: categoryName),
              ),
            child: CategoryScreen(categoryName: categoryName),
          ),
        );

      default:
        return MaterialPageRoute(builder: (context) => Error404Screen());
    }
  }
}
