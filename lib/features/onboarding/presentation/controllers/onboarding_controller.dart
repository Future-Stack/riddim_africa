import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/utils/constants/colors.dart';
import 'package:riddimafrica/core/utils/constants/image_path.dart';
import 'package:riddimafrica/features/onboarding/domain/entities/onboarding_entity.dart';
import 'package:riddimafrica/routes/app_routes.dart';
import 'package:riddimafrica/core/common/common_button/common_button.dart';

import 'package:carousel_slider/carousel_slider.dart';

class OnboardingController extends GetxController {
  final RxInt currentIndex = 0.obs;
  final CarouselSliderController carouselController =
      CarouselSliderController();

  late final List<OnboardingEntity> onboardingPages;

  @override
  void onInit() {
    super.onInit();
    _initializePages();
  }

  @override
  void onClose() {
    // carouselController does not have dispose() in latest versions,
    // or if it does, it's optional. But standard is not strictly required.
    super.onClose();
  }

  void _initializePages() {
    onboardingPages = [
      OnboardingEntity(
        bgImagePath: ImagePath.onboard3,
        centerLogoPath: ImagePath.onlogo3,
        showTopRightLogo: true,
        showDots: false,
        title: 'Welcome To Riddim Africa',
        subtitle:
            'Your favorite vibes, hottest hits, and nonstop rhythm are just a click away.',
        buttons: [
          ProElevatedButton(
            showGlow: true,
            text: 'Go Ahead',
            trailingIcon: Icons.arrow_forward_ios,
            backgroundColor: AppColors.secondary,
            textColor: AppColors.white,
            onPressed: nextPage,
          ),
        ],
      ),
      OnboardingEntity(
        bgImagePath: ImagePath.onboard6,
        centerLogoPath: ImagePath.onLogo1,
        showTopRightLogo: true,
        showDots: true,
        title: 'Listen. Discover. Connect.',
        subtitle:
            'Explore Africa\'s music, artists and cultural marketplace from one beautiful place.',
        buttons: [
          ProElevatedButton(
            showGlow: true,
            text: 'Next',
            trailingIcon: Icons.arrow_forward_ios,
            backgroundColor: AppColors.secondary,
            textColor: AppColors.white,
            onPressed: nextPage,
          ),
        ],
      ),

      OnboardingEntity(
        bgImagePath: ImagePath.onboard4,
        centerLogoPath: ImagePath.onlogo2,
        showTopRightLogo: true,
        showDots: true,
        title: 'Stay Connected Through Radio',
        subtitle:
            'Listen to live radio while browsing products. Music never stops.',
        buttons: [
          ProElevatedButton(
            showGlow: true,
            text: 'Next',
            trailingIcon: Icons.arrow_forward_ios,
            backgroundColor: AppColors.secondary,
            textColor: AppColors.white,
            onPressed: nextPage,
          ),
        ],
      ),
      OnboardingEntity(
        bgImagePath: ImagePath.onboard1,
        centerLogoPath: null,
        showTopRightLogo: true,
        showDots: true,
        title: 'Shop Authentic Products',
        subtitle:
            'Support local creators and artists through marketplace purchases.',
        buttons: [
          ProElevatedButton(
            showGlow: true,
            text: 'Get Started',
            trailingIcon: Icons.arrow_forward_ios,
            backgroundColor: AppColors.onboardingbutton,
            textColor: AppColors.white,
            onPressed: _goToNextFeature,
          ),
        ],
      ),
    ];
  }

  void updateIndex(int index) {
    currentIndex.value = index;
  }

  void nextPage() {
    if (currentIndex.value < onboardingPages.length - 1) {
      carouselController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousPage() {
    if (currentIndex.value > 0) {
      carouselController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToNextFeature() {
    // Final Get Started button action (e.g. go to Login or Dashboard)
    Get.offAllNamed(AppRoute.getwelcomescreen());
  }
}
