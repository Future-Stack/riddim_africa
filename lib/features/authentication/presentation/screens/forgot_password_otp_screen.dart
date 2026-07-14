import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import 'package:riddimafrica/core/common/common_button/common_button.dart';
import 'package:riddimafrica/routes/app_routes.dart';

class ForgotPasswordOtpScreen extends StatelessWidget {
  const ForgotPasswordOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Forgot Password',
          style: AppTextStyle(context).boldTextStyle(fontSize: AppTextStyle.xl),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Center(
                child: Container(
                  padding: EdgeInsets.all(14.h),
                  decoration: BoxDecoration(
                    color: AppColors.textfieldcolor.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset(
                    ImagePath.lock,
                    height: 40.h,
                    width: 40.w,
                    color: AppColors.white,
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text:
                      "We've sent a verification code to your email address. This code will expire in ",
                  style: AppTextStyle(context).regularTextStyle(
                    fontSize: AppTextStyle.md,
                    color: AppColors.onboardingtext,
                    lineHeight: 24,
                  ),
                  children: [
                    TextSpan(
                      text: '01:56 s',
                      style: AppTextStyle(context).mediumTextStyle(
                        fontSize: AppTextStyle.md,
                        color: AppColors.onboardingbutton,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  4,
                  (index) => _buildOtpBox(context, ['8', '9', '4', '2'][index]),
                ),
              ),
              const Spacer(),
              ProElevatedButton(
                text: 'Verify',
                gradient: const LinearGradient(
                  colors: [AppColors.secondary, AppColors.secondary],
                ),
                onPressed: () => Get.toNamed(AppRoute.createNewPasswordScreen),
              ),
              SizedBox(height: 24.h),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Didn't Receive Any Code? ",
                    style: AppTextStyle(context).regularTextStyle(
                      fontSize: AppTextStyle.sm,
                      color: AppColors.onboardingtext,
                    ),
                    children: [
                      TextSpan(
                        text: 'Resend Code',
                        style: AppTextStyle(context).mediumTextStyle(
                          fontSize: AppTextStyle.sm,
                          color: AppColors.onboardingtext,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOtpBox(BuildContext context, String digit) {
    return Container(
      width: 60.w,
      height: 70.h,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: AppColors.onboardingbutton.withValues(alpha: 0.5),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Text(
        digit,
        style: AppTextStyle(
          context,
        ).boldTextStyle(fontSize: 28, color: AppColors.white),
      ),
    );
  }
}
