import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/model/item/product_item_entity.dart';
import 'package:shopping_app/core/network/result_api.dart';
import '../../domain/repo/category_data_source_interface.dart';
import '../../domain/repo/category_repo_interface.dart';

@Injectable(as: CategoryRepoInterface)
class CategoryRepoImp implements CategoryRepoInterface {
  final CategoryDataSourceInterface dataSource;

  CategoryRepoImp(this.dataSource);

  @override
  Future<ResultApi<List<ProductItemEntity>>> getProductsByCategory(
    String categoryName, {
    int skip = 0,
    int limit = 5,
  }) async {
    try {
      final dtos = await dataSource.getProductsByCategory(
        categoryName,
        skip: skip,
        limit: limit,
      );
      final entities = dtos.map((dto) => dto.toEntity()).toList();
      return Success(entities);
    } catch (e) {
      return Error(e.toString());
    }
  }
}
