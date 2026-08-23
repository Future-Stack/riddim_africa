import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import '../../domain/entities/artist_transaction_entity.dart';
import '../controllers/artist_request_payment_controller.dart';

class ArtistRequestPaymentScreen extends StatelessWidget {
  final ArtistTransactionEntity? transaction;

  const ArtistRequestPaymentScreen({super.key, this.transaction});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ArtistRequestPaymentController>();

    if (transaction != null) {
      c.orderIdController.text = transaction!.id.replaceAll('#', '').trim();
      if (c.paymentMethods.contains(transaction!.paymentMethod)) {
        c.selectedPaymentMethod.value = transaction!.paymentMethod;
      }
    }

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leadingWidth: 56,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.appbardivider,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back,
                color: AppColors.white,
                size: 20,
              ),
            ),
          ),
        ),
        title: Text(
          'Request Payment',
          style: AppTextStyle(context).boldTextStyle(
            color: AppColors.white,
            fontSize: 18.sp,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    8.verticalSpace,

                    // Section title
                    Text(
                      'Send a request to Admin',
                      style: AppTextStyle(context).boldTextStyle(
                        color: AppColors.onboardingbutton,
                        fontSize: 14.sp,
                      ),
                    ),
                    18.verticalSpace,

                    // Order ID Field
                    Text(
                      'Order ID',
                      style: AppTextStyle(context).mediumTextStyle(
                        color: AppColors.primarytext,
                        fontSize: 13.sp,
                      ),
                    ),
                    8.verticalSpace,
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.textfieldcolor,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: TextField(
                        controller: c.orderIdController,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          hintText: 'PRD ID: 5454',
                          hintStyle: TextStyle(
                            color: AppColors.white.withValues(alpha: 0.38),
                            fontSize: 13.sp,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 14.h,
                          ),
                        ),
                      ),
                    ),
                    18.verticalSpace,

                    // Payment Method Dropdown
                    Text(
                      'Payment Method',
                      style: AppTextStyle(context).mediumTextStyle(
                        color: AppColors.primarytext,
                        fontSize: 13.sp,
                      ),
                    ),
                    8.verticalSpace,
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.textfieldcolor,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Obx(
                        () => DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: c.selectedPaymentMethod.value,
                            isExpanded: true,
                            dropdownColor: AppColors.textfieldcolor,
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColors.primarytext,
                              size: 20.sp,
                            ),
                            style: TextStyle(
                              color: c.selectedPaymentMethod.value ==
                                      'Enter Payment Method'
                                  ? AppColors.white.withValues(alpha: 0.54)
                                  : AppColors.white,
                              fontSize: 13.sp,
                            ),
                            items: c.paymentMethods.map((method) {
                              return DropdownMenuItem(
                                value: method,
                                child: Text(method),
                              );
                            }).toList(),
                            onChanged: (val) {
                              if (val != null) {
                                c.selectedPaymentMethod.value = val;
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    18.verticalSpace,

                    // Mobile Money Number
                    Text(
                      'Mobile Money Number',
                      style: AppTextStyle(context).mediumTextStyle(
                        color: AppColors.primarytext,
                        fontSize: 13.sp,
                      ),
                    ),
                    8.verticalSpace,
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.textfieldcolor,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: TextField(
                        controller: c.phoneController,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 13.sp,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Enter Mobile Money Number',
                          hintStyle: TextStyle(
                            color: AppColors.white.withValues(alpha: 0.38),
                            fontSize: 13.sp,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 14.h,
                          ),
                        ),
                      ),
                    ),
                    18.verticalSpace,

                    // Message (Optional)
                    Text(
                      'Message (Optional)',
                      style: AppTextStyle(context).mediumTextStyle(
                        color: AppColors.primarytext,
                        fontSize: 13.sp,
                      ),
                    ),
                    8.verticalSpace,
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.textfieldcolor,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: TextField(
                        controller: c.messageController,
                        maxLines: 4,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 13.sp,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Write your message to admin',
                          hintStyle: TextStyle(
                            color: AppColors.white.withValues(alpha: 0.38),
                            fontSize: 13.sp,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 14.h,
                          ),
                        ),
                      ),
                    ),
                    16.verticalSpace,

                    // Disclaimer text
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: AppColors.primarytext,
                          size: 14.sp,
                        ),
                        6.horizontalSpace,
                        Expanded(
                          child: Text(
                            'Payments are typically settled within 2-3 business days after successful delivery.',
                            style: AppTextStyle(context).regularTextStyle(
                              color: AppColors.primarytext.withValues(
                                alpha: 0.7,
                              ),
                              fontSize: 11.sp,
                              lineHeight: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    24.verticalSpace,
                  ],
                ),
              ),
            ),

            // Bottom Send Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: SizedBox(
                width: double.infinity,
                height: 52.h,
                child: Obx(
                  () => ElevatedButton(
                    onPressed:
                        c.isSubmitting.value ? null : () => c.submitRequest(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      elevation: 0,
                    ),
                    child: c.isSubmitting.value
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.white,
                            ),
                          )
                        : Text(
                            'Send',
                            style: AppTextStyle(context).boldTextStyle(
                              color: AppColors.white,
                              fontSize: 15.sp,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
