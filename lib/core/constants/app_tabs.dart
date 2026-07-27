import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/features/account/presentation/account.dart';
import 'package:shopping_app/features/cart/presentation/cart.dart';
import 'package:shopping_app/features/favourite/presentation/favourite.dart';
import 'package:shopping_app/features/home/presentation/view/home.dart';
import 'package:shopping_app/features/home/presentation/view_model/categories_cubit.dart';
import 'package:shopping_app/features/home/presentation/view_model/products_cubit.dart';

class AppTabs {
  AppTabs._();

  static final List<Widget> tabs = [
    MultiBlocProvider(
      providers: [
        BlocProvider.value(value: serviceLocator<CategoriesCubit>()..intent(FetchCategories())),
        BlocProvider.value(value: serviceLocator<ProductsCubit>()..fetchFirstPage()),
      ],
      child: HomeScreen(),
    ),
    CartScreen(),
    FavouriteScreen(),
    AccountScreen(),
  ];
}
