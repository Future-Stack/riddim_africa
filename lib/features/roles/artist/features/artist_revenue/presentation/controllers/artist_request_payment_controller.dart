import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/usecases/request_artist_payout_usecase.dart';

class ArtistRequestPaymentController extends GetxController {
  final RequestArtistPayoutUseCase requestPayoutUseCase;

  ArtistRequestPaymentController({required this.requestPayoutUseCase});

  final TextEditingController orderIdController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  final RxString selectedPaymentMethod = 'Enter Payment Method'.obs;
  final List<String> paymentMethods = [
    'Enter Payment Method',
    'Airtel Money',
    'MTN Mobile Money',
    'Bank Transfer',
  ];

  final RxBool isSubmitting = false.obs;

  @override
  void onClose() {
    orderIdController.dispose();
    phoneController.dispose();
    messageController.dispose();
    super.onClose();
  }

  Future<void> submitRequest() async {
    if (orderIdController.text.trim().isEmpty) {
      Get.snackbar(
        'Required',
        'Please enter the Order ID',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
      return;
    }

    if (selectedPaymentMethod.value == 'Enter Payment Method') {
      Get.snackbar(
        'Required',
        'Please select a payment method',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
      return;
    }

    if (phoneController.text.trim().isEmpty) {
      Get.snackbar(
        'Required',
        'Please enter your phone / account number',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
      return;
    }

    try {
      isSubmitting.value = true;
      final success = await requestPayoutUseCase(
        orderId: orderIdController.text.trim(),
        paymentMethod: selectedPaymentMethod.value,
        phoneNumber: phoneController.text.trim(),
        message: messageController.text.trim().isNotEmpty
            ? messageController.text.trim()
            : null,
      );

      if (success) {
        Get.back();
        Get.snackbar(
          'Request Sent',
          'Your payout request has been sent to admin for review.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF1B4324),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to submit payout request. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      isSubmitting.value = false;
    }
  }
}
