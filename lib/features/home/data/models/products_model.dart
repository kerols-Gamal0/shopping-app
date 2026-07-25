import 'package:shopping_app/features/home/domain/entities/product_entity.dart';

class ProductsModel {
  List<Products>? list;
  int? total;
  int? skip;
  int? limit;

  ProductsModel({this.list, this.total, this.skip, this.limit});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <Products>[];
      json['list'].forEach((v) {
        list!.add(new Products.fromJson(v));
      });
    }
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['skip'] = this.skip;
    data['limit'] = this.limit;
    return data;
  }
}

class Products {
  int? id;
  String? title;
  String? category;
  double? price;
  double? discountPercentage;
  double? rating;
  int? stock;
  String? thumbnail;

  Products({
    this.id,
    this.title,
    this.category,
    this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.thumbnail,
  });

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    category = json['category'];
    price = (json['price'] as num?)?.toDouble();
    discountPercentage = (json['discountPercentage'] as num?)?.toDouble();
    rating = (json['rating'] as num?)?.toDouble();
    stock = json['stock'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['category'] = this.category;
    data['price'] = this.price;
    data['discountPercentage'] = this.discountPercentage;
    data['rating'] = this.rating;
    data['stock'] = this.stock;
    data['thumbnail'] = this.thumbnail;
    return data;
  }

  ProductEntity toEntity() {
    return ProductEntity(
      id: id ?? 0,
      title: title ?? "Not Found",
      price: price ?? 0,
      rating: rating ?? 0,
      thumbnail: thumbnail ?? "",
    );
  }
}