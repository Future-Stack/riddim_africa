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
          'Order Summary',
          style: AppTextStyle(
            context,
          ).boldTextStyle(color: AppColors.white, fontSize: 18),
        ),
        const SizedBox(height: 16),

        // Product Summary Item Card(s)
        if (controller.checkoutType.value == 'DIRECT')
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
                    child: controller.directProductImage.value.isNotEmpty
                        ? Image.network(
                            controller.directProductImage.value,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                              Iconsax.box,
                              color: AppColors.primarytext,
                            ),
                          )
                        : const Icon(
                            Iconsax.box,
                            color: AppColors.primarytext,
                          ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.directProductTitle.value.isNotEmpty
                            ? controller.directProductTitle.value
                            : 'Product',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle(
                          context,
                        ).semiBoldTextStyle(color: AppColors.white, fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Qty: ${controller.directQuantity.value}',
                        style: AppTextStyle(context).regularTextStyle(
                          color: AppColors.primarytext,
                          fontSize: 12,
                        ),
                      ),
                      if (controller.directColor.value.isNotEmpty ||
                          controller.directSize.value.isNotEmpty)
                        Text(
                          [
                            if (controller.directColor.value.isNotEmpty)
                              'Color: ${controller.directColor.value}',
                            if (controller.directSize.value.isNotEmpty)
                              'Size: ${controller.directSize.value}',
                          ].join('    '),
                          style: AppTextStyle(context).regularTextStyle(
                            color: AppColors.primarytext,
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),
                ),
                Text(
                  controller.directProductPrice.value.isNotEmpty
                      ? controller.directProductPrice.value
                      : controller.subtotalFormatted,
                  style: AppTextStyle(context).boldTextStyle(
                    color: AppColors.onboardingbutton,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          )
        else
          Column(
            children: controller.checkoutCartItems.map((item) {
              return Container(
                margin: const EdgeInsets.only(bottom: 8.0),
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
                        child: item.imageUrl.isNotEmpty
                            ? Image.network(
                                item.imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(
                                  Iconsax.box,
                                  color: AppColors.primarytext,
                                ),
                              )
                            : const Icon(
                                Iconsax.box,
                                color: AppColors.primarytext,
                              ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle(context).semiBoldTextStyle(
                              color: AppColors.white,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Qty: ${item.quantity}',
                            style: AppTextStyle(context).regularTextStyle(
                              color: AppColors.primarytext,
                              fontSize: 12,
                            ),
                          ),
                          if (item.selectedColor.isNotEmpty ||
                              item.selectedSize.isNotEmpty)
                            Text(
                              [
                                if (item.selectedColor.isNotEmpty)
                                  'Color: ${item.selectedColor}',
                                if (item.selectedSize.isNotEmpty)
                                  'Size: ${item.selectedSize}',
                              ].join('    '),
                              style: AppTextStyle(context).regularTextStyle(
                                color: AppColors.primarytext,
                                fontSize: 12,
                              ),
                            ),
                        ],
                      ),
                    ),
                    Text(
                      item.price,
                      style: AppTextStyle(context).boldTextStyle(
                        color: AppColors.onboardingbutton,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
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
                    controller.subtotalFormatted,
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
                    controller.deliveryFeeFormatted,
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
                    controller.totalAmountFormatted,
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
                controller.fullNameController.text.isNotEmpty
                    ? controller.fullNameController.text
                    : 'John Doe',
                style: AppTextStyle(
                  context,
                ).boldTextStyle(color: AppColors.white, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                controller.selectedAddress?.address ??
                    (controller.streetAddressController.text.isNotEmpty
                        ? '${controller.streetAddressController.text}, ${controller.cityController.text}'
                        : 'Plot 12, Buganda Road, Kampala'),
                style: AppTextStyle(
                  context,
                ).regularTextStyle(color: AppColors.onboardingtext, fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                controller.phoneController.text.isNotEmpty
                    ? controller.phoneController.text
                    : '+256700000000',
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
