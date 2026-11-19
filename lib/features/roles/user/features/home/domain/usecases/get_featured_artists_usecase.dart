import '../../domain/entities/artist_entity.dart';
import '../../domain/repositories/home_repository.dart';

class GetFeaturedArtistsUseCase {
  final HomeRepository repository;

  GetFeaturedArtistsUseCase(this.repository);

  Future<List<ArtistEntity>> execute() {
    return repository.getFeaturedArtists();
  }
}
