import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:riddimafrica/core/core.dart';

class StatsBox extends StatelessWidget {
  final BuildContext context;

  const StatsBox({super.key, required this.context});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.primaryappbrownsecond,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatsColumn(
            icon: Iconsax.send_2,
            value: '4.3 km',
            label: 'Distance',
            iconColor: const Color(0xFF387A7C),
          ),
          Container(height: 40, width: 1, color: AppColors.primaryappbrown),
          _buildStatsColumn(
            icon: Iconsax.clock,
            value: '12 min',
            label: 'Est. drive',
            iconColor: const Color(0xFFD4A750),
          ),
          Container(height: 40, width: 1, color: AppColors.primaryappbrown),
          _buildStatsColumn(
            icon: Iconsax.truck,
            value: 'UGX 5,500',
            label: 'Delivery fee',
            valueColor: AppColors.onboardingbutton,
            iconColor: const Color(0xFFBB483D),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsColumn({
    required IconData icon,
    required String value,
    required String label,
    Color? valueColor,
    Color? iconColor,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: (iconColor ?? AppColors.bordercolor).withValues(alpha: 0.12),
          ),
          child: Icon(
            icon,
            color: iconColor ?? AppColors.bordercolor,
            size: 20,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: AppTextStyle(
            context,
          ).boldTextStyle(color: valueColor ?? AppColors.white, fontSize: 14),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTextStyle(
            context,
          ).mediumTextStyle(color: AppColors.primarytext, fontSize: 10),
        ),
      ],
    );
  }
}
