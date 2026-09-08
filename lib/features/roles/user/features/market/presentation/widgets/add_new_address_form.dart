import 'package:flutter/material.dart';
import 'package:riddimafrica/core/core.dart';
import '../controllers/checkout_controller.dart';
import 'address_type_option.dart';

class AddNewAddressForm extends StatelessWidget {
  final CheckoutController controller;

  const AddNewAddressForm({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProTextField(
          labelText: 'City',
          hintText: 'Kampala',
          controller: controller.cityController,
        ),
        const SizedBox(height: 16),

        ProTextField(
          labelText: 'Street Address',
          hintText: 'Plot 12, Buganda Road',
          controller: controller.streetAddressController,
        ),
        const SizedBox(height: 16),

        ProTextField(
          labelText: 'Special Instruction ( Optional )',
          hintText: 'Gate color, landmark, etc.',
          controller: controller.specialInstructionController,
        ),
        const SizedBox(height: 24),

        // Save This Address Box
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color(0xFF22140A),
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: const Color(0xFF382111), width: 1.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Save this address?',
                style: AppTextStyle(
                  context,
                ).boldTextStyle(color: AppColors.white, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                'Reuse it at next checkout with one tap.',
                style: AppTextStyle(
                  context,
                ).mediumTextStyle(color: AppColors.primarytext, fontSize: 12),
              ),
              const SizedBox(height: 16),

              // Home, Work, Other Types selection
              Row(
                children: [
                  AddressTypeOption(
                    type: 'Home',
                    isSelected: controller.selectedAddressType.value == 'Home',
                    onTap: () => controller.selectAddressType('Home'),
                  ),
                  const SizedBox(width: 12),
                  AddressTypeOption(
                    type: 'Work',
                    isSelected: controller.selectedAddressType.value == 'Work',
                    onTap: () => controller.selectAddressType('Work'),
                  ),
                  const SizedBox(width: 12),
                  AddressTypeOption(
                    type: 'Other',
                    isSelected: controller.selectedAddressType.value == 'Other',
                    onTap: () => controller.selectAddressType('Other'),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Action buttons Skip & Save Address
              Row(
                children: [
                  Expanded(
                    child: ProElevatedButton(
                      onPressed: controller.hideAddAddressForm,
                      text: 'Skip',
                      backgroundColor: const Color(0xFF322117),
                      textColor: AppColors.onboardingtext,
                      fontSize: 14,
                      borderRadius: 24,
                      showGlow: false,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ProElevatedButton(
                      onPressed: controller.saveAddress,
                      text: 'Save Address',
                      backgroundColor: AppColors.onboardingbutton,
                      textColor: AppColors.primary,
                      fontSize: 14,
                      borderRadius: 24,
                      showGlow: true,
                      glowColor: AppColors.onboardingbutton.withValues(alpha: 0.4),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
