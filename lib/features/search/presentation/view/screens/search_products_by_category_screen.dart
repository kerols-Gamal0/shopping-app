import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:shopping_app/core/common/base_state/base_state_builder.dart';
import 'package:shopping_app/core/common/model/product_item/product_item_entity.dart';
import 'package:shopping_app/core/common/widgets/product_card.dart';
import 'package:shopping_app/core/constants/app_assets.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/theme/app_style.dart';
import 'package:shopping_app/features/home/presentation/view/widgets/product_card_shimmer.dart';
import 'package:shopping_app/features/search/data/models/search_products_by_category_request_body.dart';
import 'package:shopping_app/features/search/presentation/view_model/bloc/search_products_by_category_bloc.dart';

class SearchProductsByCategoryScreen extends StatefulWidget {
  const SearchProductsByCategoryScreen({super.key, this.category = 'smartphones'});

  final String category;

  @override
  State<SearchProductsByCategoryScreen> createState() => _SearchProductsByCategoryScreenState();
}

class _SearchProductsByCategoryScreenState extends State<SearchProductsByCategoryScreen> {
  late final ScrollController _scrollController;
  late final TextEditingController searchController;

  SearchProductsByCategoryRequestBody get body =>
      SearchProductsByCategoryRequestBody().copyWith(category: widget.category, search: searchController.text.trim());

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()..addListener(_onScroll);
    searchController = TextEditingController();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * .75) {
      context.read<SearchProductsByCategoryBloc>().add(LoadMoreProducts(body));
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.allX1,
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              const SliverToBoxAdapter(child: SizedBox(height: 24)),

              SliverToBoxAdapter(
                child: TextFormField(
                  controller: searchController,
                  decoration: const InputDecoration(hintText: 'Search for your products'),
                  onChanged: (value) => context.read<SearchProductsByCategoryBloc>().add(
                    SearchQueryChanged(body.copyWith(search: value)),
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 24)),

              BlocBuilder<SearchProductsByCategoryBloc, SearchProductsByCategoryState>(
                builder: (context, state) {
                  return BaseStateBuilder<List<ProductItemEntity>>(
                    state: state.searchState,
                    onLoading: () {
                      return SliverPadding(
                        padding: AppSpacing.horizontalX2,
                        sliver: SliverGrid(
                          delegate: SliverChildBuilderDelegate((_, _) => const ProductCardShimmer(), childCount: 8),
                          gridDelegate: AppStyles.productsGridDelegate,
                        ),
                      );
                    },
                    onSuccess: (products) {
                      if (products.isEmpty) {
                        return SliverFillRemaining(
                          hasScrollBody: false,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(AppAssets.emptyProduct, height: 96),
                                const SizedBox(height: 16),
                                const Text(
                                  'No products available in this category right now.',
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      return SliverPadding(
                        padding: AppSpacing.horizontalX2,
                        sliver: SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (_, index) => ProductCard(product: products[index]),
                            childCount: products.length,
                          ),
                          gridDelegate: AppStyles.productsGridDelegate,
                        ),
                      );
                    },
                    onError: (error) {
                      return SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Padding(
                            padding: AppSpacing.allX2,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(AppAssets.errorIcon, height: 96),
                                const SizedBox(height: 16),
                                Text(
                                  error,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    loadMoreWidget: state.hasMore
                        ? SliverToBoxAdapter(
                          child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Center(child: Lottie.asset(AppAssets.loadingLottie, height: 142)),
                            ),
                        )
                        : null,
                  );
                },
              ),
              //* LoadMore
              // BlocBuilder<SearchProductsByCategoryBloc, SearchProductsByCategoryState>(
              //   builder: (context, state) {
              //     if (!state.hasMore) {
              //       return const SliverToBoxAdapter(child: SizedBox.shrink());
              //     }
              //     return SliverToBoxAdapter(
              //       child: Padding(
              //         padding: const EdgeInsets.all(16),
              //         child: Center(child: Lottie.asset(AppAssets.loadingLottie, height: 142)),
              //       ),
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
