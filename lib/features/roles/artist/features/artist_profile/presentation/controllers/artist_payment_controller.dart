import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArtistPaymentController extends GetxController {
  final List<String> paymentMethods = [
    'MTN Mobile Money',
    'Airtel Money',
    'Bank Transfer',
    'PayPal',
  ];

  final Rx<String?> selectedPaymentMethod = Rx<String?>('MTN Mobile Money');
  final TextEditingController accountHolderController = TextEditingController();
  final TextEditingController mobileMoneyNumberController = TextEditingController();

  final RxBool isSaving = false.obs;

  void setPaymentMethod(String method) {
    selectedPaymentMethod.value = method;
  }

  Future<void> savePaymentDetails() async {
    if (accountHolderController.text.trim().isEmpty &&
        mobileMoneyNumberController.text.trim().isEmpty) {
      Get.snackbar(
        'Incomplete Information',
        'Please enter your account holder name and mobile money number.',
        backgroundColor: const Color(0xFF5A1E1E),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
      return;
    }

    isSaving.value = true;
    await Future.delayed(const Duration(milliseconds: 1200));
    isSaving.value = false;

    Get.snackbar(
      'Payment Method Saved',
      'Your payment information has been updated successfully.',
      backgroundColor: const Color(0xFF163E1C),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      icon: const Icon(Icons.check_circle, color: Color(0xFF34C759)),
    );
  }

  @override
  void onClose() {
    accountHolderController.dispose();
    mobileMoneyNumberController.dispose();
    super.onClose();
  }
}
