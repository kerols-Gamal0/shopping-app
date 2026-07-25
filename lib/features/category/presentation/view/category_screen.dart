import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/common/base_state/base_state.dart';
import 'package:shopping_app/core/common/base_state/base_state_builder.dart';
import 'package:shopping_app/core/common/widgets/product_card.dart';
import 'package:shopping_app/core/model/item/product_item_entity.dart';
import '../view_model/category_cubit/category_cubit.dart';
import '../view_model/category_cubit/category_intent.dart';

class CategoryScreen extends StatefulWidget {
  final String categoryName;

  const CategoryScreen({super.key, required this.categoryName});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName.toUpperCase()),
        centerTitle: true,
      ),
      body: BlocBuilder<CategoryCubit, BaseState<List<ProductItemEntity>>>(
        builder: (context, state) {
          final cubit = context.read<CategoryCubit>();

          return BaseStateBuilder<List<ProductItemEntity>>(
            state: state,
            onSuccess: (products) {
              if (products.isEmpty) {
                return const Center(child: Text('لا توجد منتجات'));
              }

              return NotificationListener<ScrollNotification>(
                onNotification: (scrollInfo) {
                  if (scrollInfo.metrics.pixels >=
                      scrollInfo.metrics.maxScrollExtent - 150) {
                    if (!cubit.isLoadingMore) {
                      cubit.processIntent(
                        FetchCategoryProductsIntent(
                          categoryName: widget.categoryName,
                          isLoadMore: true,
                        ),
                      );
                    }
                  }
                  return false;
                },
                child: Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.48,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                            ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          return ProductCard(product: products[index]);
                        },
                      ),
                    ),
                    if (cubit.isLoadingMore)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        child: CircularProgressIndicator(),
                      ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
