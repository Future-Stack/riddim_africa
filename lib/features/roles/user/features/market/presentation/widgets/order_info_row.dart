import 'package:flutter/material.dart';
import 'package:riddimafrica/core/core.dart';

class OrderInfoRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData? icon;
  final Color? valueColor;

  const OrderInfoRow({
    super.key,
    required this.label,
    required this.value,
    this.icon,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyle(
            context,
          ).mediumTextStyle(color: AppColors.primarytext, fontSize: 14),
        ),
        Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: valueColor ?? AppColors.white, size: 16),
              const SizedBox(width: 6),
            ],
            Text(
              value,
              style: AppTextStyle(context).boldTextStyle(
                color: valueColor ?? AppColors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
