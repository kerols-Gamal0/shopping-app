import 'package:shopping_app/features/home/domain/entities/category_entity.dart';

class CategoriesModel {
  List<Categories>? list;

  CategoriesModel({this.list});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <Categories>[];
      json['list'].forEach((v) {
        list!.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slug'] = this.slug;
    data['name'] = this.name;
    data['url'] = this.url;
    data['image'] = this.image;
    return data;
  }

  CategoryEntity toEntity() {
    return CategoryEntity(
      name: name ?? "Not Found",
      slug: slug ?? "",
    );
  }
}