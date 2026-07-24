import 'package:flutter/material.dart';
import 'package:shopping_app/core/common/widgets/product_card.dart';
import 'package:shopping_app/core/model/item/product_item_entity.dart';

class HomeScreen extends StatelessWidget {
  final List<ProductItemEntity> products = [
    ProductItemEntity(
      id: 1,
      title: "Nike Air Max",
      thumbnail: "assets/images/dummy_product.png",
      price: 120,
      discountPercentage: 20,
      description: "A great shoe for everyday wear. Comfortable and stylish.",
    ),
    ProductItemEntity(
      id: 2,
      title: "Adidas Shoes",
      thumbnail: "assets/images/dummy_product.png",
      price: 90,
      discountPercentage: 15,
      isFavorite: true,
      description:
          "Adidas Shoes are a type of footwear designed specifically for running or jogging. They provide cushioning, support, and stability to help runners perform their best and reduce the risk of injury.",
    ),
    ProductItemEntity(
      id: 3,
      title: "Puma Sneakers",
      thumbnail: "assets/images/dummy_product.png",
      price: 70,
      description:
          "Puma Sneakers are a type of footwear designed specifically for running or jogging. They provide cushioning, support, and stability to help runners perform their best and reduce the risk of injury.",
    ),
    ProductItemEntity(
      id: 4,
      title: "Running Shoes",
      thumbnail: "assets/images/dummy_product.png",
      price: 150,
      discountPercentage: 10,
      description:
          "Running Shoes are a type of footwear designed specifically for running or jogging. They provide cushioning, support, and stability to help runners perform their best and reduce the risk of injury.",
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
                  childAspectRatio: 0.45,
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
