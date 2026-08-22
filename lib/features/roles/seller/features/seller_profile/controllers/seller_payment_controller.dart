import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellerPaymentController extends GetxController {
  final RxnString selectedPaymentMethod = RxnString();
  final List<String> paymentMethods = [
    'MTN Mobile Money',
    'Airtel Money',
    'Standard Chartered Bank',
    'Stanbic Bank Uganda',
  ];

  late TextEditingController accountHolderController;
  late TextEditingController mobileMoneyNumberController;

  final RxBool isSaving = false.obs;

  @override
  void onInit() {
    super.onInit();
    accountHolderController = TextEditingController();
    mobileMoneyNumberController = TextEditingController();
  }

  void setPaymentMethod(String method) {
    selectedPaymentMethod.value = method;
  }

  Future<void> savePaymentDetails() async {
    isSaving.value = true;
    await Future.delayed(const Duration(milliseconds: 500));
    isSaving.value = false;
    Get.back();
    Get.snackbar(
      'Payment Method Saved',
      'Your payment method details have been successfully updated.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1B4324),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
    );
  }

  @override
  void onClose() {
    accountHolderController.dispose();
    mobileMoneyNumberController.dispose();
    super.onClose();
  }
}
