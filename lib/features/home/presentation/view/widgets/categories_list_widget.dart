import 'package:flutter/material.dart';
import 'package:shopping_app/features/home/domain/entities/category_entity.dart';

class CategoriesWidget extends StatelessWidget {
  final List<CategoryEntity> categories;
  final void Function(String name, String slug) onCategoryTap;

  const CategoriesWidget({
    super.key,
    required this.categories,
    required this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return OutlinedButton(
            style: OutlinedButton.styleFrom(
              minimumSize: Size.zero,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            onPressed: () => onCategoryTap(
              categories[index].name,
              categories[index].slug,
            ),
            child: Text(categories[index].name),
          );
        },
      ),
    );
  }
}