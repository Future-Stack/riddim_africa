import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:riddimafrica/core/core.dart';
import 'package:riddimafrica/core/common/common_text_field/pro_text_field.dart';
import '../controllers/checkout_controller.dart';
import 'delivery_address_chip.dart';
import 'map_route_card.dart';
import 'stats_box.dart';

class ShippingInfoSection extends StatelessWidget {
  final CheckoutController controller;

  const ShippingInfoSection({super.key, required this.controller});

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

        // Form Fields
        ProTextField(
          labelText: 'Full Name',
          hintText: 'Enter your full name',
          controller: controller.fullNameController,
        ),
        const SizedBox(height: 16),

        ProTextField(
          labelText: 'Phone Number',
          hintText: 'Enter your phone number',
          controller: controller.phoneController,
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 16),

        ProTextField(
          labelText: 'Email',
          hintText: 'Enter your email address',
          controller: controller.emailController,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 24),

        // Delivery Location Header with Add New Button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Iconsax.location5,
                  color: AppColors.bordercolor,
                  size: 20,
                ),
                const SizedBox(width: 6),
                Text(
                  'Delivery Location',
                  style: AppTextStyle(
                    context,
                  ).boldTextStyle(color: AppColors.white, fontSize: 16),
                ),
              ],
            ),
            GestureDetector(
              onTap: controller.showAddAddressForm,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryappbrownsecond,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Text(
                      'Add New',
                      style: AppTextStyle(
                        context,
                      ).boldTextStyle(color: AppColors.white, fontSize: 12),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.add, color: AppColors.white, size: 14),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Saved Addresses Chips
        Row(
          children: List.generate(controller.addresses.length, (index) {
            final address = controller.addresses[index];
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: index < controller.addresses.length - 1 ? 12.0 : 0.0,
                ),
                child: DeliveryAddressChip(
                  label: address.label,
                  address: address.address,
                  isSelected: controller.selectedAddressIndex.value == index,
                  onTap: () => controller.selectAddress(index),
                  onRemove: () => controller.addresses.removeAt(index),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 24),

        // Map Dotted Route Card
        const MapRouteCard(),
        const SizedBox(height: 16),

        // Stats Box
        StatsBox(context: context),
      ],
    );
  }
}
