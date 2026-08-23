import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import '../controllers/artist_payment_controller.dart';

class ArtistProfilePaymentScreen extends StatelessWidget {
  const ArtistProfilePaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<ArtistPaymentController>()
        ? Get.find<ArtistPaymentController>()
        : Get.put(ArtistPaymentController());

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: const GlobalAppBar(
        title: 'Payment',
        showDivider: false,
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Obx(
            () => ProElevatedButton(
              text: 'Save Payment Method',
              isLoading: controller.isSaving.value,
              onPressed: () => controller.savePaymentDetails(),
              backgroundColor: AppColors.secondary,
              borderRadius: 14,
              height: 52,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ─── Header Section ─────────────────────────────────────────
              Text(
                'Payment method',
                style: AppTextStyle(context).boldTextStyle(
                  fontSize: 20.sp,
                  color: const Color(0xFFD49B53),
                ),
              ),
              8.verticalSpace,
              Text(
                'Add your payment information to receive earnings from your successful product sales.',
                style: AppTextStyle(context).regularTextStyle(
                  fontSize: 13.sp,
                  color: AppColors.primarytext,
                  lineHeight: 18,
                ),
              ),
              28.verticalSpace,

              // ─── 1. Payment Method Dropdown ─────────────────────────────
              Text(
                'Payment Method',
                style: AppTextStyle(context).mediumTextStyle(
                  fontSize: 13.sp,
                  color: AppColors.primarytext,
                ),
              ),
              8.verticalSpace,
              Obx(
                () => Container(
                  height: 54.h,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: AppColors.textfieldcolor, // #212B36 dark slate/teal
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppColors.textfieldcolor,
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: controller.selectedPaymentMethod.value,
                      isExpanded: true,
                      dropdownColor: const Color(0xFF22140A),
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppColors.white.withValues(alpha: 0.7),
                        size: 22.sp,
                      ),
                      items: controller.paymentMethods.map((method) {
                        return DropdownMenuItem<String>(
                          value: method,
                          child: Text(
                            method,
                            style: AppTextStyle(context).regularTextStyle(
                              fontSize: 14.sp,
                              color: AppColors.white,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          controller.setPaymentMethod(val);
                        }
                      },
                    ),
                  ),
                ),
              ),
              20.verticalSpace,

              // ─── 2. Account Holder Name ─────────────────────────────────
              Text(
                'Account Holder Name',
                style: AppTextStyle(context).mediumTextStyle(
                  fontSize: 13.sp,
                  color: AppColors.primarytext,
                ),
              ),
              8.verticalSpace,
              Container(
                decoration: BoxDecoration(
                  color: AppColors.textfieldcolor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: TextFormField(
                  controller: controller.accountHolderController,
                  style: AppTextStyle(context).regularTextStyle(
                    fontSize: 14.sp,
                    color: AppColors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter Account Holder Name',
                    hintStyle: AppTextStyle(context).regularTextStyle(
                      fontSize: 14.sp,
                      color: AppColors.white.withValues(alpha: 0.4),
                    ),
                    filled: true,
                    fillColor: AppColors.textfieldcolor,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(color: AppColors.textfieldcolor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(color: AppColors.textfieldcolor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(color: AppColors.bordercolor),
                    ),
                  ),
                ),
              ),
              20.verticalSpace,

              // ─── 3. Mobile Money Number ─────────────────────────────────
              Text(
                'Mobile Money Number',
                style: AppTextStyle(context).mediumTextStyle(
                  fontSize: 13.sp,
                  color: AppColors.primarytext,
                ),
              ),
              8.verticalSpace,
              Container(
                decoration: BoxDecoration(
                  color: AppColors.textfieldcolor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: TextFormField(
                  controller: controller.mobileMoneyNumberController,
                  keyboardType: TextInputType.phone,
                  style: AppTextStyle(context).regularTextStyle(
                    fontSize: 14.sp,
                    color: AppColors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter Mobile Money Number',
                    hintStyle: AppTextStyle(context).regularTextStyle(
                      fontSize: 14.sp,
                      color: AppColors.white.withValues(alpha: 0.4),
                    ),
                    filled: true,
                    fillColor: AppColors.textfieldcolor,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(color: AppColors.textfieldcolor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(color: AppColors.textfieldcolor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(color: AppColors.bordercolor),
                    ),
                  ),
                ),
              ),
              30.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
