import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:riddimafrica/core/core.dart';
import '../../domain/entities/artist_dashboard_stats_entity.dart';

class ArtistStatsRow extends StatelessWidget {
  final ArtistDashboardStatsEntity stats;

  const ArtistStatsRow({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            context,
            svgIcon: IconPath.dcube,
            iconColor: AppColors.bordercolor,
            value: stats.totalProducts.toString(),
            label: 'Products',
            cardColor: AppColors.bordercolor.withValues(alpha: 0.05),
            iconBoxColor: AppColors.bordercolor.withValues(alpha: 0.1),
            borderColor: AppColors.bordercolor.withValues(alpha: 0.15),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            context,
            svgIcon: IconPath.cartNew,
            value: stats.activeOrders.toString(),
            label: 'Active Orders',
            cardColor: AppColors.cardBorder2.withValues(alpha: 0.05),
            iconBoxColor: AppColors.cardBorder2.withValues(alpha: 0.1),
            borderColor: AppColors.cardBorder2.withValues(alpha: 0.15),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            context,
            svgIcon: IconPath.clock,
            iconColor: AppColors.multicolor,
            value: stats.pendingOrders.toString(),
            label: 'Pending',
            cardColor: AppColors.multicolor.withValues(alpha: 0.05),
            iconBoxColor: AppColors.multicolor.withValues(alpha: 0.1),
            borderColor: AppColors.multicolor.withValues(alpha: 0.15),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String svgIcon,
    Color? iconColor,
    required String value,
    required String label,
    Color? cardColor,
    Color? iconBoxColor,
    Color? borderColor,
  }) {
    final bgColor = cardColor ?? AppColors.white.withValues(alpha: 0.03);

    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor ?? AppColors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 32,
            width: 32,
            decoration: BoxDecoration(
              color: iconBoxColor ?? bgColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: SvgPicture.asset(
                svgIcon,
                width: 16,
                height: 16,
                colorFilter: ColorFilter.mode(
                  iconColor ?? AppColors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: AppTextStyle(
              context,
            ).boldTextStyle(color: AppColors.white, fontSize: 20),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTextStyle(context).mediumTextStyle(
              color: AppColors.white.withValues(alpha: 0.5),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
