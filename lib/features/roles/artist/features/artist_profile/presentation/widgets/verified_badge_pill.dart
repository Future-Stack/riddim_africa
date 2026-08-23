import 'package:flutter/material.dart';
import 'package:riddimafrica/core/utils/constants/colors.dart';
import 'package:riddimafrica/core/common/styles/global_text_style.dart';

class VerifiedBadgePill extends StatelessWidget {
  final double fontSize;
  final double iconSize;
  final EdgeInsetsGeometry padding;

  const VerifiedBadgePill({
    super.key,
    this.fontSize = 13,
    this.iconSize = 16,
    this.padding = const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: const Color(0xFF24A61E), // Vibrant green from screenshot
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF24A61E).withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // White checkmark in scalloped/circle icon
          Container(
            padding: const EdgeInsets.all(1.5),
            decoration: const BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check,
              size: 11,
              color: Color(0xFF24A61E),
            ),
          ),
          const SizedBox(width: 6),
          Text(
            'Verified',
            style: AppTextStyle(context).boldTextStyle(
              color: AppColors.white,
              fontSize: fontSize,
            ),
          ),
        ],
      ),
    );
  }
}
