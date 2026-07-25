import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/features/home/domain/entities/product_entity.dart';
import 'package:shopping_app/features/home/presentation/view/widgets/shared_item_widget.dart';


class ProductsWidget extends StatelessWidget {
  final List<ProductEntity> products;
  const ProductsWidget({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Center(child: Text("No Products Found"));
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: AppSpacing.horizontalX2,
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(// Todo(Aya): Add decoration as var at AppStyle
        crossAxisCount: 2,
        mainAxisSpacing: AppSpacing.x2,
        crossAxisSpacing: AppSpacing.x2,
        childAspectRatio: 0.68,
      ),
      itemBuilder: (context, index) {
        return SharedItemWidget( // Todo(Aya): Pass all model
          image: products[index].thumbnail,
          title: products[index].title,
          price: products[index].price,
          onTap: () {},
        );
      },
    );
  }
}