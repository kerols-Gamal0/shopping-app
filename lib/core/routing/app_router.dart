import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/common/screens/error_404_screen.dart';
import 'package:shopping_app/core/routing/app_routes.dart';
import 'package:shopping_app/features/account/presentation/account.dart';
import 'package:shopping_app/features/app_section/view/app_section_screen.dart';
import 'package:shopping_app/features/app_section/view_model/app_section_cubit.dart';
import 'package:shopping_app/features/cart/presentation/cart.dart';
import 'package:shopping_app/features/favourite/presentation/favourite.dart';
import 'package:shopping_app/features/home/presentation/view/screen/home_screen.dart';
import 'package:shopping_app/features/onboarding/presentation/view/screen/onboarding_screen.dart';
import 'package:shopping_app/test_screen.dart';

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
        return MaterialPageRoute(builder: (context) => OnboardingScreen());
      case AppRoutes.testRoute:
        return MaterialPageRoute(builder: (context) => TestScreen());
      case AppRoutes.homeRouteV2:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      default:
        return MaterialPageRoute(builder: (context) => Error404Screen());
    }
  }
}
