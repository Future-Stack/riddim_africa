import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app.dart';
import 'core/controllers/theme_controller.dart';
import 'core/services/cache/storage_service.dart';
import 'core/services/network/network_caller.dart';
import 'features/authentication/presentation/controllers/auth_controller.dart';
import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Needed before any token-based network/storage access.
  await StorageService.init();

  // Configure token refresh and session handling
  NetworkCaller().tokenRefresher = AuthController.refreshAccessToken;
  NetworkCaller().onSessionExpired = () {
    Get.offAllNamed(AppRoute.welcomescreen);
  };

  Get.put<ThemeController>(ThemeController(), permanent: true);

  runApp(const MyApp());
}
