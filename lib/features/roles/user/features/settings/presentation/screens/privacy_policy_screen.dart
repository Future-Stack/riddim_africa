import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import '../controllers/settings_controller.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SettingsController>();

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leadingWidth: 60,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.primaryappbrownsecond,
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
        title: Text(
          'Privacy Policy',
          style: AppTextStyle(context).boldTextStyle(
            color: AppColors.white,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoadingPolicies.value) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.onboardingbutton),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.privacyPolicy.length,
            itemBuilder: (context, index) {
              final section = controller.privacyPolicy[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      section.title,
                      style: AppTextStyle(context).boldTextStyle(
                        color: AppColors.onboardingbutton,
                        fontSize: 16,
                      ),
                    ),
                    const Gap(6),
                    Text(
                      section.content,
                      style: AppTextStyle(context).regularTextStyle(
                        color: AppColors.onboardingtext,
                        fontSize: 14,
                        lineHeight: 22,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
