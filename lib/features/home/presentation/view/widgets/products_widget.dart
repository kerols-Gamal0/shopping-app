import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/common/widgets/product_card.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/common/model/product_item/product_item_entity.dart';
import 'package:shopping_app/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:shopping_app/features/cart/presentation/view_model/cart_intent.dart';

class ProductsWidget extends StatelessWidget {
  final List<ProductItemEntity> products;

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
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: AppSpacing.x2,
        crossAxisSpacing: AppSpacing.x2,
        childAspectRatio: 0.52,
      ),
      itemBuilder: (_, index) {
        return ProductCard(
          product: products[index],
          onAddToCart: () {
            context.read<CartCubit>().doIntent(
              AddToCartEvent(productId: products[index].id.toString()),
            );

            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Added to cart successfully"),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 3),
              ),
            );
          },
          onFavorite: () {},
        );
      },
    );
  }
}
