import '../models/artist_dashboard_stats_model.dart';
import '../models/artist_recent_order_model.dart';

class ArtistHomeRemoteDataSource {
  Future<ArtistDashboardStatsModel> getDashboardStats() async {
    // Mocking an API call
    await Future.delayed(const Duration(milliseconds: 800));
    return const ArtistDashboardStatsModel(
      totalRevenue: 234500,
      revenueGrowthPercentage: 18,
      settledRevenue: 189200,
      payoutInProgress: 45300,
      totalProducts: 225,
      activeOrders: 2,
      pendingOrders: 3,
    );
  }

  Future<List<ArtistRecentOrderModel>> getRecentOrders() async {
    // Mocking an API call
    await Future.delayed(const Duration(milliseconds: 800));
    return const [
      ArtistRecentOrderModel(
        id: '#RA-2847',
        productName: 'Golden Sound Hoodie',
        productImageUrl: 'https://picsum.photos/200', // Using a placeholder for now
        customerName: 'Fatima Diallo',
        date: 'June 12, 2026',
        status: 'Pending',
        price: 45000,
      ),
      ArtistRecentOrderModel(
        id: '#RA-2841',
        productName: 'Midnight Vibes T-Shirt',
        productImageUrl: 'https://picsum.photos/201',
        customerName: 'Kofi Mensah',
        date: 'June 10, 2026',
        status: 'Pending',
        price: 12500,
      ),
    ];
  }
}
