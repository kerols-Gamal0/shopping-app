import 'package:shopping_app/core/model/item/product_item_dto.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/home/data/models/categories_model.dart';

abstract interface class HomeDataSourceInterface {
  Future<ResultApi<CategoriesModel>> getCategories();

  Future<ResultApi<List<ProductItemDto>>> getProducts({
    required int page,
  });
}