import '../models/artist_profile_model.dart';

class ArtistProfileRemoteDataSource {
  ArtistProfileModel _mockProfile = const ArtistProfileModel(
    id: 'art_12345',
    fullName: 'Elishin Nakato',
    stageName: 'Nakato Beats',
    email: 'aisha.nakato@gmail.com',
    phoneNumber: '+256 700 123 456',
    country: 'Uganda',
    cityName: 'Kampala',
    stateName: 'Central Region',
    avatarUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500',
    isVerified: true,
    productsCount: '1.2 k',
    soldCount: '80',
    followersCount: '1.2 k',
    rating: '4.8',
  );

  Future<ArtistProfileModel> getProfile() async {
    // Simulate real API latency
    await Future.delayed(const Duration(milliseconds: 400));
    return _mockProfile;
  }

  Future<ArtistProfileModel> updateProfile(ArtistProfileModel profile) async {
    await Future.delayed(const Duration(milliseconds: 600));
    _mockProfile = profile;
    return _mockProfile;
  }
}
