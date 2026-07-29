sealed class CartIntent {
  const CartIntent();
}

class GetCartEvent extends CartIntent {
  const GetCartEvent();
}

class AddToCartEvent extends CartIntent {
  const AddToCartEvent({required this.productId});
  final String productId;
}

class DeleteCartItemEvent extends CartIntent {
  const DeleteCartItemEvent({required this.productId});
  final String productId;
}

class DeleteAllCartItemEvent extends CartIntent {
  final String productId;
  final int quantity;
  const DeleteAllCartItemEvent({
    required this.productId,
    required this.quantity,
  });
}
