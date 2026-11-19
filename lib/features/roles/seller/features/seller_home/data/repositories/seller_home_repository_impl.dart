import '../../domain/entities/seller_dashboard_stats_entity.dart';
import '../../domain/entities/seller_recent_order_entity.dart';
import '../../domain/repositories/seller_home_repository.dart';
import '../datasources/seller_home_remote_data_source.dart';

class SellerHomeRepositoryImpl implements SellerHomeRepository {
  final SellerHomeRemoteDataSource remoteDataSource;

  SellerHomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<SellerDashboardStatsEntity> getDashboardStats() async {
    return await remoteDataSource.getDashboardStats();
  }

  @override
  Future<List<SellerRecentOrderEntity>> getRecentOrders() async {
    return await remoteDataSource.getRecentOrders();
  }
}
