sealed class CategoryIntent {
  const CategoryIntent();
}

class FetchCategoryProductsIntent extends CategoryIntent {
  final String categoryName;
  final bool isLoadMore;

  const FetchCategoryProductsIntent({
    required this.categoryName,
    this.isLoadMore = false,
  });
}
