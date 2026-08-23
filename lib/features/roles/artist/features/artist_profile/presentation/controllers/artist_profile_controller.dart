import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riddimafrica/core/utils/constants/colors.dart';
import 'package:riddimafrica/routes/app_routes.dart';
import '../../domain/entities/artist_profile_entity.dart';
import '../../domain/usecases/get_artist_profile_usecase.dart';
import '../../domain/usecases/update_artist_profile_usecase.dart';

class ArtistProfileController extends GetxController {
  final GetArtistProfileUseCase getArtistProfileUseCase;
  final UpdateArtistProfileUseCase updateArtistProfileUseCase;

  ArtistProfileController({
    required this.getArtistProfileUseCase,
    required this.updateArtistProfileUseCase,
  });

  final Rx<ArtistProfileEntity?> profile = Rx<ArtistProfileEntity?>(null);
  final RxBool isLoading = true.obs;
  final RxBool isSaving = false.obs;
  final RxString localAvatarPath = ''.obs;

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    try {
      isLoading.value = true;
      final result = await getArtistProfileUseCase();
      profile.value = result;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load profile data',
        backgroundColor: AppColors.error.withValues(alpha: 0.8),
        colorText: AppColors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickAvatarImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );
      if (pickedFile != null) {
        localAvatarPath.value = pickedFile.path;
        Get.snackbar(
          'Photo Updated',
          'Profile picture has been updated locally.',
          backgroundColor: AppColors.primaryappbrown,
          colorText: AppColors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(16),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Could not pick image: $e',
        backgroundColor: AppColors.error.withValues(alpha: 0.8),
        colorText: AppColors.white,
      );
    }
  }

  Future<bool> saveProfile({
    required String fullName,
    required String stageName,
    required String email,
    required String phone,
    required String country,
    required String city,
    required String state,
  }) async {
    if (profile.value == null) return false;

    try {
      isSaving.value = true;
      final updated = profile.value!.copyWith(
        fullName: fullName,
        stageName: stageName,
        email: email,
        phoneNumber: phone,
        country: country,
        cityName: city,
        stateName: state,
        avatarUrl: localAvatarPath.isNotEmpty
            ? localAvatarPath.value
            : profile.value!.avatarUrl,
      );

      final saved = await updateArtistProfileUseCase(updated);
      profile.value = saved;

      Get.back(); // Return to Profile screen
      Get.snackbar(
        'Success',
        'Profile updated successfully!',
        backgroundColor: const Color(0xFF24A61E).withValues(alpha: 0.9),
        colorText: AppColors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
      return true;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to save changes: $e',
        backgroundColor: AppColors.error.withValues(alpha: 0.8),
        colorText: AppColors.white,
      );
      return false;
    } finally {
      isSaving.value = false;
    }
  }

  void logout() {
    Get.defaultDialog(
      title: 'Logout',
      titleStyle: const TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.bold,
      ),
      middleText: 'Are you sure you want to log out from your artist account?',
      middleTextStyle: const TextStyle(
        color: AppColors.primarytext,
      ),
      backgroundColor: AppColors.primaryappbrown,
      radius: 16,
      textConfirm: 'Logout',
      textCancel: 'Cancel',
      confirmTextColor: AppColors.white,
      cancelTextColor: AppColors.primarytext,
      buttonColor: AppColors.secondary,
      onConfirm: () {
        Get.back();
        Get.offAllNamed(AppRoute.loginScreen);
      },
    );
  }
}
