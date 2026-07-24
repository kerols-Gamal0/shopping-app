class ProductItemEntity {
  final int id;
  final String title;
  final String image;
  final double price;
  final double discount;
  final bool isFavorite;
  final double rating;

  const ProductItemEntity({
    this.id = 0,
    this.title = "",
    this.image = "assets/images/dummy_product.png",
    this.price = 0.0,
    this.discount = 0.0,
    this.isFavorite = false,
    this.rating = 0.0,
  });
}
