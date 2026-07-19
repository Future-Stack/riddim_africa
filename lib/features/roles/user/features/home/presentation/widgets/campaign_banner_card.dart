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
            const SizedBox(height: 8),
            Text(
              'New African Fashion Collection',
              style: AppTextStyle(
                context,
              ).boldTextStyle(color: AppColors.white, fontSize: 18),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.white,
                foregroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
              ),
              child: Text(
                'Shop Now',
                style: AppTextStyle(
                  context,
                ).boldTextStyle(color: AppColors.secondary, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
