import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/constants/app_assets.dart';
import 'package:shopping_app/features/account/presentation/account.dart';
import 'package:shopping_app/features/app_section/view_model/app_section_cubit.dart';
import 'package:shopping_app/features/cart/presentation/cart.dart';
import 'package:shopping_app/features/favourite/presentation/favourite.dart';
import 'package:shopping_app/features/home/presentation/home.dart';

class AppSectionScreen extends StatelessWidget {
  const AppSectionScreen({super.key});

  static const List<Widget> tabs = [
    HomeScreen(),
    CartScreen(),
    FavouriteScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppSectionCubit(),
      child: Scaffold(
        body: BlocBuilder<AppSectionCubit, int>(
          builder: (context, selectedIndex) {
            return IndexedStack(index: selectedIndex, children: tabs);
          },
        ),
        bottomNavigationBar: BlocBuilder<AppSectionCubit, int>(
          builder: (context, selectedIndex) {
            final colorScheme = Theme.of(context).colorScheme;
            final textTheme = Theme.of(context).textTheme;

            return BottomNavigationBar(
              currentIndex: selectedIndex,
              onTap: (index) =>
                  context.read<AppSectionCubit>().changeTab(index),
              type: BottomNavigationBarType.fixed,

              backgroundColor: colorScheme.surface,
              selectedItemColor: colorScheme.primary,
              unselectedItemColor: colorScheme.onSurfaceVariant,

              selectedLabelStyle: textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: textTheme.bodySmall,

              items: const [
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
            );
          },
        ),
      ),
    );
  }
}
