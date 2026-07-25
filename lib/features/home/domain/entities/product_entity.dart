class ProductEntity {
  final int id;
  final String title;
  final double price;
  final double rating;
  final String thumbnail;

  // Todo(Aya): but default values at appStrings
  const ProductEntity({
    this.id = 0,
    this.title = "Not Found",
    this.price = 0,
    this.rating = 0,
    this.thumbnail = "",
  });
}