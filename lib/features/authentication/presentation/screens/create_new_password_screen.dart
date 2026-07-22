import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import 'package:riddimafrica/features/authentication/presentation/controllers/auth_controller.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  const CreateNewPasswordScreen({super.key});

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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(14.h),
                      decoration: BoxDecoration(
                        color: AppColors.textfieldcolor.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image.asset(
                        ImagePath.lockKey,
                        height: 40.h,
                        width: 40.w,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 32.h),
                  Text(
                    'Create New Password',
                    style: AppTextStyle(context).boldTextStyle(
                      fontSize: AppTextStyle.xl,
                      color: AppColors.onboardingbutton,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  ProTextField(
                    controller: controller.newPasswordController,
                    labelText: 'Enter New Password',
                    hintText: '••••••••',
                    obscureText: controller.obscureNewPassword,
                    suffixIcon: GestureDetector(
                      onTap: controller.toggleNewPasswordVisibility,
                      child: Icon(
                        controller.obscureNewPassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.bordercolor,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  ProTextField(
                    controller: controller.confirmNewPasswordController,
                    labelText: 'Confirm New Password',
                    hintText: '••••••••',
                    obscureText: controller.obscureConfirmNewPassword,
                    suffixIcon: GestureDetector(
                      onTap: controller.toggleConfirmNewPasswordVisibility,
                      child: Icon(
                        controller.obscureConfirmNewPassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.bordercolor,
                      ),
                    ),
                  ),
                  const Spacer(),
                  ProElevatedButton(
                    text: 'Update Password',
                    gradient: const LinearGradient(
                      colors: [AppColors.secondary, AppColors.secondary],
                    ),
                    onPressed: controller.onUpdatePassword,
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
