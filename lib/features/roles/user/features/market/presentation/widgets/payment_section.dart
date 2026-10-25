import 'package:flutter/material.dart';
import 'package:riddimafrica/core/core.dart';
import '../controllers/checkout_controller.dart';
import 'payment_option_card.dart';

class PaymentSection extends StatelessWidget {
  final CheckoutController controller;

  const PaymentSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Method',
          style: AppTextStyle(
            context,
          ).boldTextStyle(color: AppColors.white, fontSize: 18),
        ),
        const SizedBox(height: 4),
        Text(
          'Mobile Money',
          style: AppTextStyle(
            context,
          ).mediumTextStyle(color: AppColors.primarytext, fontSize: 14),
        ),
        const SizedBox(height: 16),

        // MTN Option Card
        PaymentOptionCard(
          methodName: 'MTN Mobile Money',
          logoColor: AppColors.primaryappbrownsecond,
          imagepath: ImagePath.momo,
          isSelected:
              controller.selectedPaymentMethod.value == 'MTN Mobile Money',
          onTap: () => controller.selectPaymentMethod('MTN Mobile Money'),
        ),
        const SizedBox(height: 12),

        // Airtel Option Card
        PaymentOptionCard(
          methodName: 'Airtel Money',
          logoColor: AppColors.primaryappbrownsecond,
          imagepath: ImagePath.airtel,
          isSelected: controller.selectedPaymentMethod.value == 'Airtel Money',
          onTap: () => controller.selectPaymentMethod('Airtel Money'),
        ),
        const SizedBox(height: 24),

        // Total amount card
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: BoxDecoration(
            color: AppColors.primaryappbrown,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Amount',
                style: AppTextStyle(
                  context,
                ).boldTextStyle(color: AppColors.white, fontSize: 16),
              ),
              Text(
                controller.totalAmountFormatted,
                style: AppTextStyle(context).boldTextStyle(
                  color: AppColors.onboardingbutton,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),

        // Big Red Bottom Button inside view
        ProElevatedButton(
          onPressed: controller.isProcessingCheckout.value
              ? null
              : controller.processOrderPayment,
          text: controller.isProcessingCheckout.value
              ? 'Processing Payment...'
              : 'Pay ${controller.totalAmountFormatted} via ${controller.selectedPaymentMethod.value}',
          backgroundColor: AppColors.secondary,
          textColor: AppColors.white,
          fontSize: 16,
          borderRadius: 16,
          showGlow: true,
          glowColor: AppColors.secondary.withValues(alpha: 0.5),
        ),
      ],
    );
  }
}
