import 'package:flutter/material.dart';
import 'package:riddimafrica/core/core.dart';
import 'package:riddimafrica/features/onboarding/domain/entities/onboarding_entity.dart';

class OnboardingPageContent extends StatelessWidget {
  final OnboardingEntity pageData;
  final int totalPages;
  final int currentIndex;

  const OnboardingPageContent({
    super.key,
    required this.pageData,
    required this.totalPages,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(pageData.bgImagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.black.withValues(alpha: 0.1),
              AppColors.black.withValues(alpha: 0.6),
              AppColors.black.withValues(alpha: 0.9),
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            child: Stack(
              children: [
                if (pageData.showTopRightLogo)
                  Align(
                    alignment: Alignment.topRight,
                    child: Image.asset(ImagePath.logo1, height: 40.h),
                  ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    if (pageData.centerLogoPath != null)
                      Center(
                        child: Image.asset(
                          height: 100.h,
                          pageData.centerLogoPath!,
                          width: 250.w,
                          fit: BoxFit.contain,
                        ),
                      ),
                    if (pageData.centerLogoPath != null) SizedBox(height: 24.h),
                    if (pageData.showDots)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(totalPages, (index) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 4.w),
                            width: currentIndex == index ? 18.w : 8.w,
                            height: 5.h,
                            decoration: BoxDecoration(
                              color: currentIndex == index
                                  ? AppColors.secondary
                                  : AppColors.white.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          );
                        }),
                      ),
                    if (pageData.showDots) SizedBox(height: 32.h),
                    Text(
                      pageData.title,
                      style: AppTextStyle(context).boldTextStyle(
                        fontSize: AppTextStyle.display,
                        color: AppColors.white,
                      ),
                    ),

                    Text(
                      pageData.subtitle,
                      style: AppTextStyle(context).regularTextStyle(
                        fontSize: AppTextStyle.lg,
                        color: AppColors.onboardingtext.withValues(alpha: 0.8),
                        lineHeight: 24,
                      ),
                    ),
                    SizedBox(height: 40.h),
                    ...pageData.buttons.map((btn) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: btn,
                      );
                    }),
                    SizedBox(height: 16.h),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
