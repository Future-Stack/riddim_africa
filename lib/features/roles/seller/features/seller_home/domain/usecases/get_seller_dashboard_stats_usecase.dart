import '../entities/seller_dashboard_stats_entity.dart';
import '../repositories/seller_home_repository.dart';

class GetSellerDashboardStatsUseCase {
  final SellerHomeRepository repository;

  GetSellerDashboardStatsUseCase(this.repository);

  Future<SellerDashboardStatsEntity> execute() {
    return repository.getDashboardStats();
  }
}
