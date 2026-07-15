import '../../domain/entities/market_product_entity.dart';

class MarketProductModel extends MarketProductEntity {
  const MarketProductModel({
    required super.id,
    required super.imageUrl,
    super.galleryImages = const [],
    required super.title,
    required super.sellerName,
    super.sellerAvatarUrl = '',
    super.isVerifiedSeller = false,
    super.sellerRating = 0.0,
    super.sellerSales = 0,
    required super.rating,
    super.reviewCount = 0,
    required super.category,
    required super.price,
    super.inStock = true,
    super.description,
    super.availableColors = const [],
    super.availableSizes = const [],
  });

  factory MarketProductModel.fromJson(Map<String, dynamic> json) {
    return MarketProductModel(
      id: json['id'] as String,
      imageUrl: json['imageUrl'] as String,
      galleryImages: (json['galleryImages'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      title: json['title'] as String,
      sellerName: json['sellerName'] as String,
      sellerAvatarUrl: json['sellerAvatarUrl'] as String? ?? '',
      isVerifiedSeller: json['isVerifiedSeller'] as bool? ?? false,
      sellerRating: (json['sellerRating'] as num?)?.toDouble() ?? 0.0,
      sellerSales: json['sellerSales'] as int? ?? 0,
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'] as int? ?? 0,
      category: json['category'] as String,
      price: json['price'] as String,
      inStock: json['inStock'] as bool? ?? true,
      description: json['description'] as String?,
      availableColors: (json['availableColors'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      availableSizes: (json['availableSizes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'galleryImages': galleryImages,
      'title': title,
      'sellerName': sellerName,
      'sellerAvatarUrl': sellerAvatarUrl,
      'isVerifiedSeller': isVerifiedSeller,
      'sellerRating': sellerRating,
      'sellerSales': sellerSales,
      'rating': rating,
      'reviewCount': reviewCount,
      'category': category,
      'price': price,
      'inStock': inStock,
      'description': description,
      'availableColors': availableColors,
      'availableSizes': availableSizes,
    };
  }
}
