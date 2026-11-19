import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:riddimafrica/core/utils/constants/colors.dart';
import 'package:riddimafrica/core/common/styles/global_text_style.dart';

class DeliveryAddressChip extends StatelessWidget {
  final String label;
  final String address;
  final bool isSelected;
  final VoidCallback? onTap;
  final VoidCallback? onRemove;

  const DeliveryAddressChip({
    super.key,
    required this.label,
    required this.address,
    this.isSelected = false,
    this.onTap,
    this.onRemove,
  });

  IconData get _labelIcon {
    switch (label.toLowerCase()) {
      case 'home':
        return Iconsax.home_2;
      case 'work':
        return Iconsax.building;
      default:
        return Iconsax.location;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.bordercolor.withValues(alpha: 0.15)
              : AppColors.primaryappbrownsecond,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: isSelected
                ? AppColors.bordercolor
                : AppColors.primaryappbrownsecond,
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _labelIcon,
                  color: isSelected
                      ? AppColors.onboardingbutton
                      : AppColors.primarytext,
                  size: 16,
                ),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: AppTextStyle(context).semiBoldTextStyle(
                    color: AppColors.white,
                    fontSize: AppTextStyle.sm,
                  ),
                ),
                const SizedBox(width: 8),
                // Star & Remove
                Icon(
                  Iconsax.star1,
                  color: isSelected
                      ? AppColors.onboardingbutton
                      : AppColors.primarytext,
                  size: 14,
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: onRemove,
                  child: const Icon(
                    Icons.close,
                    color: AppColors.secondary,
                    size: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              address,
              style: AppTextStyle(context).regularTextStyle(
                color: AppColors.primarytext,
                fontSize: AppTextStyle.xs,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
