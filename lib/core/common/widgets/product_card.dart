import 'package:flutter/material.dart';
import 'package:shopping_app/core/common/widgets/app_btns.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/model/item/product_item_entity.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_style.dart';
import 'package:shopping_app/core/theme/app_theme.dart';

class ProductCard extends StatelessWidget {
  final ProductItemEntity product;
  final VoidCallback? onAddToCart;
  final VoidCallback? onFavorite;
  const ProductCard({
    super.key,
    required this.product,
    this.onAddToCart,
    this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.backgroundV2,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: AppColors.backgroundV2,
              width: 1.5,
              style: BorderStyle.solid,
            ),
            boxShadow: [AppStyles.kBlackShadowSmall],
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.backgroundV2,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: AppSpacing.x1),
                      child:
                          //TODO:replace with cached network image
                          // CachedNetworkImage(
                          //   imageUrl: product.thumbnail,
                          //   placeholder: (context, url) =>
                          //       Image.asset(AppPlaceholder.homeScreenPlaceHolder,
                          //           fit: BoxFit.contain),
                          // ),
                          Image.asset(product.thumbnail, fit: BoxFit.contain),
                    ),
                  ),

                  Positioned(
                    top: 10,
                    right: 10,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: AppColors.surface.withValues(alpha: .25),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: onFavorite,
                        icon: Icon(
                          product.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: AppColors.primary,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: EdgeInsets.all(AppSpacing.x1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Text(
                        product.title,
                        style: AppTheme.lightTheme.textTheme.headlineMedium,
                        overflow: .ellipsis,
                        maxLines: 1,
                      ),
                    ),

                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 15),
                        const SizedBox(width: 6),
                        Text(
                          product.rating.toString(),

                          style: AppTheme.lightTheme.textTheme.bodySmall,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "(${product.reviewCount.toString()} reviews)",

                          style: AppTheme.lightTheme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Text(
                          "EGP ${product.price - (product.discountPercentage / 100 * product.price).round()} ",
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          maxLines: 2,
                          overflow: .ellipsis,
                        ),

                        const Spacer(),

                        if (product.discountPercentage > 0)
                          Container(
                            height: 25,

                            padding: EdgeInsets.symmetric(
                              horizontal: AppSpacing.x1,
                            ),
                            alignment: .center,
                            decoration: BoxDecoration(
                              color: Colors.orange.shade50,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              "-${product.discountPercentage.toInt()}%",
                              style: const TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 55,
                      child: Text(
                        product.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.bodyLight,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 35,
                      child: PrimaryBtn(
                        onPressed: onAddToCart,
                        child: Row(
                          children: [
                            Text(
                              'Add to Cart',
                              style: AppTheme.lightTheme.textTheme.labelMedium,
                            ),
                            Spacer(),
                            Icon(
                              Icons.add_shopping_cart_sharp,
                              color: AppColors.surface,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
