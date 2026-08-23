import '../entities/artist_profile_entity.dart';
import '../repositories/artist_profile_repository.dart';

class GetArtistProfileUseCase {
  final ArtistProfileRepository repository;

  GetArtistProfileUseCase(this.repository);

  Future<ArtistProfileEntity> call() async {
    return await repository.getProfile();
  }
}
