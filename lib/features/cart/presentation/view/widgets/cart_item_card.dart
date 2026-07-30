import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_style.dart';

class CartItemCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onDelete;

  const CartItemCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.allX1,
      decoration: AppStyles.customCardBoxDecoration,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.x2),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  Container(color: AppColors.backgroundV2),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          horizontalSpace(AppSpacing.x1),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.heading,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: onDelete,
                      child: Padding(
                        padding: EdgeInsets.all(AppSpacing.x1),
                        child: Icon(
                          Icons.close,
                          size: 18,
                          color: AppColors.bodyLight,
                        ),
                      ),
                    ),
                  ],
                ),
                verticalSpace(AppSpacing.x1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.heading,
                      ),
                    ),

                    Container(
                      padding: AppSpacing.horizontalVerticalX2,
                      decoration: BoxDecoration(
                        color: AppColors.backgroundV2,
                        borderRadius: BorderRadius.circular(AppSpacing.x1),
                      ),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: onDecrement,
                            child: const Icon(
                              Icons.remove,
                              size: 16,
                              color: AppColors.heading,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.x1,
                            ),
                            child: Text(
                              '$quantity',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.heading,
                                  ),
                            ),
                          ),
                          InkWell(
                            onTap: onIncrement,
                            child: const Icon(
                              Icons.add,
                              size: 16,
                              color: AppColors.heading,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
