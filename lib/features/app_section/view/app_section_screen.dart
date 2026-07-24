import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/constants/app_assets.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/features/account/presentation/account.dart';
import 'package:shopping_app/features/app_section/view_model/app_section_cubit.dart';
import 'package:shopping_app/features/cart/presentation/cart.dart';
import 'package:shopping_app/features/favourite/presentation/favourite.dart';
import 'package:shopping_app/features/home/presentation/home.dart';

class AppSectionScreen extends StatelessWidget {
  AppSectionScreen({super.key});

  final List<Widget> tabs = [
    HomeScreen(),
    CartScreen(),
    FavouriteScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppSectionCubit>(
      create: (_) => getIt<AppSectionCubit>(),
      child: BlocBuilder<AppSectionCubit, int>(
        builder: (context, selectedIndex) {
          return Scaffold(
            body: IndexedStack(index: selectedIndex, children: tabs),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: selectedIndex,
              onTap: (index) =>
                  context.read<AppSectionCubit>().changeTab(index),
              items: [
                BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage(AppAssets.homeIcon)),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage(AppAssets.cartIcon)),
                  label: 'Cart',
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage(AppAssets.favouriteIcon)),
                  label: 'Favourite',
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage(AppAssets.accountIcon)),
                  label: 'Account',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
