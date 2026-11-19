import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import 'package:riddimafrica/routes/app_routes.dart';
import '../../controllers/artist_change_password_controller.dart';
import '../widgets/artist_password_success_dialog.dart';

class ArtistChangePasswordScreen extends StatelessWidget {
  const ArtistChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<ArtistChangePasswordController>()
        ? Get.find<ArtistChangePasswordController>()
        : Get.put(ArtistChangePasswordController());

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: const GlobalAppBar(
        title: 'Change Password',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Lock Badge Icon
              Center(
                child: Container(
                  width: 54.w,
                  height: 54.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2B170C),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: const Color(0xFFD49B53).withValues(alpha: 0.3),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.lock_outline_rounded,
                      color: const Color(0xFFD49B53),
                      size: 26.sp,
                    ),
                  ),
                ),
              ),
              18.verticalSpace,

              // Header
              Text(
                'Change Password',
                style: AppTextStyle(context).boldTextStyle(
                  fontSize: 16.sp,
                  color: const Color(0xFFD49B53),
                ),
              ),
              18.verticalSpace,

              // Current Password Field
              Text(
                'Current Password',
                style: AppTextStyle(context).mediumTextStyle(
                  fontSize: 12.sp,
                  color: AppColors.primarytext,
                ),
              ),
              6.verticalSpace,
              Obx(
                () => Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E242B),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: TextFormField(
                    controller: controller.currentPasswordController,
                    obscureText: controller.obscureCurrent.value,
                    style: AppTextStyle(context).regularTextStyle(
                      fontSize: 13.sp,
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: '••••••••',
                      hintStyle: AppTextStyle(context).regularTextStyle(
                        fontSize: 13.sp,
                        color: AppColors.primarytext.withValues(alpha: 0.5),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 14.h,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(
                          color: Color(0xFF35C0AD),
                          width: 1.5,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(
                          color: Colors.redAccent,
                          width: 1,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(
                          color: Colors.redAccent,
                          width: 1.5,
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.obscureCurrent.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: AppColors.primarytext,
                          size: 18.sp,
                        ),
                        onPressed: controller.toggleCurrent,
                      ),
                    ),
                  ),
                ),
              ),
              6.verticalSpace,

              // Forgot Password link
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => Get.toNamed(AppRoute.forgotPasswordScreen),
                  child: Text(
                    'Forgot Password?',
                    style: AppTextStyle(context).mediumTextStyle(
                      fontSize: 11.sp,
                      color: const Color(0xFFD49B53),
                    ),
                  ),
                ),
              ),
              14.verticalSpace,

              // Create New Password
              Text(
                'Create New Password',
                style: AppTextStyle(context).mediumTextStyle(
                  fontSize: 12.sp,
                  color: AppColors.primarytext,
                ),
              ),
              6.verticalSpace,
              Obx(
                () => Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E242B),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: TextFormField(
                    controller: controller.newPasswordController,
                    obscureText: controller.obscureNew.value,
                    style: AppTextStyle(context).regularTextStyle(
                      fontSize: 13.sp,
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: '••••••••',
                      hintStyle: AppTextStyle(context).regularTextStyle(
                        fontSize: 13.sp,
                        color: AppColors.primarytext.withValues(alpha: 0.5),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 14.h,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(
                          color: Color(0xFF35C0AD),
                          width: 1.5,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(
                          color: Colors.redAccent,
                          width: 1,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(
                          color: Colors.redAccent,
                          width: 1.5,
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.obscureNew.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: AppColors.primarytext,
                          size: 18.sp,
                        ),
                        onPressed: controller.toggleNew,
                      ),
                    ),
                  ),
                ),
              ),
              14.verticalSpace,

              // Confirm New Password
              Text(
                'Confirm New Password',
                style: AppTextStyle(context).mediumTextStyle(
                  fontSize: 12.sp,
                  color: AppColors.primarytext,
                ),
              ),
              6.verticalSpace,
              Obx(
                () => Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E242B),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: TextFormField(
                    controller: controller.confirmPasswordController,
                    obscureText: controller.obscureConfirm.value,
                    style: AppTextStyle(context).regularTextStyle(
                      fontSize: 13.sp,
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: '••••••••',
                      hintStyle: AppTextStyle(context).regularTextStyle(
                        fontSize: 13.sp,
                        color: AppColors.primarytext.withValues(alpha: 0.5),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 14.h,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(
                          color: Color(0xFF35C0AD),
                          width: 1.5,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(
                          color: Colors.redAccent,
                          width: 1,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(
                          color: Colors.redAccent,
                          width: 1.5,
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.obscureConfirm.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: AppColors.primarytext,
                          size: 18.sp,
                        ),
                        onPressed: controller.toggleConfirm,
                      ),
                    ),
                  ),
                ),
              ),
              36.verticalSpace,

              // Update Password Button
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: controller.isUpdating.value
                        ? null
                        : () {
                            controller.updatePassword(() {
                              ArtistPasswordSuccessDialog.show(
                                context,
                                onClose: () => Get.back(),
                              );
                            });
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      elevation: 0,
                    ),
                    child: controller.isUpdating.value
                        ? SizedBox(
                            width: 20.w,
                            height: 20.w,
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'Update Password',
                            style: AppTextStyle(context).boldTextStyle(
                              fontSize: 15.sp,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ),
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
