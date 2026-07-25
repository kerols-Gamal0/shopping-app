import 'package:flutter/material.dart';
import 'package:shopping_app/features/account/presentation/account.dart';
import 'package:shopping_app/features/cart/presentation/cart.dart';
import 'package:shopping_app/features/favourite/presentation/favourite.dart';

import '../../features/home/presentation/home.dart';

class AppTabs {
  AppTabs._();

  static final List<Widget> tabs = [
    HomeScreen(),
    CartScreen(),
    FavouriteScreen(),
    AccountScreen(),
  ];
}
