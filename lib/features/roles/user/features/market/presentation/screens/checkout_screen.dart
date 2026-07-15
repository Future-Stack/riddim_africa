import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:riddimafrica/core/core.dart';
import 'package:riddimafrica/core/common/common_text_field/pro_text_field.dart';
import '../controllers/checkout_controller.dart';
import '../widgets/checkout_step_indicator.dart';
import '../widgets/delivery_address_chip.dart';

class CheckoutScreen extends GetView<CheckoutController> {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Get.back(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Checkout',
              style: AppTextStyle(
                context,
              ).boldTextStyle(color: AppColors.white, fontSize: 20),
            ),
            Obx(
              () => Text(
                'Step ${controller.currentStep.value + 1} of ${controller.totalSteps}',
                style: AppTextStyle(
                  context,
                ).regularTextStyle(color: AppColors.primarytext, fontSize: 12),
              ),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.onboardingbutton),
          );
        }

        return SafeArea(
          child: Column(
            children: [
              // Top Step Indicator
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
                child: CheckoutStepIndicator(
                  currentStep: controller.currentStep.value,
                  stepLabels: controller.stepLabels,
                ),
              ),

              // Page Content based on current step
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // STEP 1: SHIPPING
                      if (controller.currentStep.value == 0) ...[
                        if (controller.isAddingNewAddress.value) ...[
                          _buildAddNewAddressForm(context),
                        ] else ...[
                          _buildShippingInfoSection(context),
                        ],
                      ],

                      // STEP 2: REVIEW
                      if (controller.currentStep.value == 1) ...[
                        _buildReviewSection(context),
                      ],

                      // STEP 3: PAYMENT
                      if (controller.currentStep.value == 2) ...[
                        _buildPaymentSection(context),
                      ],

                      // STEP 4: PROCESSING / ORDER CONFIRMED
                      if (controller.currentStep.value == 3) ...[
                        _buildOrderConfirmedSection(context),
                      ],
                    ],
                  ),
                ),
              ),

              // Bottom Button Bar (Only shown for steps 1, 2, 3)
              if (controller.currentStep.value < 3 &&
                  !controller.isAddingNewAddress.value)
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: const BoxDecoration(
                    color: AppColors.primaryappbrown,
                    border: Border(
                      top: BorderSide(
                        color: AppColors.primaryappbrownsecond,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      if (controller.currentStep.value > 0) ...[
                        Expanded(
                          child: OutlinedButton(
                            onPressed: controller.previousStep,
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: AppColors.bordercolor,
                              ),
                              minimumSize: const Size.fromHeight(55),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Text(
                              'Back',
                              style: AppTextStyle(context).boldTextStyle(
                                color: AppColors.bordercolor,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                      ],
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (controller.currentStep.value <
                                controller.totalSteps - 1) {
                              controller.nextStep();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.secondary,
                            foregroundColor: AppColors.white,
                            elevation: 0,
                            minimumSize: const Size.fromHeight(55),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                controller.currentStep.value == 1
                                    ? 'Continue'
                                    : 'Next',
                                style: AppTextStyle(context).boldTextStyle(
                                  color: AppColors.white,
                                  fontSize: 16,
                                ),
                              ),
                              if (controller.currentStep.value == 1) ...[
                                const SizedBox(width: 8),
                                const Icon(Icons.arrow_forward, size: 16),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }

  // ─── STEP 1: SHIPPING SECTIONS ──────────────────────────────────────────

  Widget _buildShippingInfoSection(BuildContext context) {
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
        _buildMapRouteCard(context),
        const SizedBox(height: 16),

        // Stats Box
        _buildStatsBox(context),
      ],
    );
  }

  Widget _buildAddNewAddressForm(BuildContext context) {
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
                  _buildAddressTypeOption(context, 'Home'),
                  const SizedBox(width: 12),
                  _buildAddressTypeOption(context, 'Work'),
                  const SizedBox(width: 12),
                  _buildAddressTypeOption(context, 'Other'),
                ],
              ),
              const SizedBox(height: 24),

              // Action buttons Skip & Save Address
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: controller.hideAddAddressForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF322117),
                        foregroundColor: AppColors.white,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: Text(
                        'Skip',
                        style: AppTextStyle(context).boldTextStyle(
                          color: AppColors.onboardingtext,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: controller.saveAddress,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.onboardingbutton,
                        foregroundColor: AppColors.primary,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: Text(
                        'Save Address',
                        style: AppTextStyle(
                          context,
                        ).boldTextStyle(color: AppColors.primary, fontSize: 14),
                      ),
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

  Widget _buildAddressTypeOption(BuildContext context, String type) {
    final isSelected = controller.selectedAddressType.value == type;
    return GestureDetector(
      onTap: () => controller.selectAddressType(type),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF6B2657) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF6B2657)
                : AppColors.primaryappbrownsecond,
            width: 1.5,
          ),
        ),
        child: Text(
          type,
          style: AppTextStyle(context).mediumTextStyle(
            color: isSelected ? AppColors.white : AppColors.primarytext,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildMapRouteCard(BuildContext context) {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        color: const Color(0xFF111E29),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        children: [
          // Map Graphic representation
          Expanded(
            child: Stack(
              children: [
                // Subtle map grid background
                Positioned.fill(
                  child: GridPaper(
                    color: Colors.white.withOpacity(0.02),
                    divisions: 1,
                    subdivisions: 1,
                  ),
                ),
                // Route Line
                Center(
                  child: CustomPaint(
                    size: const Size(double.infinity, 100),
                    painter: DottedLinePainter(),
                  ),
                ),
                // Left Office Pin
                Positioned(
                  left: 32,
                  top: 80,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF3A2315),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'OFFICE',
                          style: AppTextStyle(context).boldTextStyle(
                            color: AppColors.onboardingtext,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        width: 14,
                        height: 14,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
                // Distance Indicator Badge in Center
                Positioned(
                  left: 140,
                  top: 60,
                  child: Text(
                    '1.9 km',
                    style: AppTextStyle(context).boldTextStyle(
                      color: AppColors.onboardingbutton,
                      fontSize: 12,
                    ),
                  ),
                ),
                // Right YOU Pin
                Positioned(
                  right: 32,
                  top: 90,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.onboardingbutton,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'YOU',
                          style: AppTextStyle(context).boldTextStyle(
                            color: AppColors.primary,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        width: 14,
                        height: 14,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.onboardingbutton,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Dispatch location footer bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Color(0xFF0F1A24),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF2E241F),
                  ),
                  child: const Icon(
                    Iconsax.truck,
                    color: AppColors.onboardingtext,
                    size: 16,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Dispatching from: ',
                  style: AppTextStyle(context).regularTextStyle(
                    color: AppColors.primarytext,
                    fontSize: 12,
                  ),
                ),
                Text(
                  'Roots Yard, Kampala',
                  style: AppTextStyle(
                    context,
                  ).boldTextStyle(color: AppColors.white, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsBox(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.primaryappbrownsecond,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatsColumn(
            context: context,
            icon: Iconsax.send_2,
            value: '4.3 km',
            label: 'Distance',
            iconColor: const Color(0xFF387A7C),
          ),
          Container(height: 40, width: 1, color: AppColors.primaryappbrown),
          _buildStatsColumn(
            context: context,
            icon: Iconsax.clock,
            value: '12 min',
            label: 'Est. drive',
            iconColor: const Color(0xFFD4A750),
          ),
          Container(height: 40, width: 1, color: AppColors.primaryappbrown),
          _buildStatsColumn(
            context: context,
            icon: Iconsax.truck,
            value: 'UGX 5,500',
            label: 'Delivery fee',
            valueColor: AppColors.onboardingbutton,
            iconColor: const Color(0xFFBB483D),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsColumn({
    required BuildContext context,
    required IconData icon,
    required String value,
    required String label,
    Color? valueColor,
    Color? iconColor,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: (iconColor ?? AppColors.bordercolor).withOpacity(0.12),
          ),
          child: Icon(
            icon,
            color: iconColor ?? AppColors.bordercolor,
            size: 20,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: AppTextStyle(
            context,
          ).boldTextStyle(color: valueColor ?? AppColors.white, fontSize: 14),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTextStyle(
            context,
          ).mediumTextStyle(color: AppColors.primarytext, fontSize: 10),
        ),
      ],
    );
  }

  // ─── STEP 2: REVIEW SECTION ──────────────────────────────────────────────

  Widget _buildReviewSection(BuildContext context) {
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
        _buildStatsBox(context),
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
                ).boldTextStyle(color: AppColors.primarytext, fontSize: 12),
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
                ).regularTextStyle(color: AppColors.primarytext, fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                controller.phoneController.text,
                style: AppTextStyle(
                  context,
                ).regularTextStyle(color: AppColors.primarytext, fontSize: 14),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(Iconsax.clock, color: Color(0xFF387A7C), size: 16),
                  const SizedBox(width: 8),
                  Text(
                    'Est. arrival: 12–15 min from dispatch',
                    style: AppTextStyle(context).mediumTextStyle(
                      color: const Color(0xFF387A7C),
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

  // ─── STEP 3: PAYMENT SECTION ──────────────────────────────────────────────

  Widget _buildPaymentSection(BuildContext context) {
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
        _buildPaymentOptionCard(
          context: context,
          methodName: 'MTN Mobile Money',
          logoColor: const Color(0xFFFFCC00),
          logoLabel: 'MTN',
        ),
        const SizedBox(height: 12),

        // Airtel Option Card
        _buildPaymentOptionCard(
          context: context,
          methodName: 'Airtel Money',
          logoColor: const Color(0xFFE11900),
          logoLabel: 'Airtel',
        ),
        const SizedBox(height: 24),

        // Total amount card
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: BoxDecoration(
            color: AppColors.primaryappbrownsecond,
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
                'UGX 81,500',
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
        ElevatedButton(
          onPressed: () {
            controller.nextStep();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondary,
            foregroundColor: AppColors.white,
            elevation: 0,
            minimumSize: const Size.fromHeight(55),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Text(
            'Pay UGX 81,500 via ${controller.selectedPaymentMethod.value}',
            style: AppTextStyle(
              context,
            ).boldTextStyle(color: AppColors.white, fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentOptionCard({
    required BuildContext context,
    required String methodName,
    required Color logoColor,
    required String logoLabel,
  }) {
    final isSelected = controller.selectedPaymentMethod.value == methodName;
    return GestureDetector(
      onTap: () => controller.selectPaymentMethod(methodName),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.primaryappbrownsecond,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFF6B2657) : Colors.transparent,
            width: 2.0,
          ),
        ),
        child: Row(
          children: [
            // Custom round icon representing provider
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: logoColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  logoLabel[0],
                  style: AppTextStyle(
                    context,
                  ).boldTextStyle(color: AppColors.white, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              methodName,
              style: AppTextStyle(
                context,
              ).boldTextStyle(color: AppColors.white, fontSize: 16),
            ),
            const Spacer(),
            // Outer Radio circle
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF6B2657)
                      : AppColors.primarytext,
                  width: 2.0,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF6B2657),
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  // ─── STEP 4: ORDER CONFIRMED SECTIONS ────────────────────────────────────

  Widget _buildOrderConfirmedSection(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        // Riddim Africa Brand Logo
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF22140A),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF382111), width: 1.5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.adjust, color: AppColors.secondary, size: 28),
                const SizedBox(width: 8),
                Text(
                  'RIDDIM\nAFRICA',
                  style: AppTextStyle(context).boldTextStyle(
                    color: AppColors.onboardingbutton,
                    fontSize: 18,
                    lineHeight: 18,
                  ),
                ),
              ],
            ),
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
            color: AppColors.primaryappbrownsecond,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            children: [
              _buildOrderInfoRow(
                context: context,
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
              _buildOrderInfoRow(
                context: context,
                label: 'Expected Delivery',
                value: '3-5 Business Days',
              ),
              const Divider(color: AppColors.primaryappbrown, height: 24),
              _buildOrderInfoRow(
                context: context,
                label: 'Estimated Date',
                value: 'June 16-18, 2026',
                valueColor: AppColors.onboardingbutton,
              ),
            ],
          ),
        ),
        const SizedBox(height: 48),

        // Buttons: Track Order & Continue Shopping
        ElevatedButton.icon(
          onPressed: () {
            Get.offAllNamed('/userbottomNav');
          },
          icon: const Icon(Iconsax.box, size: 20),
          label: const Text('Track Order'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondary,
            foregroundColor: AppColors.white,
            minimumSize: const Size.fromHeight(55),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        const SizedBox(height: 16),
        OutlinedButton.icon(
          onPressed: () {
            Get.offAllNamed('/userbottomNav');
          },
          icon: const Icon(Iconsax.shop, size: 20),
          label: const Text('Continue Shopping'),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(
              color: AppColors.primaryappbrownsecond,
              width: 1.5,
            ),
            foregroundColor: AppColors.white,
            minimumSize: const Size.fromHeight(55),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderInfoRow({
    required BuildContext context,
    required String label,
    required String value,
    IconData? icon,
    Color? valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyle(
            context,
          ).mediumTextStyle(color: AppColors.primarytext, fontSize: 14),
        ),
        Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: valueColor ?? AppColors.white, size: 16),
              const SizedBox(width: 6),
            ],
            Text(
              value,
              style: AppTextStyle(context).boldTextStyle(
                color: valueColor ?? AppColors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ─── Custom Dotted Painter ────────────────────────────────────────────────

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFD4A750)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const double dashWidth = 5;
    const double dashSpace = 4;
    double startX = 36;
    final double endX = size.width - 36;
    final double y = size.height / 2;

    while (startX < endX) {
      canvas.drawLine(Offset(startX, y), Offset(startX + dashWidth, y), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
