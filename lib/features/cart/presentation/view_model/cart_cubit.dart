import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/common/base_state/base_state.dart';
import 'package:shopping_app/core/network/result_api.dart';
import '../../domain/repo/cart_repo_interface.dart';
import 'cart_intent.dart';
import 'cart_state.dart';

@injectable
class CartCubit extends Cubit<CartState> {
  final CartRepoInterface _cartRepo;

  CartCubit(this._cartRepo) : super(const CartState());

  void doIntent(CartIntent intent) {
    switch (intent) {
      case GetCartEvent():
        getCart();
        break;
      case AddToCartEvent():
        addToCart(productId: intent.productId.toString());
        break;
      case DeleteCartItemEvent():
        deleteCartItem(productId: intent.productId.toString());
        break;
      case DeleteAllCartItemEvent():
        deleteAllCartItem(
          productId: intent.productId,
          quantity: intent.quantity,
        );
        break;
    }
  }

  Future<void> getCart() async {
    emit(state.copyWith(cartStatus: const BaseLoadingState()));

    final result = await _cartRepo.getCart();

    switch (result) {
      case Success(data: final data):
        emit(state.copyWith(cartStatus: BaseSuccessState(data: data)));
        break;
      case Error(messageError: final message):
        emit(
          state.copyWith(cartStatus: BaseFailureState(errorMessage: message)),
        );
        break;
    }
  }

  Future<void> addToCart({required String productId}) async {
    await _executeAction(
      action: () => _cartRepo.addToCart(productId: productId),
      onSuccess: () => getCart(),
    );
  }

  Future<void> deleteCartItem({required String productId}) async {
    await _executeAction(
      action: () => _cartRepo.deleteCartItem(productId: productId),
      onSuccess: () => getCart(),
    );
  }

  Future<void> deleteAllCartItem({
    required String productId,
    required int quantity,
  }) async {
    await _executeAction(
      action: () =>
          _cartRepo.deleteAllCartItem(productId: productId, quantity: quantity),
      onSuccess: () => getCart(),
    );
  }

  Future<void> _executeAction({
    required Future<ResultApi<void>> Function() action,
    required VoidCallback onSuccess,
  }) async {
    emit(state.copyWith(isActionLoading: true, clearActionError: true));

    final result = await action();

    emit(state.copyWith(isActionLoading: false));

    switch (result) {
      case Success():
        onSuccess();
        break;
      case Error(messageError: final message):
        emit(state.copyWith(actionError: message));
        break;
    }
  }
}
