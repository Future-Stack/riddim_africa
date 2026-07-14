import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/features/authentication/domain/usecases/login_usecase.dart';
import 'package:riddimafrica/core/models/response_data.dart';
import 'package:riddimafrica/routes/app_routes.dart';

class AuthController extends GetxController {
  final LoginUseCase loginUseCase;

  AuthController(this.loginUseCase);

  final isLoading = false.obs;

  // --- Login State ---
  final loginFormKey = GlobalKey<FormState>();
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();
  bool obscureLoginPassword = true;
  bool rememberMe = false;

  void toggleLoginPasswordVisibility() {
    obscureLoginPassword = !obscureLoginPassword;
    update();
  }

  void toggleRememberMe(bool? val) {
    rememberMe = val ?? false;
    update();
  }

  void onLoginSubmit() {
    if (loginFormKey.currentState?.validate() ?? false) {
      Get.offAllNamed(AppRoute.userbottomNav);
    }
  }

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    update();
    try {
      final ResponseData response = await loginUseCase.execute(email, password);
      if (response.isSuccess) {
        Get.offAllNamed(AppRoute.userbottomNav);
      } else {
        Get.snackbar('Error', 'Login failed');
      }
    } finally {
      isLoading.value = false;
      update();
    }
  }

  // --- Profile Setup State ---
  String selectedRole = 'User';
  final signupNameController = TextEditingController();
  final signupUsernameController = TextEditingController();
  final signupEmailController = TextEditingController();
  final signupPhoneController = TextEditingController();
  final signupCityController = TextEditingController();
  final signupCountryController = TextEditingController();
  final signupPasswordController = TextEditingController();
  final signupConfirmPasswordController = TextEditingController();
  bool obscureSignupPassword = true;
  bool obscureSignupConfirmPassword = true;
  bool agreeTerms = false;

  void setRole(String role) {
    selectedRole = role;
    update();
  }

  void toggleSignupPasswordVisibility() {
    obscureSignupPassword = !obscureSignupPassword;
    update();
  }

  void toggleSignupConfirmPasswordVisibility() {
    obscureSignupConfirmPassword = !obscureSignupConfirmPassword;
    update();
  }

  void toggleAgreeTerms(bool? val) {
    agreeTerms = val ?? false;
    update();
  }

  void onSignupSubmit() {
    if (agreeTerms) {
      Get.offAllNamed(AppRoute.userbottomNav);
    } else {
      Get.snackbar('Error', 'Please agree to terms and conditions');
    }
  }

  // --- Forgot Password (Email) State ---
  final forgotEmailController = TextEditingController();

  void onForgotPasswordSend() {
    if (forgotEmailController.text.isNotEmpty) {
      Get.toNamed(AppRoute.forgotPasswordOtpScreen);
    } else {
      Get.snackbar('Error', 'Please enter your email');
    }
  }

  // --- Forgot Password OTP State ---
  final List<TextEditingController> otpControllers = List.generate(4, (_) => TextEditingController());
  final List<FocusNode> otpFocusNodes = List.generate(4, (_) => FocusNode());

  void onOtpChanged(String value, int index) {
    update(); // Rebuild for border color
    if (value.isNotEmpty) {
      if (index < 3) {
        otpFocusNodes[index + 1].requestFocus();
      } else {
        otpFocusNodes[index].unfocus();
      }
    } else {
      if (index > 0) {
        otpFocusNodes[index - 1].requestFocus();
      }
    }
  }

  void verifyOtp() {
    bool isComplete = otpControllers.every((c) => c.text.isNotEmpty);
    if (isComplete) {
      Get.toNamed(AppRoute.createNewPasswordScreen);
    } else {
      Get.snackbar('Error', 'Please enter the full 4-digit code');
    }
  }

  // --- Create New Password State ---
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();
  bool obscureNewPassword = true;
  bool obscureConfirmNewPassword = true;

  void toggleNewPasswordVisibility() {
    obscureNewPassword = !obscureNewPassword;
    update();
  }

  void toggleConfirmNewPasswordVisibility() {
    obscureConfirmNewPassword = !obscureConfirmNewPassword;
    update();
  }

  void onUpdatePassword() {
    if (newPasswordController.text.isNotEmpty && confirmNewPasswordController.text.isNotEmpty) {
      Get.offAllNamed(AppRoute.loginScreen);
    } else {
      Get.snackbar('Error', 'Please fill both password fields');
    }
  }

  @override
  void onClose() {
    loginEmailController.dispose();
    loginPasswordController.dispose();
    signupNameController.dispose();
    signupUsernameController.dispose();
    signupEmailController.dispose();
    signupPhoneController.dispose();
    signupCityController.dispose();
    signupCountryController.dispose();
    signupPasswordController.dispose();
    signupConfirmPasswordController.dispose();
    forgotEmailController.dispose();
    for (var c in otpControllers) {
      c.dispose();
    }
    for (var n in otpFocusNodes) {
      n.dispose();
    }
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.onClose();
  }
}
