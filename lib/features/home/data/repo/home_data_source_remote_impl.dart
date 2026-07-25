import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/api_constants.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/home/data/models/categories_model.dart';
import 'package:shopping_app/features/home/data/models/products_model.dart';
import 'package:shopping_app/features/home/domain/repo/home_data_source_interface.dart';


@LazySingleton(as: HomeDataSourceInterface)
class HomeDataSourceRemoteImpl implements HomeDataSourceInterface {
  final Dio _dio;
  HomeDataSourceRemoteImpl(this._dio);

  @override
  Future<ResultApi<CategoriesModel>> getCategories() async {
    try {
      var response = await _dio.get(
        ApiConstants.baseUrl + ApiConstants.allCategories,
      );
      if (response.statusCode == 200) {
        return Success(CategoriesModel.fromJson(response.data));
      } else {
        return Error("Failed to load categories: Status ${response.statusCode}");
      }
    } on DioException catch (e) {
      return Error(e.message ?? "Failed to load categories");
    } catch (e) {
      return Error(e.toString());
    }
  }

  @override
  Future<ResultApi<ProductsModel>> getProducts({required int page}) async {
    try {
      var response = await _dio.get(
        ApiConstants.baseUrl + ApiConstants.allProducts,
        queryParameters: {
          'limit': ApiConstants.pageLimit,
          'skip': (page - 1) * ApiConstants.pageLimit,
        },
      );
      if (response.statusCode == 200) {
        return Success(ProductsModel.fromJson(response.data));
      } else {
        return Error("Failed to load products: Status ${response.statusCode}");
      }
    } on DioException catch (e) {
      return Error(e.message ?? "Failed to load products");
    } catch (e) {
      return Error(e.toString());
    }
  }
}