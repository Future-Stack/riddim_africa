import '../entities/artist_revenue_entity.dart';
import '../repositories/artist_revenue_repository.dart';

class GetArtistRevenueStatsUseCase {
  final ArtistRevenueRepository repository;

  GetArtistRevenueStatsUseCase(this.repository);

  Future<ArtistRevenueEntity> call() async {
    return await repository.getRevenueStats();
  }
}
