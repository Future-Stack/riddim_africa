import 'package:flutter/material.dart';
import 'package:riddimafrica/core/core.dart';

class LiveRadioCard extends StatelessWidget {
  const LiveRadioCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1B221B), // Dark green-black background
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF2C392C), width: 1.0),
      ),
      child: Row(
        children: [
          // Ankh Logo in Teal Circle
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              color: const Color(0xFF356E7A), // Teal circle
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Image.asset(ImagePath.logo3),
          ),
          const SizedBox(width: 16),
          // Radio details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.fiber_manual_record,
                      color: AppColors.onboardingbutton, // Gold/Orange dot
                      size: 10,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'LIVE',
                      style: AppTextStyle(context).boldTextStyle(
                        color: AppColors.onboardingbutton,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Riddim Africa Radio',
                      style: AppTextStyle(context).mediumTextStyle(
                        color: AppColors.primarytext,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  'Wanjohi — Midnight Blues',
                  style: AppTextStyle(
                    context,
                  ).boldTextStyle(color: AppColors.white, fontSize: 16),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  'The Late Night Show',
                  style: AppTextStyle(context).regularTextStyle(
                    color: AppColors.primarytext,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          // Play Button Circle
          Container(
            width: 48.w,
            height: 48.w,
            decoration: const BoxDecoration(
              color: Color(0xFF356E7A),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.play_arrow_rounded,
                color: AppColors.onboardingbutton,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
