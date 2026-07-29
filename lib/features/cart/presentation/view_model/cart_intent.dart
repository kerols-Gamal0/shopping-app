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
