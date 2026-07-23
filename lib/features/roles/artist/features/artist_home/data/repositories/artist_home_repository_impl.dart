import '../../domain/entities/artist_dashboard_stats_entity.dart';
import '../../domain/entities/artist_recent_order_entity.dart';
import '../../domain/repositories/artist_home_repository.dart';
import '../datasources/artist_home_remote_data_source.dart';

class ArtistHomeRepositoryImpl implements ArtistHomeRepository {
  final ArtistHomeRemoteDataSource remoteDataSource;

  ArtistHomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<ArtistDashboardStatsEntity> getDashboardStats() async {
    return await remoteDataSource.getDashboardStats();
  }

  @override
  Future<List<ArtistRecentOrderEntity>> getRecentOrders() async {
    return await remoteDataSource.getRecentOrders();
  }
}
