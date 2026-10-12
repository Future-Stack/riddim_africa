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
        bool isTokenExpired = false;

        if (jwtData != null && jwtData['exp'] != null) {
          final exp = jwtData['exp'];
          final expInt = exp is int
              ? exp
              : (exp is num ? exp.toInt() : int.tryParse(exp.toString()));
          if (expInt != null) {
            // exp in JWT is in seconds (10 digits) or ms (13 digits)
            final expMs = expInt > 100000000000 ? expInt : expInt * 1000;
            final expDate = DateTime.fromMillisecondsSinceEpoch(expMs);
            if (DateTime.now().isAfter(expDate)) {
              isTokenExpired = true;
            }
          }
        }

        if (isTokenExpired) {
          // Token expired, attempt to refresh before logging out
          final refreshed = await AuthController.refreshAccessToken();
          if (!refreshed) {
            // Refresh failed or no refresh token, clear storage and go to onboarding
            await StorageService.logoutUser();
            Get.offAllNamed(AppRoute.getOnboardingScreen());
            return;
          }
        }

        // Re-read role after possible token refresh
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
