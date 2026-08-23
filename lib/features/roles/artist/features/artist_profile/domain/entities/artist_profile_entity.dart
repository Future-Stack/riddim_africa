class ArtistProfileEntity {
  final String id;
  final String fullName;
  final String stageName;
  final String email;
  final String phoneNumber;
  final String country;
  final String cityName;
  final String stateName;
  final String avatarUrl;
  final bool isVerified;
  final String productsCount;
  final String soldCount;
  final String followersCount;
  final String rating;

  const ArtistProfileEntity({
    required this.id,
    required this.fullName,
    required this.stageName,
    required this.email,
    required this.phoneNumber,
    required this.country,
    required this.cityName,
    required this.stateName,
    required this.avatarUrl,
    required this.isVerified,
    required this.productsCount,
    required this.soldCount,
    required this.followersCount,
    required this.rating,
  });

  ArtistProfileEntity copyWith({
    String? id,
    String? fullName,
    String? stageName,
    String? email,
    String? phoneNumber,
    String? country,
    String? cityName,
    String? stateName,
    String? avatarUrl,
    bool? isVerified,
    String? productsCount,
    String? soldCount,
    String? followersCount,
    String? rating,
  }) {
    return ArtistProfileEntity(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      stageName: stageName ?? this.stageName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      country: country ?? this.country,
      cityName: cityName ?? this.cityName,
      stateName: stateName ?? this.stateName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isVerified: isVerified ?? this.isVerified,
      productsCount: productsCount ?? this.productsCount,
      soldCount: soldCount ?? this.soldCount,
      followersCount: followersCount ?? this.followersCount,
      rating: rating ?? this.rating,
    );
  }
}
