import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/theme/app_colors.dart';

class CategoriesShimmerWidget extends StatelessWidget {
  const CategoriesShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,// Todo(Aya): hard spacing
      child: Shimmer.fromColors(
        baseColor: AppColors.disabled,
        highlightColor: AppColors.divider,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: AppSpacing.horizontalX2,
          itemCount: 4,
          separatorBuilder: (context, index) => horizontalSpace(AppSpacing.x1),
          itemBuilder: (context, index) {
            return Container(
              width: 90,
              decoration: BoxDecoration(// Todo(Aya): Add decoration as var at AppStyle
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