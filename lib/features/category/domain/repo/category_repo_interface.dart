import 'package:shopping_app/core/model/item/product_item_entity.dart';
import 'package:shopping_app/core/network/result_api.dart';

abstract interface class CategoryRepoInterface {
  Future<ResultApi<List<ProductItemEntity>>> getProductsByCategory(
    String categoryName, {
    int skip = 0,
    int limit = 5,
  });
}
