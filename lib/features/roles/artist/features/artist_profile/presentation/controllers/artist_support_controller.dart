import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/utils/constants/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ArtistSupportController extends GetxController {
  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber.replaceAll(' ', ''),
    );
    try {
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      } else {
        Get.snackbar(
          'Could not place call',
          'Phone dialer unavailable on this device for $phoneNumber',
          backgroundColor: AppColors.primaryappbrown,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(16),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Call Error',
        'Could not initiate phone call.',
        backgroundColor: AppColors.primaryappbrown,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
    }
  }

  Future<void> sendEmail({required String email, String? subject}) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: subject != null ? {'subject': subject} : null,
    );
    try {
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      } else {
        Get.snackbar(
          'Email Support',
          'Please send an email directly to $email',
          backgroundColor: AppColors.primaryappbrown,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(16),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Email Error',
        'Please email us at $email',
        backgroundColor: AppColors.primaryappbrown,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
    }
  }
}
