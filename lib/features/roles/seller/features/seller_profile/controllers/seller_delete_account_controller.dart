import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../presentation/widgets/seller_account_deleted_dialog.dart';

class SellerDeleteAccountController extends GetxController {
  final TextEditingController passwordController = TextEditingController();
  final RxBool isPasswordHidden = true.obs;
  final RxBool isAgreed = false.obs;
  final RxBool isDeleting = false.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void toggleAgreement(bool? value) {
    isAgreed.value = value ?? !isAgreed.value;
  }

  Future<void> confirmDeleteAccount() async {
    if (passwordController.text.trim().isEmpty) {
      Get.snackbar(
        'Password Required',
        'Please enter your password to confirm deletion.',
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

    isDeleting.value = true;
    await Future.delayed(const Duration(milliseconds: 700));
    isDeleting.value = false;

    SellerAccountDeletedDialog.show();
  }

  @override
  void onClose() {
    passwordController.dispose();
    super.onClose();
  }
}
