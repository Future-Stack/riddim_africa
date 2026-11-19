import 'product_variant_model.dart';

enum ArtistProductStatus {
  live,
  pending,
  rejected,
  cancelled,
}

class ArtistProductModel {
  final String id;
  final String name;
  final String code; // e.g. "PRD-2024-00182"
  final String category;
  final String submittedDate;
  final ArtistProductStatus status;
  final double price;
  final String imageUrl;
  final List<String> additionalImages;
  final String? description;
  final String? material;
  final String? origin;
  final bool isDigital;
  final String? dimension;
  final int stockQuantity;
  final String? licenseType; // "One-Time Purchase" | "Limited Edition"
  final String? processingTime;
  final String? weightKg;
  final int totalOrders;
  final double totalRevenue;
  final String monthlyEarningsGrowth;
  final double rating;
  final int reviewsCount;
  final Map<int, int> ratingDistribution; // 5 -> 40, 4 -> 10, etc.
  final String? rejectionReason;
  final String? rejectedAt;
  final List<ColorVariantModel> colorVariants;

  const ArtistProductModel({
    required this.id,
    required this.name,
    required this.code,
    required this.category,
    required this.submittedDate,
    required this.status,
    required this.price,
    required this.imageUrl,
    this.additionalImages = const [],
    this.description,
    this.material,
    this.origin,
    this.isDigital = false,
    this.dimension,
    this.stockQuantity = 0,
    this.licenseType,
    this.processingTime,
    this.weightKg,
    this.totalOrders = 0,
    this.totalRevenue = 0.0,
    this.monthlyEarningsGrowth = '+31%',
    this.rating = 0.0,
    this.reviewsCount = 0,
    this.ratingDistribution = const {5: 45, 4: 8, 3: 3, 2: 1, 1: 0},
    this.rejectionReason,
    this.rejectedAt,
    this.colorVariants = const [],
  });

  String get formattedPrice =>
      'UGX ${price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';

  String get statusDisplay {
    switch (status) {
      case ArtistProductStatus.live:
        return 'Live';
      case ArtistProductStatus.pending:
        return 'Pending';
      case ArtistProductStatus.rejected:
        return 'Rejected';
      case ArtistProductStatus.cancelled:
        return 'Cancelled';
    }
  }
}
