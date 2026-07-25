import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopping_app/core/theme/app_colors.dart';

class CategoriesShimmerWidget extends StatelessWidget {
  const CategoriesShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Shimmer.fromColors(
        baseColor: AppColors.disabled,
        highlightColor: AppColors.divider,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: 4,
          separatorBuilder: (context, index) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            return Container(
              width: 90,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
              ),
            );
          },
        ),
      ),
    );
  }
}