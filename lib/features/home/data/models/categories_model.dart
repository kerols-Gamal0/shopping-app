import 'package:shopping_app/features/home/domain/entities/category_entity.dart';
// Todo(Aya): Add json_serializable + named class CategoriesDTO
class CategoriesModel {
  List<Categories>? list;

  CategoriesModel({this.list});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <Categories>[];
      json['list'].forEach((v) {
        list!.add(Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  String? slug;
  String? name;
  String? url;
  String? image;

  Categories({this.slug, this.name, this.url, this.image});

  Categories.fromJson(Map<String, dynamic> json) {
    slug = json['slug'];
    name = json['name'];
    url = json['url'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['slug'] = slug;
    data['name'] = name;
    data['url'] = url;
    data['image'] = image;
    return data;
  }

  CategoryEntity toEntity() {
    return CategoryEntity(
      name: name ?? "Not Found",
      slug: slug ?? "",
    );
  }
}