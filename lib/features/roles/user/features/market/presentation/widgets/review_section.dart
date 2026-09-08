import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:riddimafrica/core/core.dart';
import '../controllers/checkout_controller.dart';
import 'stats_box.dart';

class ReviewSection extends StatelessWidget {
  final CheckoutController controller;

  const ReviewSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Shipping Information',
          style: AppTextStyle(
            context,
          ).boldTextStyle(color: AppColors.white, fontSize: 18),
        ),
        const SizedBox(height: 16),

        // Product Summary Item Card
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: AppColors.primaryappbrownsecond,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: Image.network(
                    'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?q=80&w=500&auto=format&fit=crop',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ankara Print Hoodie',
                      style: AppTextStyle(
                        context,
                      ).semiBoldTextStyle(color: AppColors.white, fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Qty: 1',
                      style: AppTextStyle(context).regularTextStyle(
                        color: AppColors.primarytext,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'Color: Green    Size: XL',
                      style: AppTextStyle(context).regularTextStyle(
                        color: AppColors.primarytext,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'UGX 78,000',
                style: AppTextStyle(context).boldTextStyle(
                  color: AppColors.onboardingbutton,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Stats card Box
        StatsBox(context: context),
        const SizedBox(height: 16),

        // Payment Cost Summary Detail Card
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: AppColors.primaryappbrownsecond,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Subtotal',
                    style: AppTextStyle(context).regularTextStyle(
                      color: AppColors.primarytext,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'UGX 78,000',
                    style: AppTextStyle(
                      context,
                    ).semiBoldTextStyle(color: AppColors.white, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Delivery fee',
                    style: AppTextStyle(context).regularTextStyle(
                      color: AppColors.primarytext,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'UGX 5,500',
                    style: AppTextStyle(
                      context,
                    ).semiBoldTextStyle(color: AppColors.white, fontSize: 14),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Divider(color: AppColors.primaryappbrown, thickness: 1),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: AppTextStyle(
                      context,
                    ).boldTextStyle(color: AppColors.white, fontSize: 16),
                  ),
                  Text(
                    'UGX 83,500',
                    style: AppTextStyle(context).boldTextStyle(
                      color: AppColors.onboardingbutton,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Delivering to address summary card
        Container(
          padding: const EdgeInsets.all(16.0),
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.primaryappbrownsecond,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'DELIVERING TO',
                style: AppTextStyle(
                  context,
                ).boldTextStyle(color: AppColors.onboardingtext, fontSize: 12),
              ),
              const SizedBox(height: 8),
              Text(
                controller.fullNameController.text,
                style: AppTextStyle(
                  context,
                ).boldTextStyle(color: AppColors.white, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                controller.addresses.isNotEmpty &&
                        controller.selectedAddressIndex.value <
                            controller.addresses.length
                    ? controller
                          .addresses[controller.selectedAddressIndex.value]
                          .address
                    : 'Plot 12, Buganda Road, Kampala',
                style: AppTextStyle(
                  context,
                ).regularTextStyle(color: AppColors.onboardingtext, fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                controller.phoneController.text,
                style: AppTextStyle(
                  context,
                ).regularTextStyle(color: AppColors.onboardingtext, fontSize: 14),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(Iconsax.clock, color: Color(0xFF387A7C), size: 16),
                  const SizedBox(width: 8),
                  Text(
                    'Est. arrival: 12–15 min from dispatch',
                    style: AppTextStyle(context).mediumTextStyle(
                      color: AppColors.white,
                      fontSize: 12,
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
