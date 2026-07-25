import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
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
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 4,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.68,
        ),
        itemBuilder: (context, index) => Container(color: AppColors.surface),
      ),
    );
  }
}
