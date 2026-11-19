import '../entities/artist_entity.dart';
import '../repositories/home_repository.dart';

class GetSuggestedArtistsUseCase {
  final HomeRepository repository;

  GetSuggestedArtistsUseCase(this.repository);

  Future<List<ArtistEntity>> execute() {
    return repository.getArtists();
  }
}
