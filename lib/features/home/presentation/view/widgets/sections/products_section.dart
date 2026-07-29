import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/common/model/product_item/product_item_entity.dart';
import 'package:shopping_app/core/common/pagination/pagination_state.dart';
import 'package:shopping_app/core/common/widgets/product_card.dart';
import 'package:shopping_app/core/constants/app_assets.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/routing/app_routes.dart';
import 'package:shopping_app/core/theme/app_style.dart';
import 'package:shopping_app/features/home/presentation/view/widgets/product_card_shimmer.dart';
import 'package:shopping_app/features/home/presentation/view_model/products_cubit.dart';

class ProductsSection extends StatelessWidget {
  const ProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, PaginationState<ProductItemEntity>>(
      builder: (context, state) {
        if (state.isFirstLoading) return _buildOnLoadingWidget();
        if (state.errorMessage != null && state.items.isEmpty)
          return _buildOnFailureWidget(state, context);
        return _buildOnSuccessWidget(state, products: state.items);
      },
    );
  }

  // Widget _buildOnLoadingWidget() => const ProductsShimmerWidget();
  Widget _buildOnLoadingWidget({int itemCount = 8}) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: AppSpacing.horizontalX2,
      itemCount: itemCount,
      gridDelegate: AppStyles.productsGridDelegate,
      itemBuilder: (_, _) => ProductCardShimmer(),
    );
  }

  Widget _buildOnSuccessWidget(
    PaginationState<ProductItemEntity> state, {
    required List<ProductItemEntity> products,
  }) {
    if (state.isLoadingMore) {
      return const Padding(
        padding: AppSpacing.allX2,
        child: Center(child: CupertinoActivityIndicator()),
      );
    }
    if (products.isEmpty) {
      return Center(
        child: Column(
          children: [
            verticalSpace(96),
            Image.asset(AppAssets.emptyProduct, height: 96),
            Text("No products available in this category right now."),
          ],
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: AppSpacing.horizontalX2,
      itemCount: products.length,
      gridDelegate: AppStyles.productsGridDelegate,
      itemBuilder: (context, index) {
        return ProductCard(
          key: ValueKey(products[index].id),
          product: products[index],
          onAddToCart: () {},
          onFavorite: () {},
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.productDetailsRoute,
              arguments: products[index].id,
            );
          },
        );
      },
    );
  }

  Widget _buildOnFailureWidget(
    PaginationState<ProductItemEntity> state,
    BuildContext context,
  ) {
    return Center(
      child: Padding(
        padding: AppSpacing.allX2,
        child: Column(
          crossAxisAlignment: .center,
          mainAxisAlignment: .center,
          children: [
            verticalSpace(96),
            Image.asset(AppAssets.errorIcon, height: 96),
            Text(
              state.errorMessage!,
              textAlign: .center,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ],
        ),
      ),
    );
  }
}
