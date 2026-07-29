import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:shopping_app/core/common/model/product_item/product_item_entity.dart';
import 'package:shopping_app/core/common/pagination/pagination_state.dart';
import 'package:shopping_app/core/common/widgets/error_info.dart';
import 'package:shopping_app/core/common/widgets/product_card.dart';
import 'package:shopping_app/core/constants/app_assets.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/constants/app_strings.dart';
import 'package:shopping_app/core/theme/app_style.dart';
import 'package:shopping_app/features/home/presentation/view/widgets/product_card_shimmer.dart';
import 'package:shopping_app/features/home/presentation/view_model/products_cubit.dart';

class ProductsSection extends StatelessWidget {
  const ProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, PaginationState<ProductItemEntity>>(
      builder: (context, state) {
        final cubit = context.read<ProductsCubit>();

        if (state.isFirstLoading) {
          return _buildLoading();
        }

        if (state.errorMessage != null && state.items.isEmpty) {
          return _buildError(context, state.errorMessage!, onRetry: cubit.fetchFirstPage);
        }

        if (state.items.isEmpty) {
          return _buildEmpty();
        }

        return Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: AppSpacing.horizontalX2,
              itemCount: state.items.length,
              gridDelegate: AppStyles.productsGridDelegate,
              itemBuilder: (_, index) {
                return ProductCard(product: state.items[index], onAddToCart: () {}, onFavorite: () {});
              },
            ),

            if (state.isLoadingMore)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Center(child: Lottie.asset(AppAssets.loadingLottie, height: 120)),
              ),

            if (state.hasReachedMax)
              const Padding(padding: EdgeInsets.symmetric(vertical: 16), child: Text('No more products')),
          ],
        );
      },
    );
  }

  Widget _buildLoading({int itemCount = 8}) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: AppSpacing.horizontalX2,
      itemCount: itemCount,
      gridDelegate: AppStyles.productsGridDelegate,
      itemBuilder: (_, _) => const ProductCardShimmer(),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        children: [
          verticalSpace(96),
          Image.asset(AppAssets.emptyProduct, height: 96),
          const SizedBox(height: 16),
          const Text('No products available'),
        ],
      ),
    );
  }

  Widget _buildError(BuildContext context, String error, {required VoidCallback onRetry}) {
    return Padding(
      padding: AppSpacing.allX2,
      child: ErrorInfo(title: AppStrings.errorOccurred, description: error, btnText: AppStrings.retry, press: onRetry),
    );
  }
}
