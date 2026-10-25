class UserProfileResponseModel {
  final int statusCode;
  final bool success;
  final String message;
  final UserProfileModel? data;

  const UserProfileResponseModel({
    required this.statusCode,
    required this.success,
    required this.message,
    this.data,
  });

  factory UserProfileResponseModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic>? profileJson;
    if (json['data'] is Map<String, dynamic>) {
      final dataMap = json['data'] as Map<String, dynamic>;
      if (dataMap['profile'] is Map<String, dynamic>) {
        profileJson = dataMap['profile'] as Map<String, dynamic>;
      } else {
        profileJson = dataMap;
      }
    } else if (json['profile'] is Map<String, dynamic>) {
      profileJson = json['profile'] as Map<String, dynamic>;
    }

    return UserProfileResponseModel(
      statusCode: json['statusCode'] is int
          ? json['statusCode']
          : int.tryParse(json['statusCode']?.toString() ?? '') ?? 200,
      success: json['success'] == true,
      message: json['message']?.toString() ?? '',
      data: profileJson != null ? UserProfileModel.fromJson(profileJson) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'success': success,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class UserProfileModel {
  final String? userId;
  final String? role;
  final String? fullName;
  final String? username;
  final String? email;
  final String? phoneNumber;
  final String? country;
  final String? city;
  final String? location;
  final String? profileImage;
  final bool isVerified;
  final UserStatsModel stats;
  final DateTime? createdAt;
  final dynamic sellerProfile;
  final dynamic artistProfile;

  const UserProfileModel({
    this.userId,
    this.role,
    this.fullName,
    this.username,
    this.email,
    this.phoneNumber,
    this.country,
    this.city,
    this.location,
    this.profileImage,
    this.isVerified = false,
    this.stats = const UserStatsModel(),
    this.createdAt,
    this.sellerProfile,
    this.artistProfile,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      userId: json['userId']?.toString(),
      role: json['role']?.toString(),
      fullName: json['fullName']?.toString(),
      username: json['username']?.toString(),
      email: json['email']?.toString(),
      phoneNumber: json['phoneNumber']?.toString(),
      country: json['country']?.toString(),
      city: json['city']?.toString(),
      location: json['location']?.toString(),
      profileImage: json['profileImage']?.toString(),
      isVerified: json['isVerified'] == true,
      stats: json['stats'] is Map<String, dynamic>
          ? UserStatsModel.fromJson(json['stats'] as Map<String, dynamic>)
          : const UserStatsModel(),
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : null,
      sellerProfile: json['sellerProfile'],
      artistProfile: json['artistProfile'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'role': role,
      'fullName': fullName,
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'country': country,
      'city': city,
      'location': location,
      'profileImage': profileImage,
      'isVerified': isVerified,
      'stats': stats.toJson(),
      'createdAt': createdAt?.toIso8601String(),
      'sellerProfile': sellerProfile,
      'artistProfile': artistProfile,
    };
  }

  UserProfileModel copyWith({
    String? userId,
    String? role,
    String? fullName,
    String? username,
    String? email,
    String? phoneNumber,
    String? country,
    String? city,
    String? location,
    String? profileImage,
    bool? isVerified,
    UserStatsModel? stats,
    DateTime? createdAt,
    dynamic sellerProfile,
    dynamic artistProfile,
  }) {
    return UserProfileModel(
      userId: userId ?? this.userId,
      role: role ?? this.role,
      fullName: fullName ?? this.fullName,
      username: username ?? this.username,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      country: country ?? this.country,
      city: city ?? this.city,
      location: location ?? this.location,
      profileImage: profileImage ?? this.profileImage,
      isVerified: isVerified ?? this.isVerified,
      stats: stats ?? this.stats,
      createdAt: createdAt ?? this.createdAt,
      sellerProfile: sellerProfile ?? this.sellerProfile,
      artistProfile: artistProfile ?? this.artistProfile,
    );
  }
}

class UserStatsModel {
  final int orders;
  final int wishlist;
  final int artist;

  const UserStatsModel({
    this.orders = 0,
    this.wishlist = 0,
    this.artist = 0,
  });

  factory UserStatsModel.fromJson(Map<String, dynamic> json) {
    return UserStatsModel(
      orders: _parseInt(json['orders']),
      wishlist: _parseInt(json['wishlist']),
      artist: _parseInt(json['artist']),
    );
  }

  static int _parseInt(dynamic val) {
    if (val == null) return 0;
    if (val is int) return val;
    return int.tryParse(val.toString()) ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'orders': orders,
      'wishlist': wishlist,
      'artist': artist,
    };
  }
}
