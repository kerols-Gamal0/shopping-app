import 'package:flutter/material.dart';
import 'package:shopping_app/core/common/screens/error_404_screen.dart';
import 'package:shopping_app/core/routing/app_routes.dart';
import 'package:shopping_app/features/account/presentation/account.dart';
import 'package:shopping_app/features/app_section/view/app_section_screen.dart';
import 'package:shopping_app/features/cart/presentation/cart.dart';
import 'package:shopping_app/features/favourite/presentation/favourite.dart';
import 'package:shopping_app/features/home/presentation/home.dart';

class AppRouter {
  AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    // final arguments = setting.arguments;
    switch (settings.name) {
      case AppRoutes.appSection:
        return MaterialPageRoute(
          builder: (context) => const AppSectionScreen(),
        );
      case AppRoutes.homeScreen: // final args = arguments;
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case AppRoutes.cartScreen:
        return MaterialPageRoute(builder: (context) => const CartScreen());
      case AppRoutes.favouriteScreen:
        return MaterialPageRoute(builder: (context) => const FavouriteScreen());
      case AppRoutes.accountScreen:
        return MaterialPageRoute(builder: (context) => const AccountScreen());
      default:
        return MaterialPageRoute(builder: (context) => Error404Screen());
    }
  }
}
