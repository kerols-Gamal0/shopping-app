import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shopping_app/core/common/model/product_item/product_item_entity.dart';
import 'package:shopping_app/core/common/widgets/loading_more_widget.dart';
import 'package:shopping_app/core/common/widgets/product_card.dart';
import 'package:shopping_app/core/constants/app_assets.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/constants/app_strings.dart';
import 'package:shopping_app/core/extensions/context_extension.dart';
import 'package:shopping_app/core/theme/app_style.dart';
import 'package:shopping_app/features/search/data/models/search_products_by_category_request_body.dart';
import 'package:shopping_app/features/search/presentation/view_model/bloc/search_products_by_category_bloc.dart';

class SearchResultsGrid extends StatelessWidget {
  const SearchResultsGrid({
    super.key,
    required this.products,
    required this.state,
    required this.body,
    required this.bloc,
  });

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

          if (state.isLoadingMore) const LoadingMoreWidget(),

          if (!state.hasMore)
            const Padding(
              padding: EdgeInsets.only(bottom: 24),
              child: Text(AppStrings.noMoreData),
            ),

          if (state.paginationError != null)
            Padding(
              padding: AppSpacing.allX2,
              child: Text(
                state.paginationError!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
        ],
      ),
    );
  }
}
