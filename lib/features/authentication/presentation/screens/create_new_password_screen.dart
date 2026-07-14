import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import 'package:riddimafrica/core/common/common_button/common_button.dart';
import 'package:riddimafrica/core/common/common_text_field/pro_text_field.dart';

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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Center(
                child: Container(
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    color: AppColors.textfieldcolor.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.lock_reset,
                    size: 40,
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
              const ProTextField(
                labelText: 'Enter New Password',
                hintText: '••••••••',
                obscureText: true,
                suffixIcon: Icon(
                  Icons.visibility_off_outlined,
                  color: AppColors.bordercolor,
                ),
              ),
              SizedBox(height: 16.h),
              const ProTextField(
                labelText: 'Confirm New Password',
                hintText: '••••••••',
                obscureText: true,
                suffixIcon: Icon(
                  Icons.visibility_off_outlined,
                  color: AppColors.bordercolor,
                ),
              ),
              const Spacer(),
              ProElevatedButton(
                text: 'Update Password',
                gradient: const LinearGradient(
                  colors: [AppColors.secondary, AppColors.secondary],
                ),
                onPressed: () {
                  // Navigate back to login
                  Get.offAllNamed('/loginScreen');
                },
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
