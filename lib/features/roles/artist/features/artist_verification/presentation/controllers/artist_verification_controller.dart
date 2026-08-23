import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riddimafrica/core/utils/constants/colors.dart';
import '../../domain/entities/artist_verification_entity.dart';
import '../../domain/usecases/submit_artist_verification_usecase.dart';

class ArtistVerificationController extends GetxController {
  final SubmitArtistVerificationUseCase submitArtistVerificationUseCase;

  ArtistVerificationController({
    required this.submitArtistVerificationUseCase,
  });

  final Rx<ArtistVerificationEntity?> verificationResult =
      Rx<ArtistVerificationEntity?>(null);
  final RxString selectedFilePath = ''.obs;
  final RxString selectedFileName = ''.obs;
  final RxBool isLoading = false.obs;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickDocument() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 90,
      );
      if (pickedFile != null) {
        selectedFilePath.value = pickedFile.path;
        selectedFileName.value = pickedFile.name;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Could not select document: $e',
        backgroundColor: AppColors.error.withValues(alpha: 0.8),
        colorText: AppColors.white,
      );
    }
  }

  void removeFile() {
    selectedFilePath.value = '';
    selectedFileName.value = '';
  }

  Future<void> submit() async {
    if (selectedFilePath.isEmpty) {
      Get.snackbar(
        'Upload Required',
        'Please upload your business license or copyright proof first.',
        backgroundColor: AppColors.warning.withValues(alpha: 0.9),
        colorText: AppColors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
      return;
    }

    try {
      isLoading.value = true;
      final result = await submitArtistVerificationUseCase(
        filePath: selectedFilePath.value,
        fileName: selectedFileName.value,
      );
      verificationResult.value = result;

      Get.back();
      Get.snackbar(
        'Submitted For Review',
        'Your verification documents have been submitted. Review usually takes 24-48 hours.',
        backgroundColor: const Color(0xFF24A61E).withValues(alpha: 0.9),
        colorText: AppColors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 4),
      );
    } catch (e) {
      Get.snackbar(
        'Submission Failed',
        'Failed to submit documents: $e',
        backgroundColor: AppColors.error.withValues(alpha: 0.8),
        colorText: AppColors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
