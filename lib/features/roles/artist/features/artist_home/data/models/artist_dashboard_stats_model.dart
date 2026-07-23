import '../../domain/entities/artist_dashboard_stats_entity.dart';

class ArtistDashboardStatsModel extends ArtistDashboardStatsEntity {
  const ArtistDashboardStatsModel({
    required super.totalRevenue,
    required super.revenueGrowthPercentage,
    required super.settledRevenue,
    required super.payoutInProgress,
    required super.totalProducts,
    required super.activeOrders,
    required super.pendingOrders,
  });

  factory ArtistDashboardStatsModel.fromJson(Map<String, dynamic> json) {
    return ArtistDashboardStatsModel(
      totalRevenue: (json['totalRevenue'] ?? 0).toDouble(),
      revenueGrowthPercentage: (json['revenueGrowthPercentage'] ?? 0).toDouble(),
      settledRevenue: (json['settledRevenue'] ?? 0).toDouble(),
      payoutInProgress: (json['payoutInProgress'] ?? 0).toDouble(),
      totalProducts: json['totalProducts'] ?? 0,
      activeOrders: json['activeOrders'] ?? 0,
      pendingOrders: json['pendingOrders'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalRevenue': totalRevenue,
      'revenueGrowthPercentage': revenueGrowthPercentage,
      'settledRevenue': settledRevenue,
      'payoutInProgress': payoutInProgress,
      'totalProducts': totalProducts,
      'activeOrders': activeOrders,
      'pendingOrders': pendingOrders,
    };
  }
}
