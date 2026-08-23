import '../entities/artist_profile_entity.dart';

abstract class ArtistProfileRepository {
  Future<ArtistProfileEntity> getProfile();
  Future<ArtistProfileEntity> updateProfile(ArtistProfileEntity profile);
}
