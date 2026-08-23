import 'package:flutter/material.dart';
import 'package:riddimafrica/core/core.dart';
import '../../data/models/artist_review_model.dart';

class ArtistRatingBreakdownBar extends StatelessWidget {
  final ArtistRatingBreakdown item;

  const ArtistRatingBreakdownBar({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          // Star label
          SizedBox(
            width: 14.w,
            child: Text(
              '${item.star}',
              style: AppTextStyle(context).mediumTextStyle(
                fontSize: 12.sp,
                color: Colors.white,
              ),
            ),
          ),
          4.horizontalSpace,
          Icon(
            Icons.star_outline_rounded,
            color: const Color(0xFFD49B53),
            size: 14.sp,
          ),
          12.horizontalSpace,

          // Progress Bar
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              child: LinearProgressIndicator(
                value: item.percentage,
                backgroundColor: AppColors.white.withValues(alpha: 0.08),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFFD49B53),
                ),
                minHeight: 6.h,
              ),
            ),
          ),
          14.horizontalSpace,

          // Percentage
          SizedBox(
            width: 32.w,
            child: Text(
              item.label,
              textAlign: TextAlign.end,
              style: AppTextStyle(context).regularTextStyle(
                fontSize: 11.sp,
                color: AppColors.primarytext.withValues(alpha: 0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
