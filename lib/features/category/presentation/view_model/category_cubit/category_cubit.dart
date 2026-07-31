import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/common/base_state/base_state.dart';
import 'package:shopping_app/core/common/model/product_item/product_item_entity.dart';
import 'package:shopping_app/core/network/result_api.dart';
import '../../../domain/usecase/get_category_products_use_case.dart';
import 'category_intent.dart';

part 'category_state.dart';

@injectable
class CategoryCubit extends Cubit<CategoryState> {
  final GetCategoryProductsUseCase getCategoryProductsUseCase;

  CategoryCubit(this.getCategoryProductsUseCase) : super(const CategoryState());

  bool get isLoadingMore => state.isLoadingMore;
  bool get hasMore => state.hasMore;

  Future<void> processIntent(CategoryIntent categoryIntent) async {
    switch (categoryIntent) {
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
    emit(
      state.copyWith(
        categoryState: const BaseLoadingState<List<ProductItemEntity>>(),
        skip: 0,
        hasMore: true,
        isLoadingMore: false,
        allProducts: [],
        clearError: true,
      ),
    );

    final result = await getCategoryProductsUseCase.invoke(
      categoryName,
      skip: state.skip,
      limit: state.limit,
    );

    switch (result) {
      case Success(data: final products):
        final newAllProducts = List<ProductItemEntity>.from(products);
        emit(
          state.copyWith(
            allProducts: newAllProducts,
            skip: state.skip + state.limit,
            hasMore: products.length >= state.limit,
            categoryState: BaseSuccessState<List<ProductItemEntity>>(
              data: newAllProducts,
            ),
          ),
        );

      case Error(messageError: final message):
        emit(
          state.copyWith(
            categoryState: BaseFailureState<List<ProductItemEntity>>(
              errorMessage: message,
            ),
          ),
        );
    }
  }

  Future<void> _loadMoreProducts(String categoryName) async {
    if (!state.hasMore ||
        state.isLoadingMore ||
        state.categoryState is BaseLoadingState) {
      return;
    }
    emit(state.copyWith(isLoadingMore: true, clearError: true));

    final result = await getCategoryProductsUseCase.invoke(
      categoryName,
      skip: state.skip,
      limit: state.limit,
    );

    switch (result) {
      case Success(data: final products):
        if (products.isEmpty) {
          emit(state.copyWith(hasMore: false, isLoadingMore: false));
        } else {
          final newAllProducts = List<ProductItemEntity>.from(state.allProducts)
            ..addAll(products);
          emit(
            state.copyWith(
              allProducts: newAllProducts,
              skip: state.skip + state.limit,
              hasMore: products.length >= state.limit,
              isLoadingMore: false,
              categoryState: BaseSuccessState<List<ProductItemEntity>>(
                data: newAllProducts,
              ),
            ),
          );
        }

      case Error(messageError: final message):
        emit(state.copyWith(isLoadingMore: false, paginationError: message));
    }
  }
}
