import '../entities/artist_dashboard_stats_entity.dart';
import '../entities/artist_recent_order_entity.dart';

abstract class ArtistHomeRepository {
  Future<ArtistDashboardStatsEntity> getDashboardStats();
  Future<List<ArtistRecentOrderEntity>> getRecentOrders();
}
