class ProductEntity {
  final String id;
  final String imageUrl;
  final String title;
  final String subtitle;
  final double rating;
  final String categoryText;
  final String price;
  final bool isHot;
  final String? artistName;
  final String? artistAvatarUrl;
  final bool isVerifiedArtist;

  const ProductEntity({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.rating,
    required this.categoryText,
    required this.price,
    this.isHot = false,
    this.artistName,
    this.artistAvatarUrl,
    this.isVerifiedArtist = false,
  });
}
