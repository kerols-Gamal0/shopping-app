import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/home/data/models/categories_model.dart';
import 'package:shopping_app/features/home/data/models/products_model.dart';
import 'package:shopping_app/features/home/domain/entities/category_entity.dart';
import 'package:shopping_app/features/home/domain/entities/product_entity.dart';
import 'package:shopping_app/features/home/domain/repo/home_data_source_interface.dart';
import 'package:shopping_app/features/home/domain/repo/home_repo_interface.dart';


@LazySingleton(as: HomeRepoInterface)
class HomeRepoImpl implements HomeRepoInterface {
  final HomeDataSourceInterface _homeDataSourceInterface;
  HomeRepoImpl(this._homeDataSourceInterface);

  @override
  Future<ResultApi<List<CategoryEntity>>> getCategories() async {
    var result = await _homeDataSourceInterface.getCategories();
    switch (result) {
      case Success<CategoriesModel>():
        List<CategoryEntity> categories = [];
        result.data.list?.forEach((category) {
          categories.add(category.toEntity());
        });
        return Success(categories);
      case Error<CategoriesModel>():
        return Error(result.messageError);
    }
  }

  @override
  Future<ResultApi<List<ProductEntity>>> getProducts({required int page}) async {
    var result = await _homeDataSourceInterface.getProducts(page: page);
    switch (result) {
      case Success<ProductsModel>():
        List<ProductEntity> products = [];
        result.data.list?.forEach((product) {
          products.add(product.toEntity());
        });
        return Success(products);
      case Error<ProductsModel>():
        return Error(result.messageError);
    }
  }
}