import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import 'package:riddimafrica/core/common/common_button/common_button.dart';
import 'package:riddimafrica/core/common/common_text_field/pro_text_field.dart';
import 'package:riddimafrica/features/authentication/presentation/controllers/auth_controller.dart';

class ProfileSetupScreen extends StatelessWidget {
  const ProfileSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Create Account',
          style: AppTextStyle(context).boldTextStyle(
            color: AppColors.textfieldelementcolor,
            fontSize: AppTextStyle.xl,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: GetBuilder<AuthController>(
          builder: (controller) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Image.asset(
                      ImagePath.onlogo3,
                      height: 80.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Center(
                    child: Text(
                      'Profile Setup',
                      style: AppTextStyle(context).boldTextStyle(
                        fontSize: AppTextStyle.title,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
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
                      _buildRoleRadio(context, controller, 'User'),
                      SizedBox(width: 16.w),
                      _buildRoleRadio(context, controller, 'Artist'),
                      SizedBox(width: 16.w),
                      _buildRoleRadio(context, controller, 'Seller'),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  ProTextField(
                    controller: controller.signupNameController,
                    labelText: 'Full Name',
                    hintText: 'Enter Full Name',
                  ),
                  SizedBox(height: 16.h),
                  ProTextField(
                    controller: controller.signupUsernameController,
                    labelText: 'Username',
                    hintText: 'Enter Username',
                  ),
                  SizedBox(height: 16.h),
                  ProTextField(
                    controller: controller.signupEmailController,
                    labelText: 'Email Address',
                    hintText: 'Enter email Address',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 16.h),
                  ProTextField(
                    controller: controller.signupPhoneController,
                    labelText: 'Phone Number',
                    hintText: 'Enter phone Number',
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 16.h),
                  ProTextField(
                    controller: controller.signupCityController,
                    labelText: 'City',
                    hintText: 'Enter Your City',
                  ),
                  SizedBox(height: 16.h),
                  ProTextField(
                    controller: controller.signupCountryController,
                    labelText: 'Country',
                    hintText: 'Enter Your Country Name',
                  ),
                  SizedBox(height: 16.h),
                  ProTextField(
                    controller: controller.signupPasswordController,
                    labelText: 'Password',
                    hintText: 'Create a strong password',
                    obscureText: controller.obscureSignupPassword,
                    suffixIcon: GestureDetector(
                      onTap: controller.toggleSignupPasswordVisibility,
                      child: Icon(
                        controller.obscureSignupPassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.bordercolor,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  ProTextField(
                    controller: controller.signupConfirmPasswordController,
                    labelText: 'Confirm Password',
                    hintText: 'Confirm Your Password',
                    obscureText: controller.obscureSignupConfirmPassword,
                    suffixIcon: GestureDetector(
                      onTap: controller.toggleSignupConfirmPasswordVisibility,
                      child: Icon(
                        controller.obscureSignupConfirmPassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.bordercolor,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 24.h,
                        width: 24.h,
                        child: Checkbox(
                          value: controller.agreeTerms,
                          onChanged: controller.toggleAgreeTerms,
                          side: const BorderSide(color: AppColors.bordercolor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          fillColor: WidgetStateProperty.resolveWith((states) {
                            if (states.contains(WidgetState.selected)) {
                              return AppColors.bordercolor;
                            }
                            return AppColors.textfieldcolor;
                          }),
                        ),
                      ),
                      SizedBox(width: 5.w),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            text: 'I agree to the ',
                            style: AppTextStyle(context).regularTextStyle(
                              fontSize: AppTextStyle.sm,
                              color: AppColors.onboardingtext,
                            ),
                            children: const [
                              TextSpan(
                                text: 'Privacy Policy',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(text: ' & '),
                              TextSpan(
                                text: 'Terms and Condition',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                ),
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
                    onPressed: controller.onSignupSubmit,
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

  Widget _buildRoleRadio(
    BuildContext context,
    AuthController controller,
    String role,
  ) {
    bool isSelected = controller.selectedRole == role;
    return GestureDetector(
      onTap: () => controller.setRole(role),
      child: Row(
        children: [
          Container(
            width: 20.w,
            height: 20.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected
                    ? AppColors.bordercolor
                    : AppColors.onboardingtext,
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
