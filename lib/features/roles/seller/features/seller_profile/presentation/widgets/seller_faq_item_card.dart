import 'package:flutter/material.dart';
import 'package:riddimafrica/core/core.dart';
import '../../data/models/seller_faq_model.dart';

class SellerFaqItemCard extends StatelessWidget {
  final SellerFaqModel faq;
  final bool isExpanded;
  final VoidCallback onTap;

  const SellerFaqItemCard({
    super.key,
    required this.faq,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFF22140A),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: isExpanded
              ? const Color(0xFFD49B53).withValues(alpha: 0.4)
              : AppColors.white.withValues(alpha: 0.06),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(14.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(14.r),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Question Icon
                    Container(
                      width: 28.w,
                      height: 28.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFF382111),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFD49B53).withValues(alpha: 0.3),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '?',
                          style: TextStyle(
                            color: const Color(0xFFD49B53),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    12.horizontalSpace,

                    // Question Text
                    Expanded(
                      child: Text(
                        faq.question,
                        style: AppTextStyle(context).mediumTextStyle(
                          fontSize: 13.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    // Chevron Icon with animated rotation
                    AnimatedRotation(
                      turns: isExpanded ? 0.25 : 0.0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        Icons.chevron_right,
                        color: AppColors.primarytext.withValues(alpha: 0.7),
                        size: 20.sp,
                      ),
                    ),
                  ],
                ),

                // Expanded Answer
                AnimatedCrossFade(
                  firstChild: const SizedBox.shrink(),
                  secondChild: Padding(
                    padding: EdgeInsets.only(top: 12.h, left: 40.w),
                    child: Text(
                      faq.answer,
                      style: AppTextStyle(context).regularTextStyle(
                        fontSize: 12.sp,
                        color: AppColors.primarytext,
                        lineHeight: 18,
                      ),
                    ),
                  ),
                  crossFadeState: isExpanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 200),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
