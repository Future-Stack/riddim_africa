import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import '../controllers/settings_controller.dart';

class CommunityGuidelinesScreen extends StatelessWidget {
  const CommunityGuidelinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SettingsController>();

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: const GlobalAppBar(
        title: 'Community Guidelines',
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
            itemCount: controller.communityGuidelines.length,
            itemBuilder: (context, index) {
              final section = controller.communityGuidelines[index];
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
