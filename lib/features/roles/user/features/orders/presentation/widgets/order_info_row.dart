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
          style: AppTextStyle(context).mediumTextStyle(
            color: AppColors.primarytext,
            fontSize: AppTextStyle.md,
          ),
        ),
        Flexible(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, color: valueColor ?? AppColors.white, size: 16),
                const SizedBox(width: 6),
              ],
              Flexible(
                child: Text(
                  value,
                  style: AppTextStyle(context).boldTextStyle(
                    color: valueColor ?? AppColors.white,
                    fontSize: AppTextStyle.md,
                  ),
                  textAlign: TextAlign.end,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
