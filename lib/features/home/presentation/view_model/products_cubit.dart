import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/common/pagination/paginated_cubit.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/home/domain/entities/product_entity.dart';
import 'package:shopping_app/features/home/domain/use_case/get_products_usecase.dart';


@injectable
class ProductsCubit extends PaginatedCubit<ProductEntity> {
  final GetProductsUseCase _getProductsUseCase;
  ProductsCubit(this._getProductsUseCase) : super(pageSize: 20);

  @override
  Future<ResultApi<List<ProductEntity>>> fetchPage(int page) {
    return _getProductsUseCase.invoke(page: page);
    // Todo(Aya): where emit states .... use-switch (result) {}
  }
}