import '../../domain/entities/cart_entity.dart';

class CartModel {
  final int id;
  final String title;
  final String thumbnail;
  final double price;

  const CartModel({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.price,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
    );
  }

  CartEntity toEntity({int quantity = 1}) {
    return CartEntity(
      id: id,
      title: title,
      thumbnail: thumbnail,
      price: price,
      quantity: quantity,
    );
  }
}
