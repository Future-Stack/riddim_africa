import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:riddimafrica/core/core.dart';
import 'package:riddimafrica/features/bottom_nav/presentation/controllers/seller_bottom_nav_controller.dart';
import 'package:riddimafrica/features/bottom_nav/domain/entities/nav_model.dart';
import '../../controllers/seller_delete_account_controller.dart';

class SellerDeleteAccountScreen extends StatelessWidget {
  const SellerDeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SellerDeleteAccountController());

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leadingWidth: 56.w,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF271B16),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ),
        title: Text(
          'Delete Account',
          style: AppTextStyle(context).boldTextStyle(
            fontSize: 18.sp,
            color: Colors.white,
          ),
        ),
        centerTitle: false,
      ),
      bottomNavigationBar: _buildBottomBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              16.verticalSpace,

              // Top Red Trash Icon Badge
              Center(
                child: Container(
                  width: 58.w,
                  height: 58.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFBE4E2),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.delete_outline_rounded,
                      color: const Color(0xFFE53935),
                      size: 30.sp,
                    ),
                  ),
                ),
              ),
              18.verticalSpace,

              // Description Text
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Text(
                    "We're sorry to see you go. Deleting your account will permanently remove your access to Riddim Africa and cannot be undone.",
                    textAlign: TextAlign.center,
                    style: AppTextStyle(context).regularTextStyle(
                      fontSize: 12.5.sp,
                      color: AppColors.primarytext,
                      lineHeight: 18,
                    ),
                  ),
                ),
              ),
              36.verticalSpace,

              // Subheader
              Text(
                'Please enter your password to continue.',
                style: AppTextStyle(context).mediumTextStyle(
                  fontSize: 13.sp,
                  color: Colors.white70,
                ),
              ),
              16.verticalSpace,

              // Password Label
              Text(
                'Enter Password',
                style: AppTextStyle(context).mediumTextStyle(
                  fontSize: 12.sp,
                  color: AppColors.primarytext,
                ),
              ),
              6.verticalSpace,

              // Password Input Field
              Obx(
                () => Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF161E28),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: TextFormField(
                    controller: controller.passwordController,
                    obscureText: controller.isPasswordHidden.value,
                    style: AppTextStyle(context).regularTextStyle(
                      fontSize: 14.sp,
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: '••••••',
                      hintStyle: AppTextStyle(context).regularTextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xFF6C7C8E),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 14.h,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: const BorderSide(
                          color: Color(0xFF35C0AD),
                          width: 1.5,
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isPasswordHidden.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: const Color(0xFF6C7C8E),
                          size: 18.sp,
                        ),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                    ),
                  ),
                ),
              ),
              14.verticalSpace,

              // Checkbox Row
              Obx(
                () => GestureDetector(
                  onTap: () => controller.toggleAgreement(null),
                  behavior: HitTestBehavior.opaque,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 22.w,
                        height: 22.w,
                        child: Checkbox(
                          value: controller.isAgreed.value,
                          onChanged: controller.toggleAgreement,
                          activeColor: const Color(0xFFD49B53),
                          checkColor: Colors.black,
                          side: BorderSide(
                            color: const Color(0xFFD49B53)
                                .withValues(alpha: 0.6),
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                      ),
                      8.horizontalSpace,
                      Expanded(
                        child: Text(
                          'I understand this action cannot be undone.',
                          style: AppTextStyle(context).regularTextStyle(
                            fontSize: 11.5.sp,
                            color: AppColors.primarytext,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              36.verticalSpace,

              // Delete Account Button
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: controller.isDeleting.value
                        ? null
                        : () => controller.confirmDeleteAccount(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFBA473C),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      elevation: 0,
                    ),
                    child: controller.isDeleting.value
                        ? SizedBox(
                            width: 20.w,
                            height: 20.w,
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'Delete Account',
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

  Widget _buildBottomBar(BuildContext context) {
    final bottomNavController = Get.isRegistered<SellerBottomNavController>()
        ? Get.find<SellerBottomNavController>()
        : null;

    final selleritems = const [
      NavItem(title: 'Home', iconPath: IconPath.home),
      NavItem(title: 'Products', iconPath: IconPath.box),
      NavItem(title: 'Orders', iconPath: IconPath.cart),
      NavItem(title: 'Revenue', iconPath: IconPath.revenue),
      NavItem(title: 'Profile', iconPath: IconPath.profile),
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 24,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(
              selleritems.length,
              (index) {
                final item = selleritems[index];
                final isSelected = index == 4; // Profile active
                final selectedColor = AppColors.white;
                final unselectedColor = AppColors.primarytext;

                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (index != 4 && bottomNavController != null) {
                        Get.back();
                        bottomNavController.changeIndex(index);
                      }
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      padding: const EdgeInsets.only(top: 8, bottom: 4),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            item.iconPath,
                            width: 22,
                            height: 22,
                            colorFilter: ColorFilter.mode(
                              isSelected ? selectedColor : unselectedColor,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            item.title,
                            style: AppTextStyle(context).mediumTextStyle(
                              fontSize: 11.sp,
                              color:
                                  isSelected ? selectedColor : unselectedColor,
                            ),
                          ),
                          const SizedBox(height: 5),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            height: 2.5,
                            width: isSelected ? 20 : 0,
                            decoration: BoxDecoration(
                              color: selectedColor,
                              borderRadius: BorderRadius.circular(1.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
