import 'package:json_annotation/json_annotation.dart';
import 'package:shopping_app/core/model/item/product_item_entity.dart';

part 'product_item_dto.g.dart';

@JsonSerializable()
class ProductItemDto {
  final int? id;
  final String? title;
  final String? description;
  final String? category;
  final double? price;
  final double? discountPercentage;
  final double? rating;
  final int? stock;
  final List<String>? tags;
  final String? brand;
  final String? sku;
  final int? weight;
  DimensionsDto? dimensions;
  final String? warrantyInformation;
  final String? shippingInformation;
  final String? availabilityStatus;
  final List<ReviewDto>? reviews;
  final String? returnPolicy;
  final int? minimumOrderQuantity;
  final List<String>? images;
  final String? thumbnail;

  ProductItemDto({
    this.id,
    this.title,
    this.description,
    this.category,
    this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.tags,
    this.brand,
    this.sku,
    this.weight,
    this.dimensions,
    this.warrantyInformation,
    this.shippingInformation,
    this.availabilityStatus,
    this.reviews,
    this.returnPolicy,
    this.minimumOrderQuantity,
    this.images,
    this.thumbnail,
  });

  factory ProductItemDto.fromJson(Map<String, dynamic> json) =>
      _$ProductItemDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductItemDtoToJson(this);
  ProductItemEntity toEntity() => ProductItemEntity(
    id: id ?? -1,
    title: title ?? '',
    description: description ?? '',
    category: category ?? '',
    price: price ?? 0,
    discountPercentage: discountPercentage ?? 0,
    rating: rating ?? 0,
    stock: stock ?? 0,
    tags: tags ?? [],
    brand: brand ?? '',
    sku: sku ?? '',
    weight: weight ?? 0,
    dimensions: dimensions?.toEntity() ?? const DimensionsEntity(),
    warrantyInformation: warrantyInformation ?? '',
    shippingInformation: shippingInformation ?? '',
    availabilityStatus: availabilityStatus ?? '',
    reviews: reviews?.map((e) => e.toEntity()).toList() ?? [],
    returnPolicy: returnPolicy ?? '',
    minimumOrderQuantity: minimumOrderQuantity ?? 0,
    images: images ?? [],
    thumbnail: thumbnail ?? '',
    reviewCount: reviews?.length ?? 0,
  );
}

@JsonSerializable()
class DimensionsDto {
  final double? width;
  final double? height;
  final double? depth;

  DimensionsDto({this.width, this.height, this.depth});

  factory DimensionsDto.fromJson(Map<String, dynamic> json) =>
      _$DimensionsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DimensionsDtoToJson(this);
  DimensionsEntity toEntity() {
    return DimensionsEntity(
      width: width ?? 0,
      height: height ?? 0,
      depth: depth ?? 0,
    );
  }
}

@JsonSerializable()
class ReviewDto {
  final int? rating;
  final String? comment;
  final String? date;
  final String? reviewerName;
  final String? reviewerEmail;

  ReviewDto({
    this.rating,
    this.comment,
    this.date,
    this.reviewerName,
    this.reviewerEmail,
  });

  factory ReviewDto.fromJson(Map<String, dynamic> json) =>
      _$ReviewDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewDtoToJson(this);
  ReviewEntity toEntity() {
    return ReviewEntity(
      rating: rating ?? 0,
      comment: comment ?? '',
      date: date ?? '',
      reviewerName: reviewerName ?? '',
      reviewerEmail: reviewerEmail ?? '',
    );
  }
}
