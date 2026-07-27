import 'package:shopping_app/core/model/item/product_item_dto.dart';

abstract interface class CategoryDataSourceInterface {
  Future<List<ProductItemDto>> getProductsByCategory(
    String categoryName, {
    int skip = 0,
    int limit = 5,
  });
}
