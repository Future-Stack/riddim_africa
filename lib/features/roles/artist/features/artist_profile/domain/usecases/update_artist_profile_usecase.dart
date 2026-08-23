import '../entities/artist_profile_entity.dart';
import '../repositories/artist_profile_repository.dart';

class UpdateArtistProfileUseCase {
  final ArtistProfileRepository repository;

  UpdateArtistProfileUseCase(this.repository);

  Future<ArtistProfileEntity> call(ArtistProfileEntity updatedProfile) async {
    return await repository.updateProfile(updatedProfile);
  }
}
