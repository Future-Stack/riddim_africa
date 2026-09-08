import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import 'package:riddimafrica/features/authentication/presentation/controllers/auth_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

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
            color: AppColors.textfieldelementcolor,
            fontSize: AppTextStyle.xl,
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
                        ImagePath.mail,
                        height: 40.h,
                        width: 40.w,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 32.h),
                  Text(
                    'We will send you a verification code to reset your password. Enter the email address associated with your account.',
                    textAlign: TextAlign.center,
                    style: AppTextStyle(context).regularTextStyle(
                      fontSize: AppTextStyle.md,
                      color: AppColors.textfieldelementcolor,
                      lineHeight: 24,
                    ),
                  ),
                  SizedBox(height: 32.h),
                  ProTextField(
                    controller: controller.forgotEmailController,
                    labelText: 'Email',
                    hintText: 'Enter your email address',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const Spacer(),
                  ProElevatedButton(
                    text: 'Send',
                    gradient: const LinearGradient(
                      colors: [AppColors.secondary, AppColors.secondary],
                    ),
                    onPressed: controller.onForgotPasswordSend,
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
