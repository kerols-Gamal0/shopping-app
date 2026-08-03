import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/common/favourite/favourite_status_service.dart';
import 'package:shopping_app/core/network/result_api.dart';

part 'product_slider_state.dart';

@injectable
class ProductSliderCubit extends Cubit<ProductSliderState> {
  final FavouriteStatusService _favouriteStatusService;

  ProductSliderCubit(this._favouriteStatusService) : super(const ProductSliderState());

  void intent(ProductSliderIntent intent) {
    switch (intent) {
      case ProductSliderChangeFavorite():
        emit(state.copyWith(isFavorite: intent.isFavorite));

      case ProductSliderChangePage():
        emit(state.copyWith(currentIndex: intent.index));
    }
  }

  /// يضبط حالة القلب من الـ FavouriteStatusService فعليًا بدل القيمة الافتراضية false
  void syncFavoriteStatus(int productId) {
    emit(state.copyWith(isFavorite: _favouriteStatusService.isFavourite(productId)));
  }

  /// يستدعي الـ API الحقيقي بدل تغيير الأيقونة بس محليًا
  Future<ResultApi<bool>> toggleFavorite(int productId) async {
    final result = await _favouriteStatusService.toggle(productId);
    if (result is Success<bool>) {
      emit(state.copyWith(isFavorite: result.data));
    }
    return result;
  }
}

sealed class ProductSliderIntent extends Equatable {
  const ProductSliderIntent();

  @override
  List<Object?> get props => [];
}

class ProductSliderChangeFavorite extends ProductSliderIntent {
  final bool isFavorite;

  const ProductSliderChangeFavorite(this.isFavorite);

  @override
  List<Object?> get props => [isFavorite];
}

class ProductSliderChangePage extends ProductSliderIntent {
  final int index;

  const ProductSliderChangePage(this.index);

  @override
  List<Object?> get props => [index];
}