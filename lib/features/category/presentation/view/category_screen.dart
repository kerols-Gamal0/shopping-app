import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopping_app/core/common/base_state/base_state_builder.dart';
import 'package:shopping_app/core/common/widgets/error_info.dart';
import 'package:shopping_app/core/common/widgets/product_card.dart';
import 'package:shopping_app/core/constants/app_assets.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/constants/app_strings.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_style.dart';
import 'package:shopping_app/core/model/item/product_item_entity.dart';
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
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.48,
                          crossAxisSpacing: AppSpacing.x2,
                          mainAxisSpacing: AppSpacing.x2,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          return ProductCard(product: products[index]);
                        },
                      ),
                    ),
                    if (cubit.isLoadingMore)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: AppSpacing.x2),
                        child: Shimmer.fromColors(
                          baseColor: AppColors.disabled,
                          highlightColor: AppColors.backgroundV2,
                          child: Container(
                            height: 60,
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(
                              horizontal: AppSpacing.x2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(
                                AppSpacing.x1,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
            onLoading: () {
              return GridView.builder(
                padding: EdgeInsets.all(AppSpacing.x2),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.48,
                  crossAxisSpacing: AppSpacing.x2,
                  mainAxisSpacing: AppSpacing.x2,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                    baseColor: AppColors.disabled,
                    highlightColor: AppColors.backgroundV2,
                    child: Container(
                      decoration: AppStyles.productCardDecoration,
                    ),
                  );
                },
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
