import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopping_app/core/common/widgets/app_btns.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/constants/app_strings.dart';
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
    return Container(
      decoration: AppStyles.productCardDecoration,
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 1.1,
                child: Container(
                  width: double.infinity,
                  decoration: AppStyles.productImageDecoration,
                  child: CachedNetworkImage(
                    imageUrl: product.thumbnail,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: AppColors.border,
                      highlightColor: AppColors.divider,
                      child: Container(color: AppColors.surface),
                    ),
                    errorWidget: (context, url, error) => const Center(
                      child: Icon(
                        Icons.error_outline,
                        color: AppColors.error,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.surface.withValues(alpha: .25),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: onFavorite,
                    icon: Icon(
                      product.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: AppColors.primary,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),

          Expanded(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.x1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        style: AppTheme.lightTheme.textTheme.headlineMedium,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      verticalSpace(4),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: AppColors.warning,
                            size: 14,
                          ),
                          horizontalSpace(4),
                          Text(
                            product.rating.toString(),
                            style: AppTheme.lightTheme.textTheme.bodySmall,
                          ),
                          horizontalSpace(4),
                          Expanded(
                            child: Text(
                              "(${product.reviewCount} ${AppStrings.reviews})",
                              style: AppTheme.lightTheme.textTheme.bodySmall,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              "EGP ${product.finalPrice.toStringAsFixed(2)}",
                              style: AppTheme.lightTheme.textTheme.titleMedium
                                  ?.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (product.discountPercentage > 0) ...[
                            horizontalSpace(4),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppSpacing.x1,
                                vertical: 2,
                              ),
                              alignment: Alignment.center,
                              decoration: AppStyles.discountBadgeDecoration,
                              child: Text(
                                "-${product.discountPercentage.toInt()}%",
                                style: AppTheme.lightTheme.textTheme.labelSmall
                                    ?.copyWith(
                                      color: AppColors.primaryDark,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      verticalSpace(6),
                      Text(
                        product.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTheme.lightTheme.textTheme.bodyMedium
                            ?.copyWith(color: AppColors.bodyLight),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 32,
                    child: PrimaryBtn(
                      onPressed: onAddToCart,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.addToCart,
                            style: AppTheme.lightTheme.textTheme.labelMedium,
                          ),
                          horizontalSpace(8),
                          const Icon(
                            Icons.add_shopping_cart_sharp,
                            color: AppColors.surface,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
