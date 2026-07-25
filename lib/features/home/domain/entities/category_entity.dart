class CategoryEntity {
  final String name;
  final String slug;

  // Todo(Aya): but default values at appStrings
  const CategoryEntity({
    this.name = "Not Found",
    this.slug = "",
  });
}