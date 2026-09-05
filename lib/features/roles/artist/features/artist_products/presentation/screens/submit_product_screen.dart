import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import '../controllers/submit_product_controller.dart';
import '../widgets/submit_step_indicator.dart';
import '../widgets/submit_step_1_details.dart';
import '../widgets/submit_step_2_photos.dart';
import '../widgets/submit_step_3_pricing.dart';

class ArtistSubmitProductScreen extends GetView<ArtistSubmitProductController> {
  const ArtistSubmitProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure controller is registered
    final c = Get.isRegistered<ArtistSubmitProductController>()
        ? Get.find<ArtistSubmitProductController>()
        : Get.put(ArtistSubmitProductController());

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leadingWidth: 56,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
          child: GestureDetector(
            onTap: () {
              if (c.currentStep.value > 1) {
                c.previousStep();
              } else {
                Get.back();
              }
            },
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.appbardivider,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back,
                color: AppColors.white,
                size: 20,
              ),
            ),
          ),
        ),
        title: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Submit Product',
                style: AppTextStyle(context).boldTextStyle(
                  color: AppColors.white,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Step ${c.currentStep.value} of 3',
                style: AppTextStyle(context).regularTextStyle(
                  color: AppColors.primarytext,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Step Progress Indicator
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Obx(
              () => SubmitStepIndicator(currentStep: c.currentStep.value),
            ),
          ),

          // Step Content
          Expanded(
            child: Obx(() {
              switch (c.currentStep.value) {
                case 1:
                  return const SubmitStep1Details();
                case 2:
                  return const SubmitStep2Photos();
                case 3:
                  return const SubmitStep3Pricing();
                default:
                  return const SubmitStep1Details();
              }
            }),
          ),
        ],
      ),
    );
  }
}
