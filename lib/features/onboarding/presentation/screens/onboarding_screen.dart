import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:riddimafrica/features/onboarding/presentation/controllers/onboarding_controller.dart';
import 'package:riddimafrica/features/onboarding/presentation/widgets/onboarding_page_content.dart';

class OnboardingScreen extends GetView<OnboardingController> {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CarouselSlider.builder(
        carouselController: controller.carouselController,
        itemCount: controller.onboardingPages.length,
        itemBuilder: (context, index, realIndex) {
          return Obx(
            () => OnboardingPageContent(
              pageData: controller.onboardingPages[index],
              totalPages: controller.onboardingPages.length,
              currentIndex: controller.currentIndex.value,
            ),
          );
        },
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height,
          viewportFraction: 1.0,
          enableInfiniteScroll: false,
          onPageChanged: (index, reason) {
            controller.updateIndex(index);
          },
        ),
      ),
    );
  }
}
