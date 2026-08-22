import 'package:flutter/material.dart';
import 'package:riddimafrica/core/core.dart';
import '../../data/models/seller_review_model.dart';

class SellerRatingBreakdownBar extends StatelessWidget {
  final SellerRatingBreakdown item;

  const SellerRatingBreakdownBar({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          // Star Label (e.g. "5 ★")
          SizedBox(
            width: 32.w,
            child: Row(
              children: [
                Text(
                  '${item.star}',
                  style: AppTextStyle(context).regularTextStyle(
                    fontSize: 12.sp,
                    color: Colors.white,
                  ),
                ),
                4.horizontalSpace,
                Icon(
                  Icons.star,
                  color: const Color(0xFFD49B53),
                  size: 11.sp,
                ),
              ],
            ),
          ),
          8.horizontalSpace,

          // Progress Bar
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              child: SizedBox(
                height: 6.h,
                child: LinearProgressIndicator(
                  value: item.percentage,
                  backgroundColor: AppColors.white.withValues(alpha: 0.08),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color(0xFFD49B53),
                  ),
                ),
              ),
            ),
          ),
          12.horizontalSpace,

          // Percentage text (e.g. "78%")
          SizedBox(
            width: 34.w,
            child: Text(
              item.label,
              textAlign: TextAlign.end,
              style: AppTextStyle(context).regularTextStyle(
                fontSize: 11.sp,
                color: AppColors.primarytext,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
