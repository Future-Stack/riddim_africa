import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import 'package:riddimafrica/core/common/common_button/common_button.dart';
import 'package:riddimafrica/core/common/common_text_field/pro_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:riddimafrica/routes/app_routes.dart';
import 'package:riddimafrica/features/authentication/presentation/controllers/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage(ImagePath.onboard5),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              AppColors.primary.withValues(alpha: 0.8),
              BlendMode.darken,
            ),
          ),
        ),
        child: SafeArea(
          child: GetBuilder<AuthController>(
            builder: (controller) {
              return CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 24.h,
                    ),
                    sliver: SliverFillRemaining(
                      hasScrollBody: false,
                      child: Form(
                        key: controller.loginFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Spacer(flex: 2),
                            ProTextField(
                              controller: controller.loginEmailController,
                              labelText: 'Email / Phone Number',
                              hintText: 'Enter email or phone',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email or phone number';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16.h),
                            ProTextField(
                              controller: controller.loginPasswordController,
                              labelText: 'Password',
                              hintText: 'Enter password',
                              obscureText: controller.obscureLoginPassword,
                              suffixIcon: GestureDetector(
                                onTap: controller.toggleLoginPasswordVisibility,
                                child: Icon(
                                  controller.obscureLoginPassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: AppColors.bordercolor,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
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
                                        value: controller.rememberMe,
                                        onChanged: controller.toggleRememberMe,
                                        side: const BorderSide(
                                          color: AppColors.onboardingtext,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                        fillColor:
                                            WidgetStateProperty.resolveWith((
                                              states,
                                            ) {
                                              if (states.contains(
                                                WidgetState.selected,
                                              )) {
                                                return AppColors.bordercolor;
                                              }
                                              return AppColors.textfieldcolor;
                                            }),
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      'Remember me',
                                      style: AppTextStyle(context)
                                          .regularTextStyle(
                                            fontSize: AppTextStyle.md,
                                            color: AppColors.onboardingtext,
                                          ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () => Get.toNamed(
                                    AppRoute.forgotPasswordScreen,
                                  ),
                                  child: Text(
                                    'Forgot Password?',
                                    style: AppTextStyle(context)
                                        .mediumTextStyle(
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
                              isLoading: controller.isLoading.value,
                              gradient: const LinearGradient(
                                colors: [
                                  AppColors.secondary,
                                  AppColors.secondary,
                                ],
                              ),
                              onPressed: controller.onLoginSubmit,
                            ),
                            SizedBox(height: 32.h),
                            Row(
                              children: [
                                const Expanded(
                                  child: Divider(
                                    color: AppColors.textfieldelementcolor,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                  ),
                                  child: Text(
                                    'or continue with',
                                    style: AppTextStyle(context)
                                        .regularTextStyle(
                                          fontSize: AppTextStyle.sm,
                                          color:
                                              AppColors.textfieldelementcolor,
                                        ),
                                  ),
                                ),
                                const Expanded(
                                  child: Divider(
                                    color: AppColors.textfieldelementcolor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 24.h),
                            ProElevatedButton(
                              text: 'Continue with Google',
                              backgroundColor: AppColors.primaryappbrown,
                              border: const BorderSide(
                                color: AppColors.primaryappbrownsecond,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    IconPath.google,
                                    height: 24.h,
                                  ),
                                  SizedBox(width: 12.w),
                                  Text(
                                    'Continue with Google',
                                    style: AppTextStyle(context)
                                        .mediumTextStyle(
                                          color:
                                              AppColors.textfieldelementcolor,
                                          fontSize: AppTextStyle.md,
                                        ),
                                  ),
                                ],
                              ),
                              onPressed: () {},
                            ),
                            SizedBox(height: 16.h),
                            ProElevatedButton(
                              text: 'Continue with Apple',
                              backgroundColor: AppColors.primaryappbrown,
                              border: const BorderSide(
                                color: AppColors.primaryappbrownsecond,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    IconPath.apple,
                                    height: 24.h,
                                    colorFilter: const ColorFilter.mode(
                                      AppColors.white,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Text(
                                    'Continue with Apple',
                                    style: AppTextStyle(context)
                                        .mediumTextStyle(
                                          color:
                                              AppColors.textfieldelementcolor,
                                          fontSize: AppTextStyle.md,
                                        ),
                                  ),
                                ],
                              ),
                              onPressed: () {},
                            ),
                            SizedBox(height: 10.h),
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
                                  onTap: () =>
                                      Get.toNamed(AppRoute.signupScreen),
                                  child: Text(
                                    "Create Account",
                                    style: AppTextStyle(context)
                                        .mediumTextStyle(
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
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
