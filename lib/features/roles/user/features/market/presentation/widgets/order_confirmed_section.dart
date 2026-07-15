import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:riddimafrica/core/core.dart';
import 'order_info_row.dart';

class OrderConfirmedSection extends StatelessWidget {
  const OrderConfirmedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        // Riddim Africa Brand Logo
        Center(
          child: Image(
            height: 70.h,
            image: AssetImage(ImagePath.onlogo3),
          ),
        ),
        const SizedBox(height: 32),

        // Confirm Text
        Text(
          'Order Confirmed!',
          style: AppTextStyle(
            context,
          ).boldTextStyle(color: AppColors.white, fontSize: 24),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text(
          'Thank you for supporting African culture. Your order is on its way!',
          style: AppTextStyle(
            context,
          ).mediumTextStyle(color: AppColors.primarytext, fontSize: 14),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),

        // Order Details Card
        Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: AppColors.primaryappbrown,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            children: [
              const OrderInfoRow(
                label: 'Order Number',
                value: 'RA-2026-62619',
                icon: Iconsax.box,
              ),
              const Divider(color: AppColors.primaryappbrown, height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Payment Status',
                    style: AppTextStyle(context).mediumTextStyle(
                      color: AppColors.primarytext,
                      fontSize: 14,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.success,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check,
                          color: AppColors.white,
                          size: 12,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Paid',
                          style: AppTextStyle(
                            context,
                          ).boldTextStyle(color: AppColors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(color: AppColors.primaryappbrown, height: 24),
              const OrderInfoRow(
                label: 'Expected Delivery',
                value: '3-5 Business Days',
              ),
              const Divider(color: AppColors.primaryappbrown, height: 24),
              const OrderInfoRow(
                label: 'Estimated Date',
                value: 'June 16-18, 2026',
                valueColor: AppColors.onboardingbutton,
              ),
            ],
          ),
        ),
        const SizedBox(height: 48),

        // Buttons: Track Order & Continue Shopping
        ProElevatedButton(
          onPressed: () {
            Get.offAllNamed('/userbottomNav');
          },
          text: 'Track Order',
          leadingIcon: Iconsax.box,
          backgroundColor: AppColors.secondary,
          textColor: AppColors.white,
          fontSize: 16,
          borderRadius: 16,
          showGlow: true,
          glowColor: AppColors.secondary.withOpacity(0.4),
        ),
        const SizedBox(height: 16),
        ProElevatedButton(
          onPressed: () {
            Get.offAllNamed('/userbottomNav');
          },
          text: 'Continue Shopping',
          leadingIcon: Iconsax.shop,
          backgroundColor: Colors.transparent,
          textColor: AppColors.white,
          fontSize: 16,
          borderRadius: 16,
          border: const BorderSide(
            color: AppColors.primaryappbrownsecond,
            width: 1.5,
          ),
          showGlow: false,
        ),
      ],
    );
  }
}
