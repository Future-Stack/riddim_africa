import '../entities/artist_dashboard_stats_entity.dart';
import '../repositories/artist_home_repository.dart';

class GetArtistDashboardStatsUseCase {
  final ArtistHomeRepository repository;

  GetArtistDashboardStatsUseCase(this.repository);

  Future<ArtistDashboardStatsEntity> execute() {
    return repository.getDashboardStats();
  }
}
