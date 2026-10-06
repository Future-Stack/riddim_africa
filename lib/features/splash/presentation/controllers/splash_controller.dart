import 'dart:async';

import 'package:get/get.dart';
import 'package:riddimafrica/core/services/cache/storage_service.dart';
import 'package:riddimafrica/features/authentication/presentation/controllers/auth_controller.dart';
import 'package:riddimafrica/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    _handleNavigation();
  }

  void _handleNavigation() {
    Timer(const Duration(seconds: 2), () async {
      final token = StorageService.token;

      if (token != null && token.isNotEmpty) {
        // Check JWT expiration if available
        final jwtData = AuthController.decodeJwtPayload(token);
        if (jwtData != null && jwtData['exp'] != null) {
          final exp = jwtData['exp'];
          if (exp is int) {
            final expDate = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
            if (DateTime.now().isAfter(expDate)) {
              // Token expired, clear storage and go to onboarding
              await StorageService.logoutUser();
              Get.offAllNamed(AppRoute.getOnboardingScreen());
              return;
            }
          }
        }

        String role = StorageService.role ?? '';
        if (role.isEmpty && jwtData != null && jwtData['role'] != null) {
          role = jwtData['role'].toString();
        }

        final roleLower = role.toLowerCase();
        if (roleLower.contains('seller')) {
          Get.offAllNamed(AppRoute.sellerbottomNav);
        } else if (roleLower.contains('artist')) {
          Get.offAllNamed(AppRoute.artistbottomNav);
        } else {
          Get.offAllNamed(AppRoute.userbottomNav);
        }
      } else {
        Get.offAllNamed(AppRoute.getOnboardingScreen());
      }
    });
  }
}
