import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/theme/app_colors.dart';

class ProductsShimmerWidget extends StatelessWidget {
  const ProductsShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: AppSpacing.horizontalX2,
      itemCount: 4,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSpacing.x2,
        mainAxisSpacing: AppSpacing.x2,
        childAspectRatio: .55,
      ),
      itemBuilder: (_, _) {
        return Shimmer.fromColors(
          baseColor: AppColors.disabled,
          highlightColor: AppColors.divider,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding: AppSpacing.allX1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                  verticalSpace(AppSpacing.x1),

                  Container(
                    height: 16,
                    width: double.infinity,
                    color: Colors.white,
                  ),

                  verticalSpace(AppSpacing.x1),

                  Container(
                    height: 12,
                    width: 80,
                    color: Colors.white,
                  ),

                  verticalSpace(AppSpacing.x1),

                  Container(
                    height: 18,
                    width: 100,
                    color: Colors.white,
                  ),

                  verticalSpace(AppSpacing.x1),

                  Container(
                    height: 12,
                    width: double.infinity,
                    color: Colors.white,
                  ),

                  verticalSpace(AppSpacing.x5),

                  Container(
                    height: 12,
                    width: 120,
                    color: Colors.white,
                  ),

                  const Spacer(),

                  Container(
                    height: 38,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}