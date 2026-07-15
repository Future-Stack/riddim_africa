import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:riddimafrica/core/utils/constants/colors.dart';
import 'package:riddimafrica/core/common/styles/global_text_style.dart';

class RatingRow extends StatelessWidget {
  final double rating;
  final int reviewCount;

  const RatingRow({
    super.key,
    required this.rating,
    this.reviewCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Stars
        ...List.generate(5, (index) {
          final starValue = index + 1;
          if (rating >= starValue) {
            return const Icon(
              Iconsax.star1,
              color: AppColors.onboardingbutton,
              size: 18,
            );
          } else if (rating >= starValue - 0.5) {
            return const Icon(
              Iconsax.star_1,
              color: AppColors.onboardingbutton,
              size: 18,
            );
          } else {
            return Icon(
              Iconsax.star_1,
              color: AppColors.primarytext.withValues(alpha: 0.3),
              size: 18,
            );
          }
        }),
        const SizedBox(width: 8),
        Text(
          '$rating ($reviewCount reviews)',
          style: AppTextStyle(context).mediumTextStyle(
            color: AppColors.primarytext,
            fontSize: AppTextStyle.sm,
          ),
        ),
      ],
    );
  }
}
