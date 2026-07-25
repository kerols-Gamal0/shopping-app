import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/common/base_state/base_state.dart';
import 'package:shopping_app/core/model/item/product_item_entity.dart';
import 'package:shopping_app/core/network/result_api.dart';
import '../../../domain/usecase/get_category_products_use_case.dart';
import 'category_intent.dart';

@injectable
class CategoryCubit extends Cubit<BaseState<List<ProductItemEntity>>> {
  final GetCategoryProductsUseCase getCategoryProductsUseCase;

  CategoryCubit(this.getCategoryProductsUseCase)
    : super(const BaseInitialState<List<ProductItemEntity>>());

  int _skip = 0;
  final int _limit = 5;
  bool _hasMore = true;
  bool _isLoadingMore = false;
  bool _isInitialLoading = false;
  final List<ProductItemEntity> _allProducts = [];

  bool get isLoadingMore => _isLoadingMore;

  Future<void> processIntent(CategoryIntent intent) async {
    switch (intent) {
      case FetchCategoryProductsIntent(
        categoryName: final categoryName,
        isLoadMore: final isLoadMore,
      ):
        if (isLoadMore) {
          await _loadMoreProducts(categoryName);
        } else {
          await _fetchInitialProducts(categoryName);
        }
    }
  }

  Future<void> _fetchInitialProducts(String categoryName) async {
    if (_isInitialLoading) return;

    _isInitialLoading = true;
    _skip = 0;
    _hasMore = true;
    _isLoadingMore = false;
    _allProducts.clear();

    emit(const BaseLoadingState<List<ProductItemEntity>>());

    final result = await getCategoryProductsUseCase.invoke(
      categoryName,
      skip: _skip,
      limit: _limit,
    );

    _isInitialLoading = false;

    switch (result) {
      case Success(data: final products):
        _allProducts.addAll(products);
        if (products.length < _limit) _hasMore = false;
        _skip += _limit;
        emit(
          BaseSuccessState<List<ProductItemEntity>>(
            data: List.from(_allProducts),
          ),
        );

      case Error(messageError: final message):
        print('❌ CategoryCubit Error: $message');
        emit(BaseFailureState<List<ProductItemEntity>>(errorMessage: message));
    }
  }

  Future<void> _loadMoreProducts(String categoryName) async {
    if (!_hasMore || _isLoadingMore || _isInitialLoading) return;

    _isLoadingMore = true;

    emit(
      BaseSuccessState<List<ProductItemEntity>>(data: List.from(_allProducts)),
    );

    final result = await getCategoryProductsUseCase.invoke(
      categoryName,
      skip: _skip,
      limit: _limit,
    );

    switch (result) {
      case Success(data: final products):
        if (products.isEmpty) {
          _hasMore = false;
        } else {
          _allProducts.addAll(products);
          _skip += _limit;
          if (products.length < _limit) _hasMore = false;
        }
        _isLoadingMore = false;
        emit(
          BaseSuccessState<List<ProductItemEntity>>(
            data: List.from(_allProducts),
          ),
        );

      case Error(messageError: final message):
        print('❌ Load More Error: $message');
        _isLoadingMore = false;
        _hasMore = false;
        emit(
          BaseSuccessState<List<ProductItemEntity>>(
            data: List.from(_allProducts),
          ),
        );
    }
  }
}
