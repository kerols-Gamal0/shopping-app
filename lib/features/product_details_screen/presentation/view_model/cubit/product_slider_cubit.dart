import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_slider_state.dart';

class ProductSliderCubit extends Cubit<ProductSliderState> {
  ProductSliderCubit() : super(const ProductSliderState());

  void intent(ProductSliderIntent intent) {
    switch (intent) {
      case ProductSliderChangeFavorite():
        emit(state.copyWith(isFavorite: intent.isFavorite));

      case ProductSliderChangePage():
        emit(state.copyWith(currentIndex: intent.index));
    }
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
