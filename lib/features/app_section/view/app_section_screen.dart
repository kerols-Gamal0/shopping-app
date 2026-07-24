import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/constants/app_assets.dart';
import 'package:shopping_app/core/constants/app_tabs.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/features/app_section/view_model/app_section_cubit.dart';

class AppSectionScreen extends StatelessWidget {
  const AppSectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppSectionCubit>(
      create: (_) => getIt<AppSectionCubit>(),
      child: BlocBuilder<AppSectionCubit, int>(
        builder: (context, selectedIndex) {
          return Scaffold(
            body: IndexedStack(index: selectedIndex, children: AppTabs.tabs),
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
