import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/common/pagination/paginated_cubit.dart';
import 'package:shopping_app/core/model/item/product_item_entity.dart';
import 'package:shopping_app/core/network/api_constants.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/home/domain/use_case/get_products_usecase.dart';

@injectable
class ProductsCubit extends PaginatedCubit<ProductItemEntity> {
  final GetProductsUseCase _getProductsUseCase;

  ProductsCubit(this._getProductsUseCase) : super(pageSize: ApiConstants.pageLimit);

  @override
  Future<ResultApi<List<ProductItemEntity>>> fetchPage(int page) {
    print("Fetching page => $page");
    return _getProductsUseCase.invoke(page: page);
  }
}