import 'package:flutter/material.dart';
import 'package:shopping_app/core/common/widgets/product_card.dart';
import 'package:shopping_app/core/model/item/product_item_entity.dart';
import 'package:shopping_app/core/theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  final List<ProductItemEntity> products = [
    ProductItemEntity(
      id: 1,
      title: "Nike Air Max",
      image: "assets/images/dummy_product.png",
      price: 120,
      discount: 20,
    ),
    ProductItemEntity(
      id: 2,
      title: "Adidas Shoes",
      image: "assets/images/dummy_product.png",
      price: 90,
      discount: 15,
      isFavorite: true,
    ),
    ProductItemEntity(
      id: 3,
      title: "Puma Sneakers",
      image: "assets/images/dummy_product.png",
      price: 70,
    ),
    ProductItemEntity(
      id: 4,
      title: "Running Shoes",
      image: "assets/images/dummy_product.png",
      price: 150,
      discount: 10,
    ),
  ];
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text("data"),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,

                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.50,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    product: products[index],
                    onAddToCart: () {},
                    onFavorite: () {},
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
