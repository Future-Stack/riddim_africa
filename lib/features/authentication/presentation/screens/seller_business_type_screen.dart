import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import 'package:riddimafrica/routes/app_routes.dart';
import 'package:riddimafrica/features/authentication/presentation/controllers/auth_controller.dart';

// ─────────────────────────────────────────────────────────────────────────────
// SCREEN 2 — Business Type Selection
// ─────────────────────────────────────────────────────────────────────────────
class SellerBusinessTypeScreen extends StatelessWidget {
  const SellerBusinessTypeScreen({super.key});

  static const List<Map<String, dynamic>> _businessTypes = [
    {
      'title': 'Individual / Sole Trader',
      'subtitle': 'You run the business alone',
      'icon': Icons.person_outline,
    },
    {
      'title': 'Partnership',
      'subtitle': 'Business owned by two or more people',
      'icon': Icons.people_outline,
    },
    {
      'title': 'Registered Company',
      'subtitle': 'Legally registered business entity',
      'icon': Icons.business_outlined,
    },
    {
      'title': 'NGO / Non-profit',
      'subtitle': 'Non-governmental organization',
      'icon': Icons.volunteer_activism_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.primary,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'Create Account',
              style: AppTextStyle(context).boldTextStyle(
                color: AppColors.textfieldelementcolor,
                fontSize: AppTextStyle.xl,
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.white),
              onPressed: () => Get.back(),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Progress
                  _buildProgressBar(step: 2),
                  SizedBox(height: 24.h),

                  Text(
                    'Select Business Type',
                    style: AppTextStyle(context).boldTextStyle(
                      color: AppColors.white,
                      fontSize: AppTextStyle.title,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Choose the type that best describes your business.',
                    style: AppTextStyle(context).regularTextStyle(
                      color: AppColors.onboardingtext,
                      fontSize: AppTextStyle.md,
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Business type cards
                  Expanded(
                    child: ListView.separated(
                      itemCount: _businessTypes.length,
                      separatorBuilder: (context, _) => SizedBox(height: 12.h),
                      itemBuilder: (context, index) {
                        final type = _businessTypes[index];
                        final isSelected =
                            controller.selectedBusinessType == index;
                        return _buildTypeCard(
                          context,
                          title: type['title'] as String,
                          subtitle: type['subtitle'] as String,
                          icon: type['icon'] as IconData,
                          isSelected: isSelected,
                          onTap: () => controller.setBusinessType(index),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16.h),

                  ProElevatedButton(
                    text: 'Next',
                    trailingIcon: Icons.arrow_forward_ios,
                    iconSize: 16,
                    gradient: const LinearGradient(
                      colors: [AppColors.secondary, AppColors.secondary],
                    ),
                    onPressed: () => Get.toNamed(AppRoute.sellerPaymentMethodScreen),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProgressBar({required int step}) {
    return Row(
      children: List.generate(3, (i) {
        final done = i < step;
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(right: i < 2 ? 6.w : 0),
            height: 4,
            decoration: BoxDecoration(
              color: done ? AppColors.bordercolor : AppColors.cardBorder,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildTypeCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.bordercolor.withValues(alpha: 0.12)
              : AppColors.backgroundcolor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.bordercolor : AppColors.cardBorder,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            // Icon box
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.bordercolor.withValues(alpha: 0.2)
                    : AppColors.cardBorder.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isSelected ? AppColors.bordercolor : AppColors.onboardingtext,
                size: 24,
              ),
            ),
            SizedBox(width: 16.w),

            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyle(context).boldTextStyle(
                      color: AppColors.white,
                      fontSize: AppTextStyle.md,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: AppTextStyle(context).regularTextStyle(
                      color: AppColors.onboardingtext,
                      fontSize: AppTextStyle.sm,
                    ),
                  ),
                ],
              ),
            ),

            // Radio indicator
            Container(
              width: 22.w,
              height: 22.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.bordercolor : AppColors.onboardingtext,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 12.w,
                        height: 12.w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.bordercolor,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
