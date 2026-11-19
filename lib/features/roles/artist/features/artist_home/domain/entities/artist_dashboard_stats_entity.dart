class ArtistDashboardStatsEntity {
  final double totalRevenue;
  final double revenueGrowthPercentage;
  final double settledRevenue;
  final double payoutInProgress;
  final int totalProducts;
  final int activeOrders;
  final int pendingOrders;

  const ArtistDashboardStatsEntity({
    required this.totalRevenue,
    required this.revenueGrowthPercentage,
    required this.settledRevenue,
    required this.payoutInProgress,
    required this.totalProducts,
    required this.activeOrders,
    required this.pendingOrders,
  });
}
