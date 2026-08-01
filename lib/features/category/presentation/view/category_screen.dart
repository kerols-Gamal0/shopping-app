import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_app/core/common/base_state/base_state_builder.dart';
import 'package:shopping_app/core/common/model/product_item/product_item_entity.dart';
import 'package:shopping_app/core/common/widgets/error_info.dart';
import 'package:shopping_app/core/common/widgets/loading_more_widget.dart';
import 'package:shopping_app/core/common/widgets/product_card.dart';
import 'package:shopping_app/core/constants/app_assets.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/constants/app_strings.dart';
import 'package:shopping_app/core/routing/app_routes.dart';
import 'package:shopping_app/core/theme/app_style.dart';
import 'package:shopping_app/core/common/widgets/product_card_shimmer.dart';
import 'package:shopping_app/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:shopping_app/features/cart/presentation/view_model/cart_intent.dart';
import '../view_model/category_cubit/category_cubit.dart';
import '../view_model/category_cubit/category_intent.dart';

class CategoryScreen extends StatelessWidget {
  final String categoryName;

  const CategoryScreen({super.key, this.categoryName = 'beauty'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryName.toUpperCase(),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          final cubit = context.read<CategoryCubit>();

          return BaseStateBuilder<List<ProductItemEntity>>(
            state: state.categoryState,
            onSuccess: (products) {
              if (products.isEmpty) {
                return SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(AppSpacing.x2),
                    child: Column(
                      children: [
                        const Spacer(flex: 2),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: SvgPicture.string(
                              AppAssets.error404Illustration,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                        const Spacer(flex: 2),
                        ErrorInfo(
                          title: AppStrings.noProductsFound,
                          description: AppStrings.noProductsFoundDesc,
                          btnText: AppStrings.retry,
                          press: () {
                            cubit.processIntent(
                              FetchCategoryProductsIntent(
                                categoryName: categoryName,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }

              return NotificationListener<ScrollNotification>(
                onNotification: (scrollInfo) {
                  if (scrollInfo.metrics.pixels >=
                      scrollInfo.metrics.maxScrollExtent - 150) {
                    if (!cubit.isLoadingMore) {
                      cubit.processIntent(
                        FetchCategoryProductsIntent(
                          categoryName: categoryName,
                          isLoadMore: true,
                        ),
                      );
                    }
                  }
                  return false;
                },
                child: Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        padding: EdgeInsets.all(AppSpacing.x2),
                        gridDelegate: AppStyles.productsGridDelegate,
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return ProductCard(
                            product: product,
                            onTap: () => Navigator.pushNamed(
                              context,
                              AppRoutes.productDetailsRoute,
                              arguments: product.id,
                            ),
                            onFavorite: () {},
                            onAddToCart: () {
                              context.read<CartCubit>().doIntent(
                                AddToCartEvent(
                                  productId: product.id.toString(),
                                  title: product.title,
                                  price: product.price,
                                  thumbnail: product.thumbnail,
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(
                                  const SnackBar(
                                    content: Text(AppStrings.addedToCart),
                                    backgroundColor: Colors.green,
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                            },
                          );
                        },
                      ),
                    ),
                    if (cubit.isLoadingMore) LoadingMoreWidget(),
                    if (!cubit.hasMore) Text(AppStrings.noMoreData),
                  ],
                ),
              );
            },
            onLoading: () {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: AppSpacing.horizontalX2,
                itemCount: 8,
                gridDelegate: AppStyles.productsGridDelegate,
                itemBuilder: (_, _) => ProductCardShimmer(),
              );
            },
            onError: (String error) {
              return SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(AppSpacing.x2),
                  child: Center(
                    child: ErrorInfo(
                      title: AppStrings.errorOccurred,
                      description: error,
                      btnText: AppStrings.retry,
                      press: () {
                        cubit.processIntent(
                          FetchCategoryProductsIntent(
                            categoryName: categoryName,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
