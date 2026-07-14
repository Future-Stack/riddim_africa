import 'package:flutter/material.dart';
import 'package:riddimafrica/core/core.dart';
import 'package:riddimafrica/core/common/common_button/common_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImagePath.onboard2),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      Center(
                        child: Image.asset(
                          ImagePath.onlogo3,
                          height: 100.h,
                          width: 250.w,
                          fit: BoxFit.contain,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          children: [
                            Text(
                              'Welcome to Riddim Africa',
                              style: AppTextStyle(context).boldTextStyle(
                                fontSize: 22,
                                color: AppColors.white,
                              ),
                            ),
                            Text(
                              'Your gateway to African music & culture',
                              style: AppTextStyle(context).regularTextStyle(
                                fontSize: AppTextStyle.lg,
                                color: AppColors.onboardingtext.withValues(
                                  alpha: 0.8,
                                ),
                                lineHeight: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40.h),
                      Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: ProElevatedButton(
                          text: 'Log In',
                          gradient: const LinearGradient(
                            colors: [AppColors.secondary, AppColors.secondary],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          textColor: AppColors.white,
                          showGlow: true,
                          glowColor: AppColors.secondary.withValues(alpha: 0.5),
                          onPressed: () {
                            debugPrint("Navigate to actual login form/logic");
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: ProElevatedButton(
                          text: 'Create Account',
                          backgroundColor: Colors.transparent,
                          textColor: AppColors.white,
                          border: const BorderSide(
                            color: AppColors.secondary,
                            width: 1,
                          ),
                          onPressed: () {
                            debugPrint("Navigate to register form/logic");
                          },
                        ),
                      ),
                      SizedBox(height: 16.h),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
