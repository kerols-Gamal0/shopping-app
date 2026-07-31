part of 'category_cubit.dart';

@immutable
class CategoryState extends Equatable {
  final BaseState<List<ProductItemEntity>> categoryState;
  final int skip;
  final int limit;
  final bool hasMore;
  final bool isLoadingMore;
  final String? paginationError;
  final List<ProductItemEntity> allProducts;

  const CategoryState({
    this.categoryState = const BaseLoadingState(),
    this.skip = 0,
    this.limit = 6,
    this.hasMore = true,
    this.isLoadingMore = false,
    this.paginationError,
    this.allProducts = const [],
  });

  CategoryState copyWith({
    BaseState<List<ProductItemEntity>>? categoryState,
    int? skip,
    int? limit,
    bool? hasMore,
    bool? isLoadingMore,
    String? paginationError,
    bool clearError = false,
    List<ProductItemEntity>? allProducts,
  }) {
    return CategoryState(
      categoryState: categoryState ?? this.categoryState,
      skip: skip ?? this.skip,
      limit: limit ?? this.limit,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      paginationError: clearError
          ? null
          : (paginationError ?? this.paginationError),
      allProducts: allProducts ?? this.allProducts,
    );
  }

  @override
  List<Object?> get props => [
    categoryState,
    skip,
    limit,
    hasMore,
    isLoadingMore,
    paginationError,
    allProducts,
  ];
}
