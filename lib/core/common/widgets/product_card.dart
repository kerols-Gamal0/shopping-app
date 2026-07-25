import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
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
    final double finalPrice =
        product.price - (product.discountPercentage / 100 * product.price);

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
                    decoration: const BoxDecoration(
                      color: AppColors.backgroundV2,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: AppSpacing.x1),
                      child: CachedNetworkImage(
                        imageUrl: product.thumbnail,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(color: Colors.white),
                        ),
                        errorWidget: (context, url, error) => const Center(
                          child: Icon(
                            Icons.error_outline,
                            color: Colors.redAccent,
                            size: 28,
                          ),
                        ),
                      ),
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
                        overflow: TextOverflow.ellipsis,
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
                        Expanded(
                          child: Text(
                            "(${product.reviewCount} reviews)",
                            style: AppTheme.lightTheme.textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            "EGP ${finalPrice.toStringAsFixed(2)}",
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (product.discountPercentage > 0) ...[
                          const SizedBox(width: 4),
                          Container(
                            height: 25,
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSpacing.x1,
                            ),
                            alignment: Alignment.center,
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
                      ],
                    ),

                    const SizedBox(height: 10),
                    SizedBox(
                      height: 55,
                      child: Text(
                        product.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
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
                            const Spacer(),
                            const Icon(
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
