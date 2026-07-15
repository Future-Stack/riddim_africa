class MarketProductEntity {
  final String id;
  final String imageUrl;
  final List<String> galleryImages;
  final String title;
  final String sellerName;
  final String sellerAvatarUrl;
  final bool isVerifiedSeller;
  final double sellerRating;
  final int sellerSales;
  final double rating;
  final int reviewCount;
  final String category;
  final String price;
  final bool inStock;
  final String? description;
  final List<String> availableColors;
  final List<String> availableSizes;

  const MarketProductEntity({
    required this.id,
    required this.imageUrl,
    this.galleryImages = const [],
    required this.title,
    required this.sellerName,
    this.sellerAvatarUrl = '',
    this.isVerifiedSeller = false,
    this.sellerRating = 0.0,
    this.sellerSales = 0,
    required this.rating,
    this.reviewCount = 0,
    required this.category,
    required this.price,
    this.inStock = true,
    this.description,
    this.availableColors = const [],
    this.availableSizes = const [],
  });
}
