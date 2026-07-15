import 'package:flutter/material.dart';
import 'package:riddimafrica/core/utils/constants/colors.dart';
import 'package:riddimafrica/core/common/styles/global_text_style.dart';

class StockBadge extends StatelessWidget {
  final bool inStock;

  const StockBadge({super.key, required this.inStock});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: inStock
            ? AppColors.success.withValues(alpha: 0.15)
            : AppColors.error.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text(
        inStock ? 'IN STOCK' : 'OUT OF STOCK',
        style: AppTextStyle(context).boldTextStyle(
          color: inStock ? AppColors.success : AppColors.error,
          fontSize: AppTextStyle.xs,
        ),
      ),
    );
  }
}
