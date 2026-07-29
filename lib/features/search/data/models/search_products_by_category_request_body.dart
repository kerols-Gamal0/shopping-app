class SearchProductsByCategoryRequestBody {
  const SearchProductsByCategoryRequestBody({
    this.search = '',
    this.skip = 0,
    this.limit = 10,
  });

  final String search;
  final int skip;
  final int limit;

  Map<String, dynamic> toJson() {
    return {
      'search': search,
      'skip': skip,
      'limit': limit,
    };
  }

  SearchProductsByCategoryRequestBody copyWith({
    String? search,
    int? skip,
    int? limit,
  }) {
    return SearchProductsByCategoryRequestBody(
      search: search ?? this.search,
      skip: skip ?? this.skip,
      limit: limit ?? this.limit,
    );
  }
}
// class SearchProductsByCategoryRequestBody {
//   const SearchProductsByCategoryRequestBody({
//     this.skip = 0,
//     this.search = '',
//     this.brand = '',
//     this.category = '',
//     this.rating = '',
//     this.price = '',
//     this.discount = '',
//     this.popular = false,
//     this.limit = 10,
//   });

//   final int skip;
//   final String search;
//   final String brand;
//   final String category;
//   final String rating;
//   final String price;
//   final String discount;
//   final bool popular;
//   final int limit;

//   Map<String, dynamic> toJson() {
//     return {
//       'skip': skip,
//       'search': search,
//       'brand': brand,
//       'category': category,
//       'rating': rating,
//       'price': price,
//       'discount': discount,
//       'popular': popular,
//       'limit': limit,
//     };
//   }

//   SearchProductsByCategoryRequestBody copyWith({
//     int? skip,
//     String? search,
//     String? brand,
//     String? category,
//     String? rating,
//     String? price,
//     String? discount,
//     bool? popular,
//     int? limit,
//   }) {
//     return SearchProductsByCategoryRequestBody(
//       skip: skip ?? this.skip,
//       search: search ?? this.search,
//       brand: brand ?? this.brand,
//       category: category ?? this.category,
//       rating: rating ?? this.rating,
//       price: price ?? this.price,
//       discount: discount ?? this.discount,
//       popular: popular ?? this.popular,
//       limit: limit ?? this.limit,
//     );
//   }
// }