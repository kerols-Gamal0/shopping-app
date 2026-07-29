import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shopping_app/core/common/base_state/base_state.dart';
import 'package:shopping_app/core/common/base_state/base_state_builder.dart';
import 'package:shopping_app/core/common/model/product_item/product_item_entity.dart';
import 'package:shopping_app/core/common/widgets/product_card.dart';
import 'package:shopping_app/core/constants/app_assets.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/theme/app_style.dart';
import 'package:shopping_app/features/home/presentation/view/widgets/product_card_shimmer.dart';
import 'package:shopping_app/features/search/data/models/search_products_by_category_request_body.dart';
import 'package:shopping_app/features/search/presentation/view_model/bloc/search_products_by_category_bloc.dart';

class SearchBody extends StatelessWidget {
  const SearchBody({super.key, required this.state, required this.bloc, required this.body});

  final SearchProductsByCategoryState state;
  final SearchProductsByCategoryBloc bloc;
  final SearchProductsByCategoryRequestBody Function() body;

  @override
  Widget build(BuildContext context) {
    if (state.searchState is BaseInitialState) {
      return const _InitialWidget();
    }

    return BaseStateBuilder<List<ProductItemEntity>>(
      state: state.searchState,
      onLoading: () => const _LoadingWidget(),
      onError: (error) => _ErrorWidget(error: error),
      onSuccess: (products) => _ProductsGrid(products: products, state: state, body: body, bloc: bloc),
    );
  }
}

class _InitialWidget extends StatelessWidget {
  const _InitialWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(AppAssets.searchLottie, height: 124),
          verticalSpace(AppSpacing.x1),
          const Text('Start typing to search for products.'),
        ],
      ),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: AppSpacing.horizontalX2,
      gridDelegate: AppStyles.productsGridDelegate,
      itemCount: 8,
      itemBuilder: (_, _) => const ProductCardShimmer(),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget({required this.error});

  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppSpacing.allX2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppAssets.errorIcon, height: 96),
            verticalSpace(AppSpacing.x1),

            Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductsGrid extends StatelessWidget {
  const _ProductsGrid({required this.products, required this.state, required this.body, required this.bloc});

  final List<ProductItemEntity> products;
  final SearchProductsByCategoryState state;
  final SearchProductsByCategoryBloc bloc;
  final SearchProductsByCategoryRequestBody Function() body;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scroll) {
        if (scroll.metrics.pixels >= scroll.metrics.maxScrollExtent - 150) {
          if (!state.isLoadingMore && state.hasMore) {
            bloc.add(LoadMoreProducts(body()));
          }
        }
        return false;
      },
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: AppSpacing.horizontalX2,
              gridDelegate: AppStyles.productsGridDelegate,
              itemCount: products.length,
              itemBuilder: (_, index) => ProductCard(product: products[index]),
            ),
          ),

          if (state.isLoadingMore) const _LoadMoreWidget(),

          if (!state.hasMore) const Padding(padding: EdgeInsets.only(bottom: 24), child: Text('No more data')),

          if (state.paginationError != null)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(state.paginationError!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
            ),
        ],
      ),
    );
  }
}

class _LoadMoreWidget extends StatelessWidget {
  const _LoadMoreWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(child: Lottie.asset(AppAssets.loadingLottie, height: 142)),
    );
  }
}
