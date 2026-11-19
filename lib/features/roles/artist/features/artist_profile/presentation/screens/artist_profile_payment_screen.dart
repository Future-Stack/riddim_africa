import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import '../../controllers/artist_payment_controller.dart';

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
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'Payment method',
                style: AppTextStyle(context).boldTextStyle(
                  fontSize: 16.sp,
                  color: const Color(0xFFD49B53),
                ),
              ),
              6.verticalSpace,

              // Subtitle
              Text(
                'Add your payment information to receive earnings from your successful product sales.',
                style: AppTextStyle(context).regularTextStyle(
                  fontSize: 12.sp,
                  color: AppColors.primarytext,
                  lineHeight: 18,
                ),
              ),
              24.verticalSpace,

              // Payment Method Dropdown
              Text(
                'Payment Method',
                style: AppTextStyle(context).mediumTextStyle(
                  fontSize: 12.sp,
                  color: AppColors.primarytext,
                ),
              ),
              6.verticalSpace,
              Obx(
                () => Container(
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E242B),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: controller.selectedPaymentMethod.value,
                      hint: Text(
                        'Enter Payment Method',
                        style: AppTextStyle(context).regularTextStyle(
                          fontSize: 13.sp,
                          color: AppColors.primarytext.withValues(alpha: 0.5),
                        ),
                      ),
                      isExpanded: true,
                      dropdownColor: const Color(0xFF22140A),
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.primarytext,
                        size: 20.sp,
                      ),
                      items: controller.paymentMethods
                          .map(
                            (method) => DropdownMenuItem(
                              value: method,
                              child: Text(
                                method,
                                style: AppTextStyle(context).regularTextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (val) {
                        if (val != null) controller.setPaymentMethod(val);
                      },
                    ),
                  ),
                ),
              ),
              16.verticalSpace,

              // Account Holder Name
              Text(
                'Account Holder Name',
                style: AppTextStyle(context).mediumTextStyle(
                  fontSize: 12.sp,
                  color: AppColors.primarytext,
                ),
              ),
              6.verticalSpace,
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1E242B),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: TextFormField(
                  controller: controller.accountHolderController,
                  style: AppTextStyle(context).regularTextStyle(
                    fontSize: 13.sp,
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter Account Holder Name',
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
                  ),
                ),
              ),
              16.verticalSpace,

              // Mobile Money Number
              Text(
                'Mobile Money Number',
                style: AppTextStyle(context).mediumTextStyle(
                  fontSize: 12.sp,
                  color: AppColors.primarytext,
                ),
              ),
              6.verticalSpace,
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1E242B),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: TextFormField(
                  controller: controller.mobileMoneyNumberController,
                  keyboardType: TextInputType.phone,
                  style: AppTextStyle(context).regularTextStyle(
                    fontSize: 13.sp,
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter Mobile Money Number',
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
                  ),
                ),
              ),

              const Spacer(),

              // Save Changes Button
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: controller.isSaving.value
                        ? null
                        : () => controller.savePaymentDetails(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      elevation: 0,
                    ),
                    child: controller.isSaving.value
                        ? SizedBox(
                            width: 20.w,
                            height: 20.w,
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'Save Payment Method',
                            style: AppTextStyle(context).boldTextStyle(
                              fontSize: 14.sp,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ),
              12.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
