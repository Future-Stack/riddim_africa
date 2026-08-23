import 'package:flutter/material.dart';
import '../../domain/entities/artist_dashboard_stats_entity.dart';
import 'package:riddimafrica/features/roles/artist/features/artist_revenue/presentation/widgets/artist_revenue_hero_card.dart';

class RevenueCard extends StatelessWidget {
  final ArtistDashboardStatsEntity stats;

  const RevenueCard({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return ArtistRevenueHeroCard(
      totalRevenue: stats.totalRevenue,
      growthPercentage: stats.revenueGrowthPercentage,
      settledRevenue: stats.settledRevenue,
      payoutInProgress: stats.payoutInProgress,
    );
  }
}
