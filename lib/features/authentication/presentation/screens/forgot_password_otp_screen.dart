import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import 'package:riddimafrica/features/authentication/presentation/controllers/auth_controller.dart';

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
          style: AppTextStyle(context).boldTextStyle(
            fontSize: AppTextStyle.xl,
            color: AppColors.textfieldelementcolor,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: GetBuilder<AuthController>(
          builder: (controller) {
            return Padding(
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
                  Obx(() => RichText(
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
                          text: controller.formattedForgotOtpTime,
                          style: AppTextStyle(context).mediumTextStyle(
                            fontSize: AppTextStyle.md,
                            color: AppColors.onboardingbutton,
                          ),
                        ),
                      ],
                    ),
                  )),
                  SizedBox(height: 32.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      4,
                      (index) => _buildOtpBox(context, controller, index),
                    ),
                  ),
                  const Spacer(),
                  ProElevatedButton(
                    text: 'Verify',
                    isLoading: controller.isForgotOtpVerifying.value,
                    gradient: const LinearGradient(
                      colors: [AppColors.secondary, AppColors.secondary],
                    ),
                    onPressed: () => controller.verifyOtp(),
                  ),
                  SizedBox(height: 24.h),
                  Center(
                    child: GestureDetector(
                      onTap: controller.forgotOtpCountdown.value == 0 ||
                              !controller.isForgotOtpResending.value
                          ? () => controller.resendForgotPasswordOtp()
                          : null,
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
                                color: AppColors.secondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildOtpBox(
    BuildContext context,
    AuthController controller,
    int index,
  ) {
    return Container(
      width: 62,
      height: 73,
      decoration: BoxDecoration(
        color: AppColors.textfieldcolor.withValues(alpha: 0.3),
        border: Border.all(
          color: controller.otpFocusNodes[index].hasFocus
              ? AppColors.bordercolor
              : AppColors.onboardingbutton.withValues(alpha: 0.5),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: TextField(
        controller: controller.otpControllers[index],
        focusNode: controller.otpFocusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: AppTextStyle(
          context,
        ).boldTextStyle(fontSize: 28, color: AppColors.white),
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        onChanged: (value) => controller.onOtpChanged(value, index),
        onTap: () => controller.update(), // trigger rebuild to show focus color
      ),
    );
  }
}
