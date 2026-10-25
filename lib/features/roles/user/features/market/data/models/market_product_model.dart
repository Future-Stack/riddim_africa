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
    super.productCode,
    super.stockQuantity = 0,
    super.isWishlisted = false,
    super.collectionTitle,
    super.rawPrice,
    super.relatedProducts = const [],
  });

  static String formatPrice(dynamic raw) {
    if (raw == null) return 'UGX 0';
    if (raw is String && raw.startsWith('UGX')) return raw;
    final num? val = raw is num
        ? raw
        : num.tryParse(raw.toString().replaceAll(RegExp(r'[^0-9.]'), ''));
    if (val == null) return raw.toString();
    final int intVal = val.toInt();
    final formatted = intVal.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
    return 'UGX $formatted';
  }

  factory MarketProductModel.fromJson(Map<String, dynamic> json) {
    // 1. ID
    final id = (json['productId'] ?? json['id'] ?? '').toString();

    // 2. Title / Name
    final title = (json['name'] ?? json['title'] ?? '').toString();

    // 3. Images
    List<String> images = [];
    if (json['files'] is List && (json['files'] as List).isNotEmpty) {
      images = (json['files'] as List).map((e) => e.toString()).toList();
    } else if (json['galleryImages'] is List &&
        (json['galleryImages'] as List).isNotEmpty) {
      images = (json['galleryImages'] as List).map((e) => e.toString()).toList();
    }
    final String imageUrl = images.isNotEmpty
        ? images.first
        : (json['imageUrl'] as String? ?? '');

    // 4. Price
    final num? rawPrice = json['sellingPrice'] is num
        ? json['sellingPrice'] as num
        : (json['price'] is num ? json['price'] as num : null);
    final String price = json['sellingPrice'] != null
        ? formatPrice(json['sellingPrice'])
        : (json['price'] != null
            ? formatPrice(json['price'])
            : 'UGX 0');

    // 5. Category & Collection
    String category = '';
    if (json['category'] is Map<String, dynamic>) {
      category = (json['category']['title'] ?? '').toString();
    } else if (json['category'] != null) {
      category = json['category'].toString();
    }

    String? collectionTitle;
    if (json['collection'] is Map<String, dynamic>) {
      collectionTitle = json['collection']['title'] as String?;
    } else if (json['collection'] != null) {
      collectionTitle = json['collection'].toString();
    }

    // 6. Seller / Artist
    String sellerName = '';
    String sellerAvatarUrl = '';
    bool isVerifiedSeller = false;
    double sellerRating = 0.0;
    int sellerSales = 0;

    if (json['artist'] is Map<String, dynamic>) {
      final a = json['artist'] as Map<String, dynamic>;
      sellerName =
          (a['stageName'] ?? a['fullName'] ?? '').toString();
      sellerAvatarUrl = (a['profileImage'] ?? '').toString();
      isVerifiedSeller = a['isVerified'] as bool? ?? false;
      sellerRating = (a['rating'] as num?)?.toDouble() ?? 0.0;
      sellerSales = (a['sales'] as num?)?.toInt() ?? 0;
    } else if (json['seller'] is Map<String, dynamic>) {
      final s = json['seller'] as Map<String, dynamic>;
      sellerName =
          (s['storeName'] ?? s['fullName'] ?? '').toString();
      sellerAvatarUrl = (s['profileImage'] ?? '').toString();
      isVerifiedSeller = s['isVerified'] as bool? ?? false;
      if (s['stats'] is Map<String, dynamic>) {
        final stats = s['stats'] as Map<String, dynamic>;
        sellerRating = (stats['rating'] as num?)?.toDouble() ?? 0.0;
        sellerSales = (stats['totalSales'] as num?)?.toInt() ?? 0;
      } else {
        sellerRating = (s['rating'] as num?)?.toDouble() ?? 0.0;
        sellerSales = (s['sales'] as num?)?.toInt() ?? 0;
      }
    } else {
      sellerName = (json['sellerName'] ?? '').toString();
      sellerAvatarUrl = (json['sellerAvatarUrl'] ?? '').toString();
      isVerifiedSeller = json['isVerifiedSeller'] as bool? ?? false;
      sellerRating = (json['sellerRating'] as num?)?.toDouble() ?? 0.0;
      sellerSales = (json['sellerSales'] as num?)?.toInt() ?? 0;
    }

    // 7. Rating
    double rating = 0.0;
    int reviewCount = 0;
    if (json['ratingInfo'] is Map<String, dynamic>) {
      final rInfo = json['ratingInfo'] as Map<String, dynamic>;
      rating = (rInfo['average'] as num?)?.toDouble() ?? 0.0;
      reviewCount = (rInfo['count'] as num?)?.toInt() ?? 0;
    } else if (json['rating'] is Map<String, dynamic>) {
      final r = json['rating'] as Map<String, dynamic>;
      rating = (r['average'] as num?)?.toDouble() ?? 0.0;
      reviewCount = (r['count'] as num?)?.toInt() ?? 0;
    } else if (json['rating'] is num) {
      rating = (json['rating'] as num).toDouble();
      reviewCount = (json['reviewCount'] as num?)?.toInt() ?? 0;
    }

    // 8. Stock & Status
    final int stockQuantity = (json['stockQuantity'] as num?)?.toInt() ?? 0;
    final bool inStock =
        json['inStock'] as bool? ?? (stockQuantity > 0);

    // 9. Related Products
    List<MarketProductEntity> relatedList = const [];
    if (json['relatedProducts'] is List) {
      relatedList = (json['relatedProducts'] as List)
          .whereType<Map<String, dynamic>>()
          .map((e) => MarketProductModel.fromJson(e))
          .toList();
    }

    return MarketProductModel(
      id: id,
      imageUrl: imageUrl,
      galleryImages: images,
      title: title,
      sellerName: sellerName,
      sellerAvatarUrl: sellerAvatarUrl,
      isVerifiedSeller: isVerifiedSeller,
      sellerRating: sellerRating,
      sellerSales: sellerSales,
      rating: rating,
      reviewCount: reviewCount,
      category: category,
      price: price,
      inStock: inStock,
      description: json['description'] as String?,
      availableColors: (json['availableColors'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      availableSizes: (json['availableSizes'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      productCode: json['productCode'] as String?,
      stockQuantity: stockQuantity,
      isWishlisted: json['isWishlisted'] as bool? ?? false,
      collectionTitle: collectionTitle,
      rawPrice: rawPrice,
      relatedProducts: relatedList,
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
      'productCode': productCode,
      'stockQuantity': stockQuantity,
      'isWishlisted': isWishlisted,
      'collectionTitle': collectionTitle,
      'rawPrice': rawPrice,
    };
  }
}
