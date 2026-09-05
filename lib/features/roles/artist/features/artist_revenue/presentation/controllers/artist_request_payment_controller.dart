import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArtistRequestPaymentController extends GetxController {
  final TextEditingController orderIdController =
      TextEditingController(text: 'PRD ID 5454');
  final RxString selectedPaymentMethod = 'Enter Payment Method'.obs;
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  final List<String> paymentMethods = [
    'Enter Payment Method',
    'Airtel Money',
    'MTN Mobile Money',
    'Bank Transfer',
  ];

  @override
  void onClose() {
    orderIdController.dispose();
    phoneController.dispose();
    messageController.dispose();
    super.onClose();
  }

  void submitRequest() {
    Get.back();
    Get.snackbar(
      'Request Sent',
      'Your payout request has been sent to Admin successfully.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1B3B2B),
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(16),
    );
  }
}
