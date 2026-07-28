import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/common/model/product_item/product_item_entity.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/features/product_details_screen/presentation/view/widget/product_image_carousel.dart';
import 'package:shopping_app/features/product_details_screen/presentation/view_model/cubit/product_slider_cubit.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  ProductItemEntity productItemEntity = ProductItemEntity(
    id: 4,
    title: "Red Lipstick",
    description:
        "The Red Lipstick is a classic and bold choice for adding a pop of color to your lips. With a creamy and pigmented formula, it provides a vibrant and long-lasting finish.",
    category: "beauty",
    price: 12.99,
    discountPercentage: 12.16,
    rating: 4.36,
    stock: 91,
    tags: ["beauty", "lipstick"],
    brand: "Chic Cosmetics",
    sku: "BEA-CHI-LIP-004",
    weight: 1,
    dimensions: DimensionsEntity(width: 18.11, height: 28.38, depth: 22.17),
    warrantyInformation: "3 year warranty",
    shippingInformation: "Ships in 1 week",
    availabilityStatus: "In Stock",
    reviews: [
      ReviewEntity(
        rating: 4,
        comment: "Great product!",
        date: "2025-04-30T09:41:02.053Z",
        reviewerName: "Liam Garcia",
        reviewerEmail: "liam.garcia@x.dummyjson.com",
      ),
      ReviewEntity(
        rating: 5,
        comment: "Great product!",
        date: "2025-04-30T09:41:02.053Z",
        reviewerName: "Ruby Andrews",
        reviewerEmail: "ruby.andrews@x.dummyjson.com",
      ),
      ReviewEntity(
        rating: 5,
        comment: "Would buy again!",
        date: "2025-04-30T09:41:02.053Z",
        reviewerName: "Clara Berry",
        reviewerEmail: "clara.berry@x.dummyjson.com",
      ),
    ],
    returnPolicy: "7 days return policy",
    minimumOrderQuantity: 40,

    images: [
      "https://cdn.dummyjson.com/product-images/beauty/red-lipstick/1.webp",
      "https://cdn.dummyjson.com/product-images/beauty/red-lipstick/1.webp",
      "https://cdn.dummyjson.com/product-images/beauty/red-lipstick/1.webp",
      "https://cdn.dummyjson.com/product-images/beauty/red-lipstick/1.webp",
      "https://cdn.dummyjson.com/product-images/beauty/red-lipstick/5.webp",
    ],
    thumbnail:
        "https://cdn.dummyjson.com/product-images/beauty/red-lipstick/thumbnail.webp",
  );
  CarouselSliderController carouselcontroller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductSliderCubit(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              BlocBuilder<ProductSliderCubit, ProductSliderState>(
                builder: (context, state) {
                  return ProductImageCarousel(
                    images: productItemEntity.images,
                    controller: carouselcontroller,
                    isFav: () {
                      context.read<ProductSliderCubit>().intent(
                        ProductSliderChangeFavorite(!state.isFavorite),
                      );
                      //Todo: call api service
                    },
                    icon: state.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: state.isFavorite
                        ? AppColors.primary
                        : AppColors.bodyLight,
                    index: state.currentIndex,
                    nextSlide: () {
                      carouselcontroller.nextPage();
                    },
                    prevSlide: () {
                      carouselcontroller.previousPage();
                    },
                    onPageChanged: (index, _) {
                      context.read<ProductSliderCubit>().intent(
                        ProductSliderChangePage(index),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
