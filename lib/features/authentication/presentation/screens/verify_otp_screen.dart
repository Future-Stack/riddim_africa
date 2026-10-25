import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import 'package:riddimafrica/features/authentication/presentation/controllers/auth_controller.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  late String email;
  late String role;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args is Map) {
      email = args['email'] ?? '';
      role = args['role'] ?? 'User';
    } else {
      final controller = Get.find<AuthController>();
      email = controller.signupEmailController.text.trim();
      role = controller.selectedRole;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = Get.find<AuthController>();
      controller.clearRegOtpFields();
      controller.startOtpTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.backgroundcolor,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.cardBorder),
            ),
            child: const Icon(
              Icons.arrow_back,
              color: AppColors.white,
              size: 18,
            ),
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'OTP Verification',
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
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20.h),
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(18.h),
                      decoration: BoxDecoration(
                        color: AppColors.textfieldcolor.withValues(alpha: 0.5),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.secondary.withValues(alpha: 0.3),
                          width: 2,
                        ),
                      ),
                      child: Image.asset(
                        ImagePath.lock,
                        height: 48.h,
                        width: 48.w,
                        color: AppColors.secondary,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    'Verify Your Email',
                    textAlign: TextAlign.center,
                    style: AppTextStyle(context).boldTextStyle(
                      fontSize: AppTextStyle.title,
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "We've sent a 4-digit verification code to\n",
                      style: AppTextStyle(context).regularTextStyle(
                        fontSize: AppTextStyle.md,
                        color: AppColors.onboardingtext,
                        lineHeight: 22,
                      ),
                      children: [
                        TextSpan(
                          text: email.isNotEmpty ? email : 'your email address',
                          style: AppTextStyle(context).boldTextStyle(
                            fontSize: AppTextStyle.md,
                            color: AppColors.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.timer_outlined,
                          size: 16,
                          color: AppColors.onboardingbutton,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          controller.formattedOtpTime,
                          style: AppTextStyle(context).mediumTextStyle(
                            fontSize: AppTextStyle.md,
                            color: AppColors.onboardingbutton,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32.h),

                  // 4 OTP digit boxes
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      4,
                      (index) => _buildOtpBox(context, controller, index),
                    ),
                  ),
                  const Spacer(),

                  // Verify Button
                  Obx(
                    () => ProElevatedButton(
                      text: 'Verify & Proceed',
                      isLoading: controller.isOtpVerifying.value,
                      gradient: const LinearGradient(
                        colors: [AppColors.secondary, AppColors.secondary],
                      ),
                      onPressed: controller.isOtpVerifying.value
                          ? null
                          : () {
                              controller.verifyRegistrationOtp(
                                email: email,
                                role: role,
                              );
                            },
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Resend Code Section
                  Center(
                    child: Obx(() {
                      final canResend = controller.otpCountdown.value == 0;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Didn't receive any code? ",
                            style: AppTextStyle(context).regularTextStyle(
                              fontSize: AppTextStyle.sm,
                              color: AppColors.onboardingtext,
                            ),
                          ),
                          GestureDetector(
                            onTap: canResend && !controller.isResendingOtp.value
                                ? () => controller.resendRegistrationOtp(email)
                                : null,
                            child: controller.isResendingOtp.value
                                ? const SizedBox(
                                    height: 14,
                                    width: 14,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: AppColors.secondary,
                                    ),
                                  )
                                : Text(
                                    'Resend Code',
                                    style: AppTextStyle(context).boldTextStyle(
                                      fontSize: AppTextStyle.sm,
                                      color: canResend
                                          ? AppColors.secondary
                                          : AppColors.onboardingtext.withValues(
                                              alpha: 0.5,
                                            ),
                                    ),
                                  ),
                          ),
                        ],
                      );
                    }),
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
    final hasFocus = controller.regOtpFocusNodes[index].hasFocus;
    return Container(
      width: 64.w,
      height: 55.h,
      decoration: BoxDecoration(
        color: AppColors.textfieldcolor.withValues(alpha: 0.35),
        border: Border.all(
          color: hasFocus
              ? AppColors.secondary
              : (controller.regOtpControllers[index].text.isNotEmpty
                    ? AppColors.bordercolor
                    : AppColors.onboardingbutton.withValues(alpha: 0.4)),
          width: hasFocus ? 2 : 1.2,
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: hasFocus
            ? [
                BoxShadow(
                  color: AppColors.secondary.withValues(alpha: 0.25),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
      alignment: Alignment.center,
      child: TextField(
        controller: controller.regOtpControllers[index],
        focusNode: controller.regOtpFocusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: AppTextStyle(
          context,
        ).boldTextStyle(fontSize: 26, color: AppColors.white),
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        onChanged: (value) => controller.onRegOtpChanged(value, index),
        onTap: () => controller.update(),
      ),
    );
  }
}
