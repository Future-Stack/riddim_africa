import '../entities/seller_dashboard_stats_entity.dart';
import '../entities/seller_recent_order_entity.dart';

abstract class SellerHomeRepository {
  Future<SellerDashboardStatsEntity> getDashboardStats();
  Future<List<SellerRecentOrderEntity>> getRecentOrders();
}
