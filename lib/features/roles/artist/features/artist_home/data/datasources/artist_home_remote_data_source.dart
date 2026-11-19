import '../models/artist_dashboard_stats_model.dart';
import '../models/artist_recent_order_model.dart';

class ArtistHomeRemoteDataSource {
  Future<ArtistDashboardStatsModel> getDashboardStats() async {
    // Mocking an API call
    await Future.delayed(const Duration(milliseconds: 800));
    return const ArtistDashboardStatsModel(
      totalRevenue: 312000,
      revenueGrowthPercentage: 22,
      settledRevenue: 265000,
      payoutInProgress: 47000,
      totalProducts: 187,
      activeOrders: 5,
      pendingOrders: 4,
    );
  }

  Future<List<ArtistRecentOrderModel>> getRecentOrders() async {
    // Mocking an API call
    await Future.delayed(const Duration(milliseconds: 800));
    return const [
      ArtistRecentOrderModel(
        id: '#SL-3012',
        productName: 'Ankara Print Tote Bag',
        productImageUrl: 'https://picsum.photos/200',
        customerName: 'Amara Osei',
        date: 'June 15, 2026',
        status: 'Pending',
        price: 28000,
      ),
      ArtistRecentOrderModel(
        id: '#SL-3008',
        productName: 'Kente Fabric Cap',
        productImageUrl: 'https://picsum.photos/201',
        customerName: 'Ngozi Bello',
        date: 'June 13, 2026',
        status: 'Pending',
        price: 15500,
      ),
    ];
  }
}
