import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import '../controllers/checkout_controller.dart';
import '../widgets/checkout_step_indicator.dart';
import '../widgets/shipping_info_section.dart';
import '../widgets/add_new_address_form.dart';
import '../widgets/review_section.dart';
import '../widgets/payment_section.dart';
import '../widgets/order_confirmed_section.dart';

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
          onPressed: () {
            if (controller.currentStep.value > 0 &&
                controller.currentStep.value < 3) {
              controller.previousStep();
            } else {
              Get.back();
            }
          },
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
                          AddNewAddressForm(controller: controller),
                        ] else ...[
                          ShippingInfoSection(controller: controller),
                        ],
                      ],

                      // STEP 2: REVIEW
                      if (controller.currentStep.value == 1) ...[
                        ReviewSection(controller: controller),
                      ],

                      // STEP 3: PAYMENT
                      if (controller.currentStep.value == 2) ...[
                        PaymentSection(controller: controller),
                      ],

                      // STEP 4: PROCESSING / ORDER CONFIRMED
                      if (controller.currentStep.value == 3) ...[
                        OrderConfirmedSection(controller: controller),
                      ],
                    ],
                  ),
                ),
              ),

              // Bottom Button Bar (Only shown for steps 0 and 1)
              if (controller.currentStep.value < 2 &&
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
                          child: ProElevatedButton(
                            onPressed: controller.previousStep,
                            text: 'Back',
                            textColor: AppColors.bordercolor,
                            fontSize: 16,
                            backgroundColor: Colors.transparent,
                            border: const BorderSide(color: AppColors.bordercolor),
                            borderRadius: 16,
                            showGlow: false,
                          ),
                        ),
                        const SizedBox(width: 16),
                      ],
                      Expanded(
                        child: ProElevatedButton(
                          onPressed: () {
                            if (controller.currentStep.value <
                                controller.totalSteps - 1) {
                              controller.nextStep();
                            }
                          },
                          text: controller.currentStep.value == 1
                              ? 'Continue'
                              : 'Next',
                          trailingIcon: controller.currentStep.value == 1
                              ? Icons.arrow_forward
                              : null,
                          backgroundColor: AppColors.secondary,
                          textColor: AppColors.white,
                          fontSize: 16,
                          borderRadius: 16,
                          showGlow: true,
                          glowColor: AppColors.secondary.withValues(alpha: 0.4),
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
}
