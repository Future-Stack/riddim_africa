import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/datasources/settings_remote_data_source.dart';
import '../widgets/user_account_deleted_dialog.dart';

class UserDeleteAccountController extends GetxController {
  final SettingsRemoteDataSource _remoteDataSource;

  UserDeleteAccountController({SettingsRemoteDataSource? remoteDataSource})
      : _remoteDataSource = remoteDataSource ??
            (Get.isRegistered<SettingsRemoteDataSource>()
                ? Get.find<SettingsRemoteDataSource>()
                : SettingsRemoteDataSource());

  final TextEditingController passwordController = TextEditingController();
  final RxBool isPasswordHidden = true.obs;
  final RxBool isAgreed = false.obs;
  final RxBool isDeleting = false.obs;

  // Selected deletion reason
  final RxString selectedReason = 'Privacy concerns'.obs;

  final List<String> reasons = [
    'Privacy concerns',
    'I have another account',
    'Not using the app anymore',
    'Temporary break',
    'Other reason',
  ];

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void toggleAgreement(bool? value) {
    isAgreed.value = value ?? !isAgreed.value;
  }

  void selectReason(String reason) {
    selectedReason.value = reason;
  }

  Future<void> confirmDeleteAccount() async {
    final password = passwordController.text.trim();
    if (password.isEmpty) {
      Get.snackbar(
        'Password Required',
        'Please enter your password to confirm account deletion.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF5A1E1E),
        colorText: Colors.white,
      );
      return;
    }

    if (!isAgreed.value) {
      Get.snackbar(
        'Confirmation Required',
        'Please confirm that you understand this action cannot be undone.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF5A1E1E),
        colorText: Colors.white,
      );
      return;
    }

    try {
      isDeleting.value = true;
      final response = await _remoteDataSource.deleteAccount(
        password: password,
      );

      if (response.isSuccess) {
        UserAccountDeletedDialog.show();
      } else {
        Get.snackbar(
          'Error',
          response.errorMessage.isNotEmpty
              ? response.errorMessage
              : 'Failed to delete account',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF5A1E1E),
          colorText: Colors.white,
        );
      }
    } catch (e, stack) {
      log('[DELETE ACCOUNT EXCEPTION] $e', error: e, stackTrace: stack);
      Get.snackbar(
        'Error',
        'Failed to delete account: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF5A1E1E),
        colorText: Colors.white,
      );
    } finally {
      isDeleting.value = false;
    }
  }

  @override
  void onClose() {
    passwordController.dispose();
    super.onClose();
  }
}
