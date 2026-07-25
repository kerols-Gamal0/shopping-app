import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/theme/app_colors.dart';

class ProductsShimmerWidget extends StatelessWidget {
  const ProductsShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.disabled,
      highlightColor: AppColors.divider,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: AppSpacing.horizontalX2,
        itemCount: 4,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount( // Todo(Aya): Add decoration as var at AppStyle
          crossAxisCount: 2,
          mainAxisSpacing: AppSpacing.x2,
          crossAxisSpacing: AppSpacing.x2,
          childAspectRatio: 0.68,
        ),
        itemBuilder: (context, index) => Container(color: AppColors.surface),
      ),
    );
  }
}
