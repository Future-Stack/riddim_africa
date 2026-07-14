import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import 'package:riddimafrica/core/common/common_button/common_button.dart';
import 'package:riddimafrica/core/common/common_text_field/pro_text_field.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  String selectedRole = 'User';

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
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Image.asset(
                  ImagePath.logo,
                  height: 80.h,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 16.h),
              Center(
                child: Text(
                  'Profile Setup',
                  style: AppTextStyle(context).boldTextStyle(
                    fontSize: AppTextStyle.title,
                    color: AppColors.white,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Center(
                child: Text(
                  'Select Your Role to Riddim Africa',
                  style: AppTextStyle(context).regularTextStyle(
                    fontSize: AppTextStyle.md,
                    color: AppColors.white.withValues(alpha: 0.8),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildRoleRadio('User'),
                  SizedBox(width: 16.w),
                  _buildRoleRadio('Artist'),
                  SizedBox(width: 16.w),
                  _buildRoleRadio('Seller'),
                ],
              ),
              SizedBox(height: 24.h),
              const ProTextField(
                labelText: 'Full Name',
                hintText: 'Enter Full Name',
              ),
              SizedBox(height: 16.h),
              const ProTextField(
                labelText: 'Username',
                hintText: 'Enter Username',
              ),
              SizedBox(height: 16.h),
              const ProTextField(
                labelText: 'Email Address',
                hintText: 'Enter email Address',
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.h),
              const ProTextField(
                labelText: 'Phone Number',
                hintText: 'Enter phone Number',
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 16.h),
              const ProTextField(
                labelText: 'City',
                hintText: 'Enter Your City',
              ),
              SizedBox(height: 16.h),
              const ProTextField(
                labelText: 'Country',
                hintText: 'Enter Your Country Name',
              ),
              SizedBox(height: 16.h),
              const ProTextField(
                labelText: 'Password',
                hintText: 'Create a strong password',
                obscureText: true,
                suffixIcon: Icon(Icons.visibility_outlined, color: AppColors.bordercolor),
              ),
              SizedBox(height: 16.h),
              const ProTextField(
                labelText: 'Confirm Password',
                hintText: 'Confirm Your Password',
                obscureText: true,
                suffixIcon: Icon(Icons.visibility_outlined, color: AppColors.bordercolor),
              ),
              SizedBox(height: 24.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 24.h,
                    width: 24.w,
                    child: Checkbox(
                      value: false,
                      onChanged: (val) {},
                      side: const BorderSide(color: AppColors.bordercolor),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      fillColor: WidgetStateProperty.resolveWith((states) {
                        if (states.contains(WidgetState.selected)) {
                          return AppColors.bordercolor;
                        }
                        return AppColors.textfieldcolor;
                      }),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'I agree to the ',
                        style: AppTextStyle(context).regularTextStyle(
                          fontSize: AppTextStyle.sm,
                          color: AppColors.onboardingtext,
                        ),
                        children: [
                          TextSpan(
                            text: 'Privacy Policy',
                            style: const TextStyle(decoration: TextDecoration.underline),
                          ),
                          const TextSpan(text: ' & '),
                          TextSpan(
                            text: 'Terms and Condition',
                            style: const TextStyle(decoration: TextDecoration.underline),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.h),
              ProElevatedButton(
                text: 'Create Account',
                trailingIcon: Icons.arrow_forward_ios,
                iconSize: 16,
                gradient: const LinearGradient(
                  colors: [AppColors.secondary, AppColors.secondary],
                ),
                onPressed: () {},
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleRadio(String role) {
    bool isSelected = selectedRole == role;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedRole = role;
        });
      },
      child: Row(
        children: [
          Container(
            width: 20.w,
            height: 20.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? AppColors.bordercolor : AppColors.onboardingtext,
                width: 2,
              ),
            ),
            child: isSelected
                ? Center(
                    child: Container(
                      width: 10.w,
                      height: 10.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.bordercolor,
                      ),
                    ),
                  )
                : null,
          ),
          SizedBox(width: 8.w),
          Text(
            role,
            style: AppTextStyle(context).mediumTextStyle(
              fontSize: AppTextStyle.md,
              color: isSelected ? AppColors.white : AppColors.onboardingtext,
            ),
          ),
        ],
      ),
    );
  }
}
