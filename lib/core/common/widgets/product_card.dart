import 'package:flutter/material.dart';
import 'package:shopping_app/core/model/item/product_item_entity.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
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
              color: AppColors.primaryLight,
              width: 1.5,
              style: BorderStyle.solid,
            ),
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
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Image.asset(product.image, fit: BoxFit.contain),
                    ),
                  ),

                  Positioned(
                    top: 1,
                    right: 1,
                    child: IconButton(
                      onPressed: onFavorite,
                      icon: Icon(
                        product.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                      ),
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: AppTheme.lightTheme.textTheme.bodyLarge,
                    ),

                    const SizedBox(height: 6),

                    Text(
                      product.discount > 0
                          ? "-${product.discount.toString()}%"
                          : "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 22,
                        color: AppColors.bodyLight,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "EGP ${product.price}",
                      style: AppTheme.lightTheme.textTheme.headlineLarge,
                    ),

                    const SizedBox(height: 10),

                    Row(
                      children: [
                        Text(
                          "Review (${product.rating.toString()})",
                          style: AppTheme.lightTheme.textTheme.bodySmall,
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.star, color: Colors.amber),
                        const Spacer(),
                        GestureDetector(
                          onTap: onAddToCart,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
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
