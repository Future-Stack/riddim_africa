import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import 'package:riddimafrica/core/common/common_button/common_button.dart';
import 'package:riddimafrica/core/common/common_text_field/pro_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:riddimafrica/routes/app_routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage(ImagePath.backgrund),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              AppColors.primary.withValues(alpha: 0.8),
              BlendMode.darken,
            ),
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.25),
                const ProTextField(
                  labelText: 'Email / Phone Number',
                  hintText: 'Enter email or phone',
                ),
                SizedBox(height: 16.h),
                const ProTextField(
                  labelText: 'Password',
                  hintText: 'Enter password',
                  obscureText: true,
                  suffixIcon: Icon(Icons.visibility_outlined, color: AppColors.bordercolor),
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 24.h,
                          width: 24.w,
                          child: Checkbox(
                            value: false,
                            onChanged: (val) {},
                            side: const BorderSide(color: AppColors.onboardingtext),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Remember me',
                          style: AppTextStyle(context).regularTextStyle(
                            fontSize: AppTextStyle.md,
                            color: AppColors.onboardingtext,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed(AppRoute.forgotPasswordScreen),
                      child: Text(
                        'Forgot Password?',
                        style: AppTextStyle(context).mediumTextStyle(
                          fontSize: AppTextStyle.md,
                          color: AppColors.secondary,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                ProElevatedButton(
                  text: 'Log In',
                  gradient: const LinearGradient(
                    colors: [AppColors.secondary, AppColors.secondary],
                  ),
                  onPressed: () {
                    // Navigate to user bottom nav logic
                  },
                ),
                SizedBox(height: 32.h),
                Row(
                  children: [
                    const Expanded(child: Divider(color: AppColors.textfieldcolor)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        'or continue with',
                        style: AppTextStyle(context).regularTextStyle(
                          fontSize: AppTextStyle.sm,
                          color: AppColors.onboardingtext,
                        ),
                      ),
                    ),
                    const Expanded(child: Divider(color: AppColors.textfieldcolor)),
                  ],
                ),
                SizedBox(height: 24.h),
                ProElevatedButton(
                  text: 'Continue with Google',
                  backgroundColor: Colors.transparent,
                  border: const BorderSide(color: AppColors.textfieldcolor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(IconPath.google, height: 24.h),
                      SizedBox(width: 12.w),
                      Text(
                        'Continue with Google',
                        style: AppTextStyle(context).mediumTextStyle(fontSize: AppTextStyle.md),
                      ),
                    ],
                  ),
                  onPressed: () {},
                ),
                SizedBox(height: 16.h),
                ProElevatedButton(
                  text: 'Continue with Apple',
                  backgroundColor: Colors.transparent,
                  border: const BorderSide(color: AppColors.textfieldcolor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(IconPath.apple, height: 24.h, colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn)),
                      SizedBox(width: 12.w),
                      Text(
                        'Continue with Apple',
                        style: AppTextStyle(context).mediumTextStyle(fontSize: AppTextStyle.md),
                      ),
                    ],
                  ),
                  onPressed: () {},
                ),
                SizedBox(height: 32.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: AppTextStyle(context).regularTextStyle(
                        fontSize: AppTextStyle.md,
                        color: AppColors.onboardingtext,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed(AppRoute.signupScreen),
                      child: Text(
                        "Create Account",
                        style: AppTextStyle(context).mediumTextStyle(
                          fontSize: AppTextStyle.md,
                          color: AppColors.secondary,
                        ),
                      ),
                    ),
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
