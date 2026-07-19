import 'package:flutter/material.dart';
import 'package:riddimafrica/core/core.dart';

class CampaignBannerCard extends StatelessWidget {
  const CampaignBannerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        image: const DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1612196808214-b8e1d6145a8c?q=80&w=600&auto=format&fit=crop',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.black.withValues(alpha: 0.8),
              Colors.black.withValues(alpha: 0.2),
            ],
          ),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Marketplace Campaign',
              style: AppTextStyle(
                context,
              ).mediumTextStyle(color: AppColors.onboardingtext, fontSize: 14),
            ),
            SizedBox(height: 5.h),
            Text(
              'New African Fashion Collection',
              style: AppTextStyle(
                context,
              ).boldTextStyle(color: AppColors.white, fontSize: 18),
            ),
            const SizedBox(height: 16),
            ProElevatedButton(
              backgroundColor: AppColors.white,
              width: 100.w,
              height: 33.h,
              borderRadius: 40.r,
              text: 'Shop Now',
              fontSize: 14,
              fontWeight: 500,
              textColor: AppColors.secondary,
            ),
          ],
        ),
      ),
    );
  }
}
