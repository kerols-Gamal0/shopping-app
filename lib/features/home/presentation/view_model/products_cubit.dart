import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/common/model/product_item/product_item_entity.dart';
import 'package:shopping_app/core/common/pagination/paginated_cubit.dart';
import 'package:shopping_app/core/network/api_constants.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/home/domain/use_case/get_products_usecase.dart';

part 'products_intent.dart';

@injectable
class ProductsCubit extends PaginatedCubit<ProductItemEntity> {
  ProductsCubit(this._getProductsUseCase)
    : super(pageSize: ApiConstants.pageLimit);

  final GetProductsUseCase _getProductsUseCase;

  // Future<void> intent(ProductsIntent intent) async {
  //   switch (intent) {
  //     case FetchProducts():
  //       _fetchPage();

  //     // case FetchNextProducts():
  //     //   fetchNextPage();
  //   }
  // }

  @override
  Future<ResultApi<List<ProductItemEntity>>> fetchPage(int page) {
    return _getProductsUseCase.invoke(page: page);
  }
}
