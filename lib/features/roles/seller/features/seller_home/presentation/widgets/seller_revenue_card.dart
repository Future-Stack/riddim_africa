import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:riddimafrica/core/core.dart';
import '../../domain/entities/seller_dashboard_stats_entity.dart';

class SellerRevenueCard extends StatelessWidget {
  final SellerDashboardStatsEntity stats;

  const SellerRevenueCard({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat('#,##0', 'en_US');

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [const Color(0xFF893F25), AppColors.primary],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        border: Border.all(color: AppColors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Revenue of this month',
            style: AppTextStyle(context).mediumTextStyle(
              color: AppColors.white.withValues(alpha: 0.7),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'UGX ${currencyFormatter.format(stats.totalRevenue)}',
            style: AppTextStyle(
              context,
            ).boldTextStyle(color: AppColors.white, fontSize: 28),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.trending_up, color: Colors.green, size: 14),
                const SizedBox(width: 4),
                Text(
                  '+${stats.revenueGrowthPercentage.toStringAsFixed(0)}% this month',
                  style: AppTextStyle(
                    context,
                  ).mediumTextStyle(color: Colors.green, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildSubCard(
                  context,
                  title: 'Settled to Mobile money',
                  amount: stats.settledRevenue,
                  formatter: currencyFormatter,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSubCard(
                  context,
                  title: 'Payout in progress',
                  amount: stats.payoutInProgress,
                  formatter: currencyFormatter,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubCard(
    BuildContext context, {
    required String title,
    required double amount,
    required NumberFormat formatter,
  }) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyle(context).mediumTextStyle(
              color: AppColors.white.withValues(alpha: 0.7),
              fontSize: 10,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'UGX ${formatter.format(amount)}',
            style: AppTextStyle(
              context,
            ).boldTextStyle(color: AppColors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
