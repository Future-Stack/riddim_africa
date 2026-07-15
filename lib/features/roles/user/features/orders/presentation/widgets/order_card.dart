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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.primaryappbrown,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.primaryappbrownsecond, width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Icon + Order Number + Status Badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Iconsax.box,
                      color: AppColors.onboardingbutton,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      order.orderNumber,
                      style: AppTextStyle(context).boldTextStyle(
                        color: AppColors.white,
                        fontSize: AppTextStyle.md,
                      ),
                    ),
                  ],
                ),
                _buildStatusBadge(context),
              ],
            ),
            const SizedBox(height: 16),

            // Body: Circular product image next to Title x Qty
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: SizedBox(
                    width: 56,
                    height: 56,
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
                  child: Text(
                    '${order.title} × ${order.quantity}',
                    style: AppTextStyle(context).mediumTextStyle(
                      color: AppColors.primarytext,
                      fontSize: AppTextStyle.md,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            const Divider(
              color: AppColors.primaryappbrownsecond,
              height: 1,
              thickness: 1,
            ),
            const SizedBox(height: 12),

            // Footer: Date on left, Total Price on right
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatDate(order.orderDate),
                  style: AppTextStyle(context).regularTextStyle(
                    color: AppColors.primarytext,
                    fontSize: AppTextStyle.sm,
                  ),
                ),
                Text(
                  order.totalPrice.isNotEmpty ? order.totalPrice : order.price,
                  style: AppTextStyle(context).boldTextStyle(
                    color: AppColors.onboardingbutton,
                    fontSize: AppTextStyle.lg,
                  ),
                ),
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
    final status = order.statusLabel.toLowerCase();

    if (status == 'delivered') {
      bgColor = AppColors.success;
      textColor = AppColors.white;
    } else if (status == 'cancelled' || status == 'canceled') {
      bgColor = AppColors.error.withValues(alpha: 0.15);
      textColor = AppColors.error;
    } else if (status == 'out for delivery') {
      bgColor = AppColors.onboardingbutton.withValues(alpha: 0.15);
      textColor = AppColors.onboardingbutton;
    } else {
      bgColor = AppColors.warning.withValues(alpha: 0.15);
      textColor = AppColors.warning;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        order.statusLabel,
        style: AppTextStyle(context).boldTextStyle(
          color: textColor,
          fontSize: AppTextStyle.xs,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}
