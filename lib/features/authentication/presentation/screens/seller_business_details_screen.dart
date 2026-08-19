import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import 'package:riddimafrica/features/authentication/presentation/controllers/auth_controller.dart';

/// Step 3 of Seller Verification — Business Details
/// Includes: business info, Business Type selector, Payment Method selector
class SellerBusinessDetailsScreen extends StatelessWidget {
  const SellerBusinessDetailsScreen({super.key});

  static const List<String> _businessTypes = [
    'Individual / Sole Trader',
    'Partnership',
    'Registered Company',
    'NGO / Non-profit',
  ];

  static const List<Map<String, String>> _paymentMethods = [
    {'label': 'MTN Mobile Money', 'asset': ImagePath.momo},
    {'label': 'Airtel Money', 'asset': ImagePath.airtel},
  ];

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
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ── BUSINESS INFO ─────────────────────────────────────────
                  _buildSectionHeader(context, 'BUSINESS INFO'),
                  SizedBox(height: 12.h),
                  ProTextField(
                    controller: controller.businessNameController,
                    labelText: 'Business Name',
                    hintText: 'Enter Business Name',
                  ),
                  SizedBox(height: 12.h),
                  ProTextField(
                    controller: controller.businessEmailController,
                    labelText: 'Business Email',
                    hintText: 'Enter Business Email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 12.h),
                  ProTextField(
                    controller: controller.businessPhoneController,
                    labelText: 'Business Phone',
                    hintText: 'Enter Business Phone',
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 12.h),
                  ProTextField(
                    controller: controller.businessWebsiteController,
                    labelText: 'Website (Optional)',
                    hintText: 'https://yourbusiness.com',
                    keyboardType: TextInputType.url,
                  ),
                  SizedBox(height: 24.h),

                  // ── BUSINESS ADDRESS ──────────────────────────────────────
                  _buildSectionHeader(context, 'BUSINESS ADDRESS'),
                  SizedBox(height: 12.h),
                  ProTextField(
                    controller: controller.businessAddressController,
                    labelText: 'Street Address',
                    hintText: 'Enter Street Address',
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Expanded(
                        child: ProTextField(
                          controller: controller.businessCityController,
                          labelText: 'City',
                          hintText: 'City',
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: ProTextField(
                          controller: controller.businessStateController,
                          labelText: 'State / Province',
                          hintText: 'State',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  ProTextField(
                    controller: controller.businessCountryController,
                    labelText: 'Country',
                    hintText: 'Enter Country',
                  ),
                  SizedBox(height: 24.h),

                  // ── BUSINESS TYPE ─────────────────────────────────────────
                  _buildSectionHeader(context, 'BUSINESS TYPE'),
                  SizedBox(height: 12.h),
                  _buildDropdownSelector(
                    context,
                    label: controller.selectedBusinessType >= 0
                        ? _businessTypes[controller.selectedBusinessType]
                        : 'Select business type',
                    isSelected: controller.selectedBusinessType >= 0,
                    onTap: () => _showBusinessTypeSheet(context, controller),
                  ),
                  SizedBox(height: 24.h),

                  // ── PAYMENT METHOD ────────────────────────────────────────
                  _buildSectionHeader(context, 'PAYMENT METHOD'),
                  SizedBox(height: 12.h),
                  _buildDropdownSelector(
                    context,
                    label: controller.selectedPaymentMethod >= 0
                        ? _paymentMethods[controller.selectedPaymentMethod]['label']!
                        : 'Select payment method',
                    isSelected: controller.selectedPaymentMethod >= 0,
                    onTap: () => _showPaymentMethodSheet(context, controller),
                  ),

                  // Phone number if payment selected
                  if (controller.selectedPaymentMethod >= 0) ...[
                    SizedBox(height: 12.h),
                    ProTextField(
                      controller: controller.selectedPaymentMethod == 0
                          ? controller.momoPhoneController
                          : controller.airtelPhoneController,
                      labelText: controller.selectedPaymentMethod == 0
                          ? 'MTN Phone Number'
                          : 'Airtel Phone Number',
                      hintText: 'e.g. 0771234567',
                      keyboardType: TextInputType.phone,
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(10.w),
                        child: Image.asset(
                          _paymentMethods[controller.selectedPaymentMethod]['asset']!,
                          width: 24.w,
                          height: 24.w,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                  SizedBox(height: 32.h),

                  // ── Create Account Button ─────────────────────────────────
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

  // ── Helpers ──────────────────────────────────────────────────────────────

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Row(
      children: [
        Text(
          title,
          style: AppTextStyle(context).boldTextStyle(
            color: AppColors.primarytext,
            fontSize: 11,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.cardBorder.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownSelector(
    BuildContext context, {
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.bordercolor.withValues(alpha: 0.08)
              : AppColors.backgroundcolor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.bordercolor : AppColors.cardBorder,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: AppTextStyle(context).mediumTextStyle(
                  color: isSelected ? AppColors.white : AppColors.onboardingtext,
                  fontSize: AppTextStyle.md,
                ),
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.onboardingtext,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }

  void _showBusinessTypeSheet(
    BuildContext context,
    AuthController controller,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.backgroundcolor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40.w,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.cardBorder,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Select Business Type',
                style: AppTextStyle(context).boldTextStyle(
                  color: AppColors.white,
                  fontSize: AppTextStyle.xl,
                ),
              ),
              SizedBox(height: 16.h),
              ..._businessTypes.asMap().entries.map((e) {
                final isSelected = controller.selectedBusinessType == e.key;
                return GestureDetector(
                  onTap: () {
                    controller.setBusinessType(e.key);
                    Navigator.pop(ctx);
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10.h),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 14.h,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.bordercolor.withValues(alpha: 0.15)
                          : AppColors.primary.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.bordercolor
                            : AppColors.cardBorder,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            e.value,
                            style: AppTextStyle(context).mediumTextStyle(
                              color: AppColors.white,
                              fontSize: AppTextStyle.md,
                            ),
                          ),
                        ),
                        if (isSelected)
                          const Icon(
                            Icons.check_circle,
                            color: AppColors.bordercolor,
                            size: 20,
                          ),
                      ],
                    ),
                  ),
                );
              }),
              SizedBox(height: 8.h),
            ],
          ),
        );
      },
    );
  }

  void _showPaymentMethodSheet(
    BuildContext context,
    AuthController controller,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.backgroundcolor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.cardBorder,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Payment Method',
                style: AppTextStyle(context).boldTextStyle(
                  color: AppColors.white,
                  fontSize: AppTextStyle.xl,
                ),
              ),
              SizedBox(height: 16.h),
              ..._paymentMethods.asMap().entries.map((e) {
                final isSelected = controller.selectedPaymentMethod == e.key;
                return GestureDetector(
                  onTap: () {
                    controller.setPaymentMethod(e.key);
                    Navigator.pop(ctx);
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10.h),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 14.h,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.bordercolor.withValues(alpha: 0.15)
                          : AppColors.primary.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.bordercolor
                            : AppColors.cardBorder,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 36.w,
                          height: 36.w,
                          padding: EdgeInsets.all(6.w),
                          decoration: BoxDecoration(
                            color: AppColors.white.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.asset(
                            e.value['asset']!,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(width: 14.w),
                        Expanded(
                          child: Text(
                            e.value['label']!,
                            style: AppTextStyle(context).mediumTextStyle(
                              color: AppColors.white,
                              fontSize: AppTextStyle.md,
                            ),
                          ),
                        ),
                        if (isSelected)
                          const Icon(
                            Icons.check_circle,
                            color: AppColors.bordercolor,
                            size: 20,
                          ),
                      ],
                    ),
                  ),
                );
              }),
              SizedBox(height: 8.h),
            ],
          ),
        );
      },
    );
  }
}
