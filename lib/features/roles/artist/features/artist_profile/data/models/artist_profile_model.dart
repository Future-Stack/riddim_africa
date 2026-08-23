import '../../domain/entities/artist_profile_entity.dart';

class ArtistProfileModel extends ArtistProfileEntity {
  const ArtistProfileModel({
    required super.id,
    required super.fullName,
    required super.stageName,
    required super.email,
    required super.phoneNumber,
    required super.country,
    required super.cityName,
    required super.stateName,
    required super.avatarUrl,
    required super.isVerified,
    required super.productsCount,
    required super.soldCount,
    required super.followersCount,
    required super.rating,
  });

  factory ArtistProfileModel.fromJson(Map<String, dynamic> json) {
    return ArtistProfileModel(
      id: json['id'] as String? ?? 'art_12345',
      fullName: json['full_name'] as String? ?? 'Elishin Nakato',
      stageName: json['stage_name'] as String? ?? 'Nakato Beats',
      email: json['email'] as String? ?? 'aisha.nakato@gmail.com',
      phoneNumber: json['phone_number'] as String? ?? '+256 700 123 456',
      country: json['country'] as String? ?? 'Uganda',
      cityName: json['city_name'] as String? ?? 'Kampala',
      stateName: json['state_name'] as String? ?? 'Central Region',
      avatarUrl: json['avatar_url'] as String? ??
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=500',
      isVerified: json['is_verified'] as bool? ?? true,
      productsCount: json['products_count'] as String? ?? '1.2 k',
      soldCount: json['sold_count'] as String? ?? '80',
      followersCount: json['followers_count'] as String? ?? '1.2 k',
      rating: json['rating'] as String? ?? '4.8',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'stage_name': stageName,
      'email': email,
      'phone_number': phoneNumber,
      'country': country,
      'city_name': cityName,
      'state_name': stateName,
      'avatar_url': avatarUrl,
      'is_verified': isVerified,
      'products_count': productsCount,
      'sold_count': soldCount,
      'followers_count': followersCount,
      'rating': rating,
    };
  }

  factory ArtistProfileModel.fromEntity(ArtistProfileEntity entity) {
    return ArtistProfileModel(
      id: entity.id,
      fullName: entity.fullName,
      stageName: entity.stageName,
      email: entity.email,
      phoneNumber: entity.phoneNumber,
      country: entity.country,
      cityName: entity.cityName,
      stateName: entity.stateName,
      avatarUrl: entity.avatarUrl,
      isVerified: entity.isVerified,
      productsCount: entity.productsCount,
      soldCount: entity.soldCount,
      followersCount: entity.followersCount,
      rating: entity.rating,
    );
  }
}
