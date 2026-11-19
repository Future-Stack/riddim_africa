import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellerChangePasswordController extends GetxController {
  late TextEditingController currentPasswordController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;

  final RxBool obscureCurrent = true.obs;
  final RxBool obscureNew = true.obs;
  final RxBool obscureConfirm = true.obs;
  final RxBool isUpdating = false.obs;

  @override
  void onInit() {
    super.onInit();
    currentPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  void toggleCurrent() => obscureCurrent.value = !obscureCurrent.value;
  void toggleNew() => obscureNew.value = !obscureNew.value;
  void toggleConfirm() => obscureConfirm.value = !obscureConfirm.value;

  Future<void> updatePassword(Function() onSuccess) async {
    if (currentPasswordController.text.isEmpty) {
      Get.snackbar(
        'Required Field',
        'Please enter your current password.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (newPasswordController.text.isEmpty) {
      Get.snackbar(
        'Required Field',
        'Please enter your new password.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (newPasswordController.text != confirmPasswordController.text) {
      Get.snackbar(
        'Mismatch',
        'New password and confirm password do not match.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isUpdating.value = true;
    await Future.delayed(const Duration(milliseconds: 600));
    isUpdating.value = false;

    currentPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();

    onSuccess();
  }

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
