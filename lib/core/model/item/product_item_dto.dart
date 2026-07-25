import 'product_item_entity.dart';

class ProductItemDto {
  final int id;
  final String title;
  final String image;
  final double price;
  final double? discount;
  final bool isFavorite;
  final double? rating;

  ProductItemDto({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    this.discount,
    this.isFavorite = false,
    this.rating,
  });

  factory ProductItemDto.fromJson(Map<String, dynamic> json) {
    return ProductItemDto(
      id: json["id"],
      title: json["title"],
      image: json["image"],
      price: (json["price"] as num).toDouble(),
      discount: json["discount"] != null
          ? (json["discount"] as num).toDouble()
          : null,
      isFavorite: json["isFavorite"] ?? false,
    );
  }

  ProductItemEntity toEntity() {
    return ProductItemEntity(
      id: id,
      title: title,
      image: image,
      price: price,
      discount: discount ?? 0.0,
      isFavorite: isFavorite,
    );
  }
}
