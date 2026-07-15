import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:riddimafrica/core/core.dart';
import '../../domain/entities/order_entity.dart';

class OrderCard extends StatelessWidget {
  final OrderEntity order;
  final VoidCallback? onTap;

  const OrderCard({super.key, required this.order, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.primaryappbrown,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.primaryappbrownsecond, width: 1),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    width: 72,
                    height: 72,
                    child: Image.network(
                      order.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => Container(
                        color: AppColors.primaryappbrownsecond,
                        child: const Icon(
                          Iconsax.image,
                          color: AppColors.primarytext,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.title,
                        style: AppTextStyle(context).semiBoldTextStyle(
                          color: AppColors.white,
                          fontSize: AppTextStyle.lg,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        order.sellerName,
                        style: AppTextStyle(context).regularTextStyle(
                          color: AppColors.primarytext,
                          fontSize: AppTextStyle.sm,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Qty: ${order.quantity}',
                        style: AppTextStyle(context).regularTextStyle(
                          color: AppColors.primarytext,
                          fontSize: AppTextStyle.sm,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        order.price,
                        style: AppTextStyle(context).boldTextStyle(
                          color: AppColors.onboardingbutton,
                          fontSize: AppTextStyle.md,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildStatusBadge(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    Color bgColor;
    Color textColor;
    IconData icon;

    switch (order.statusLabel.toLowerCase()) {
      case 'delivered':
        bgColor = AppColors.success.withValues(alpha: 0.15);
        textColor = AppColors.success;
        icon = Iconsax.tick_circle;
      case 'shipped':
        bgColor = AppColors.info.withValues(alpha: 0.15);
        textColor = AppColors.info;
        icon = Iconsax.truck;
      case 'processing':
      default:
        bgColor = AppColors.warning.withValues(alpha: 0.15);
        textColor = AppColors.warning;
        icon = Iconsax.clock;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: textColor),
          const SizedBox(width: 4),
          Text(
            order.statusLabel,
            style: AppTextStyle(context).boldTextStyle(
              color: textColor,
              fontSize: AppTextStyle.sm,
            ), 
          ),
        ],
      ),
    );
  }
}
