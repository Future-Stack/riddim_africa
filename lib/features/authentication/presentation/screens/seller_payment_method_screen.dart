import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import 'package:riddimafrica/features/authentication/presentation/controllers/auth_controller.dart';


// ─────────────────────────────────────────────────────────────────────────────
// SCREEN 3 — Payment Method Selection
// ─────────────────────────────────────────────────────────────────────────────
class SellerPaymentMethodScreen extends StatelessWidget {
  const SellerPaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) {
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Progress
                  _buildProgressBar(),
                  SizedBox(height: 24.h),

                  Text(
                    'Payment Method',
                    style: AppTextStyle(context).boldTextStyle(
                      color: AppColors.white,
                      fontSize: AppTextStyle.title,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Select how you would like to receive your payouts.',
                    style: AppTextStyle(context).regularTextStyle(
                      color: AppColors.onboardingtext,
                      fontSize: AppTextStyle.md,
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // MTN Mobile Money
                  _buildPaymentCard(
                    context,
                    controller: controller,
                    methodIndex: 0,
                    title: 'MTN Mobile Money',
                    subtitle: 'Receive payouts via MTN MoMo',
                    logoAsset: ImagePath.momo,
                    phoneLabel: 'MTN Phone Number',
                    phoneHint: 'e.g. 0771234567',
                  ),
                  SizedBox(height: 16.h),

                  // Airtel Money
                  _buildPaymentCard(
                    context,
                    controller: controller,
                    methodIndex: 1,
                    title: 'Airtel Money',
                    subtitle: 'Receive payouts via Airtel Money',
                    logoAsset: ImagePath.airtel,
                    phoneLabel: 'Airtel Phone Number',
                    phoneHint: 'e.g. 0701234567',
                  ),

                  const Spacer(),

                  ProElevatedButton(
                    text: 'Create Account',
                    trailingIcon: Icons.arrow_forward_ios,
                    iconSize: 16,
                    gradient: const LinearGradient(
                      colors: [AppColors.secondary, AppColors.secondary],
                    ),
                    onPressed: () => controller.onSellerSignupComplete(),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProgressBar() {
    return Row(
      children: List.generate(3, (i) {
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(right: i < 2 ? 6.w : 0),
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.bordercolor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildPaymentCard(
    BuildContext context, {
    required AuthController controller,
    required int methodIndex,
    required String title,
    required String subtitle,
    required String logoAsset,
    required String phoneLabel,
    required String phoneHint,
  }) {
    final isSelected = controller.selectedPaymentMethod == methodIndex;

    return GestureDetector(
      onTap: () => controller.setPaymentMethod(methodIndex),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.bordercolor.withValues(alpha: 0.12)
              : AppColors.backgroundcolor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.bordercolor : AppColors.cardBorder,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          children: [
            // Header row
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  // Logo
                  Container(
                    width: 52.w,
                    height: 52.w,
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.all(8.w),
                    child: Image.asset(logoAsset, fit: BoxFit.contain),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppTextStyle(context).boldTextStyle(
                            color: AppColors.white,
                            fontSize: AppTextStyle.md,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          subtitle,
                          style: AppTextStyle(context).regularTextStyle(
                            color: AppColors.onboardingtext,
                            fontSize: AppTextStyle.sm,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Radio
                  Container(
                    width: 22.w,
                    height: 22.w,
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
                              width: 12.w,
                              height: 12.w,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.bordercolor,
                              ),
                            ),
                          )
                        : null,
                  ),
                ],
              ),
            ),

            // Phone number input (shown when selected)
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 250),
              crossFadeState: isSelected
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              firstChild: Padding(
                padding: EdgeInsets.only(
                  left: 16.w,
                  right: 16.w,
                  bottom: 16.h,
                ),
                child: ProTextField(
                  controller: methodIndex == 0
                      ? controller.momoPhoneController
                      : controller.airtelPhoneController,
                  labelText: phoneLabel,
                  hintText: phoneHint,
                  keyboardType: TextInputType.phone,
                ),
              ),
              secondChild: const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
