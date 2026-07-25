import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/home/data/models/categories_model.dart';
import 'package:shopping_app/features/home/data/models/products_model.dart';

abstract interface class HomeDataSourceInterface {
  Future<ResultApi<CategoriesModel>> getCategories();
  Future<ResultApi<ProductsModel>> getProducts({required int page});
}