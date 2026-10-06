import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riddimafrica/core/core.dart';
import 'package:riddimafrica/features/authentication/domain/usecases/login_usecase.dart';
import 'package:riddimafrica/features/authentication/domain/usecases/register_usecase.dart';
import 'package:riddimafrica/features/authentication/domain/usecases/verify_otp_usecase.dart';
import 'package:riddimafrica/features/authentication/domain/usecases/resend_otp_usecase.dart';
import 'package:riddimafrica/features/authentication/domain/usecases/forgot_password_usecase.dart';
import 'package:riddimafrica/features/authentication/domain/usecases/reset_password_usecase.dart';
import 'package:riddimafrica/routes/app_routes.dart';

class AuthController extends GetxController {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final VerifyOtpUseCase verifyOtpUseCase;
  final ResendOtpUseCase resendOtpUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;

  AuthController({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.verifyOtpUseCase,
    required this.resendOtpUseCase,
    required this.forgotPasswordUseCase,
    required this.resetPasswordUseCase,
  });

  static Map<String, dynamic>? decodeJwtPayload(String token) {
    try {
      final parts = token.split('.');
      if (parts.length < 2) return null;
      var normalized = base64Url.normalize(parts[1]);
      final payload = utf8.decode(base64Url.decode(normalized));
      return jsonDecode(payload) as Map<String, dynamic>;
    } catch (e) {
      debugPrint('[AUTH JWT ERROR] $e');
      return null;
    }
  }

  final isLoading = false.obs;
  final isRegistering = false.obs;
  final isOtpVerifying = false.obs;
  final isResendingOtp = false.obs;
  final isForgotPasswordLoading = false.obs;
  final isForgotOtpVerifying = false.obs;
  final isForgotOtpResending = false.obs;
  final isResetPasswordLoading = false.obs;

  // --- Login State ---
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
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

  void onLoginSubmit([GlobalKey<FormState>? formKey]) {
    final key = formKey ?? loginFormKey;
    if (key.currentState?.validate() ?? false) {
      final email = loginEmailController.text.trim();
      final password = loginPasswordController.text;

      // Hit the Login API
      login(email, password);
    }
  }

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    update();

    debugPrint('====================================');
    debugPrint('[AUTH LOGIN REQUEST]');
    debugPrint('URL: ${ApiConstants.login}');
    debugPrint('Body: {"email": "$email", "password": "[PROTECTED]"}');
    debugPrint('====================================');

    try {
      final ResponseData response = await loginUseCase.execute(email, password);

      debugPrint('====================================');
      debugPrint('[AUTH LOGIN RESPONSE]');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Success: ${response.isSuccess}');
      debugPrint('Response Body: ${response.responseData}');
      debugPrint('Error Message: ${response.errorMessage}');
      debugPrint('====================================');

      if (response.isSuccess) {
        final data = response.responseData is Map
            ? response.responseData['data']
            : null;
        final accessToken = data?['accessToken']?.toString() ?? '';
        final refreshToken = data?['refreshToken']?.toString() ?? '';

        String detectedRole = selectedRole;
        String? userId;

        if (accessToken.isNotEmpty) {
          final jwtData = decodeJwtPayload(accessToken);
          if (jwtData != null) {
            debugPrint('[AUTH JWT] Decoded Token: $jwtData');
            if (jwtData['role'] != null) {
              detectedRole = jwtData['role'].toString();
            }
            if (jwtData['sub'] != null) {
              userId = jwtData['sub'].toString();
            }
          }

          await StorageService.saveAuthData(
            accessToken: accessToken,
            refreshToken: refreshToken,
            userId: userId,
            email: email,
            role: detectedRole,
          );
        }

        Get.snackbar(
          'Success',
          (response.responseData is Map &&
                  response.responseData['message'] != null)
              ? response.responseData['message']
              : 'Login successful',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withValues(alpha: 0.8),
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 8,
          duration: const Duration(seconds: 2),
        );

        final roleLower = detectedRole.toLowerCase();
        if (roleLower.contains('seller')) {
          Get.offAllNamed(AppRoute.sellerbottomNav);
        } else if (roleLower.contains('artist')) {
          Get.offAllNamed(AppRoute.artistbottomNav);
        } else {
          Get.offAllNamed(AppRoute.userbottomNav);
        }
      } else {
        // Fallback for mock demo accounts
        if (email == 'seller@gmail.com' && password == '1234') {
          await StorageService.saveAuthData(
            accessToken: 'mock_seller_access_token',
            role: 'Seller',
            email: email,
          );
          Get.offAllNamed(AppRoute.sellerbottomNav);
          return;
        } else if (email == 'artist@gmail.com' && password == '1234') {
          await StorageService.saveAuthData(
            accessToken: 'mock_artist_access_token',
            role: 'Artist',
            email: email,
          );
          Get.offAllNamed(AppRoute.artistbottomNav);
          return;
        } else if (email == 'user@gmail.com' && password == '1234') {
          await StorageService.saveAuthData(
            accessToken: 'mock_user_access_token',
            role: 'User',
            email: email,
          );
          Get.offAllNamed(AppRoute.userbottomNav);
          return;
        }

        Get.snackbar(
          'Login Failed',
          response.errorMessage.isNotEmpty
              ? response.errorMessage
              : 'Invalid email or password',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withValues(alpha: 0.8),
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 8,
        );
      }
    } catch (e) {
      debugPrint('[AUTH LOGIN EXCEPTION] $e');
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
      );
    } finally {
      isLoading.value = false;
      update();
    }
  }

  void resetLoginForm() {
    loginEmailController.clear();
    loginPasswordController.clear();
    isLoading.value = false;
    update();
  }

  void resetRegistrationForm({String? role}) {
    selectedRole = role ?? 'User';
    profileSetupStep = 0;
    profileSetupSubTab = 0;
    agreeTerms = false;
    isRegistering.value = false;

    // Personal info
    signupNameController.clear();
    signupUsernameController.clear();
    signupEmailController.clear();
    signupPhoneController.clear();
    signupAddressController.clear();
    signupCityController.clear();
    signupStateController.clear();
    signupCountryController.clear();
    signupPasswordController.clear();
    signupConfirmPasswordController.clear();
    obscureSignupPassword = true;
    obscureSignupConfirmPassword = true;

    // Verification info
    selectedVerificationDoc = 0;
    nationalIdNumberController.clear();
    passportNumberController.clear();
    drivingLicenseNumberController.clear();
    docFirstNameController.clear();
    docSurnameController.clear();
    docNumberController.clear();
    docDobController.clear();
    docExpiryController.clear();
    docNationalityController.clear();
    idFrontImagePath = null;
    idBackImagePath = null;
    selfieImagePath = null;
    passportImages.clear();
    passportDocPath = null;

    // Business info
    selectedBusinessType = -1;
    businessStoreNameController.clear();
    businessNameController.clear();
    businessEmailController.clear();
    businessPhoneController.clear();
    businessRegNumberController.clear();
    businessCityController.clear();
    businessAddressController.clear();
    businessStateController.clear();
    businessCountryController.clear();
    businessWebsiteController.clear();
    businessDescriptionController.clear();

    // Payment info
    selectedPaymentMethod = 0;
    accountHolderNameController.clear();
    mobileMoneyNumberController.clear();
    momoPhoneController.clear();
    airtelPhoneController.clear();

    update();
  }

  // --- Profile Setup State ---
  String selectedRole = 'User';
  final signupNameController = TextEditingController();
  final signupUsernameController = TextEditingController();
  final signupEmailController = TextEditingController();
  final signupPhoneController = TextEditingController();
  final signupAddressController = TextEditingController();
  final signupCityController = TextEditingController();
  final signupStateController = TextEditingController();
  final signupCountryController = TextEditingController();
  final signupPasswordController = TextEditingController();
  final signupConfirmPasswordController = TextEditingController();
  bool obscureSignupPassword = true;
  bool obscureSignupConfirmPassword = true;
  bool agreeTerms = false;

  static const Map<String, List<String>> countryCityMap = {
    'Nigeria': [
      'Lagos',
      'Abuja',
      'Port Harcourt',
      'Ibadan',
      'Kano',
      'Benin City',
      'Enugu',
      'Calabar',
      'Kaduna',
      'Warri',
      'Jos',
      'Ilorin',
      'Owerri',
      'Abeokuta',
    ],
    'Ghana': [
      'Accra',
      'Kumasi',
      'Tamale',
      'Takoradi',
      'Cape Coast',
      'Tema',
      'Sunyani',
      'Koforidua',
      'Ho',
    ],
    'South Africa': [
      'Johannesburg',
      'Cape Town',
      'Durban',
      'Pretoria',
      'Port Elizabeth',
      'Bloemfontein',
      'East London',
      'Polokwane',
    ],
    'Kenya': [
      'Nairobi',
      'Mombasa',
      'Kisumu',
      'Nakuru',
      'Eldoret',
      'Thika',
      'Malindi',
      'Kitale',
    ],
    'Uganda': [
      'Kampala',
      'Entebbe',
      'Jinja',
      'Gulu',
      'Mbarara',
      'Mukono',
    ],
    'Tanzania': [
      'Dar es Salaam',
      'Dodoma',
      'Arusha',
      'Mwanza',
      'Zanzibar City',
      'Mbeya',
    ],
    'Rwanda': [
      'Kigali',
      'Butare',
      'Gisenyi',
      'Ruhengeri',
    ],
    'Cameroon': [
      'Douala',
      'Yaoundé',
      'Bamenda',
      'Bafoussam',
    ],
    'Senegal': [
      'Dakar',
      'Thiès',
      'Kaolack',
      'Saint-Louis',
      'Touba',
    ],
    'Ivory Coast': [
      'Abidjan',
      'Bouaké',
      'Daloa',
      'Yamoussoukro',
      'San-Pédro',
    ],
    'Egypt': [
      'Cairo',
      'Alexandria',
      'Giza',
      'Port Said',
      'Luxor',
    ],
    'Ethiopia': [
      'Addis Ababa',
      'Dire Dawa',
      'Mekelle',
      'Gondar',
      'Hawassa',
    ],
    'United States': [
      'New York',
      'Los Angeles',
      'Chicago',
      'Houston',
      'Atlanta',
      'Miami',
    ],
    'United Kingdom': [
      'London',
      'Manchester',
      'Birmingham',
      'Leeds',
      'Liverpool',
    ],
    'Canada': [
      'Toronto',
      'Vancouver',
      'Montreal',
      'Calgary',
      'Ottawa',
    ],
    'Bangladesh': [
      'Dhaka',
      'Chittagong',
      'Sylhet',
      'Rajshahi',
      'Khulna',
      'Barisal',
      'Rangpur',
      'Comilla',
    ],
    'India': [
      'Mumbai',
      'Delhi',
      'Bangalore',
      'Hyderabad',
      'Chennai',
      'Kolkata',
    ],
  };

  List<String> get availableCities {
    final selectedCountry = signupCountryController.text.trim();
    return countryCityMap[selectedCountry] ?? [];
  }

  void selectCountry(String country) {
    if (signupCountryController.text != country) {
      signupCountryController.text = country;
      signupCityController.clear();
      update();
    }
  }

  void selectCity(String city) {
    signupCityController.text = city;
    update();
  }

  void setRole(String role) {
    selectedRole = role;
    if (role == 'User') {
      profileSetupStep = 0;
      profileSetupSubTab = 0;
    }
    update();
  }

  // Profile setup tab/step state
  int profileSetupStep = 0; // 0=Basic Info, 1=Business Info, 2=Payment
  int profileSetupSubTab = 0; // 0=Personal Info, 1=Verification

  void _showValidationError(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.withValues(alpha: 0.8),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      duration: const Duration(seconds: 2),
    );
  }

  bool validatePersonalInfo({bool showToast = true}) {
    final fullName = signupNameController.text.trim();
    final email = signupEmailController.text.trim();
    final phone = signupPhoneController.text.trim();
    final country = signupCountryController.text.trim();
    final city = signupCityController.text.trim();
    final password = signupPasswordController.text;
    final confirmPassword = signupConfirmPasswordController.text;

    if (fullName.isEmpty) {
      if (showToast) _showValidationError('Please enter your full name');
      return false;
    }
    if (email.isEmpty) {
      if (showToast) _showValidationError('Please enter your email address');
      return false;
    }
    if (!GetUtils.isEmail(email)) {
      if (showToast) _showValidationError('Please enter a valid email address');
      return false;
    }
    if (phone.isEmpty) {
      if (showToast) _showValidationError('Please enter your phone number');
      return false;
    }
    if (country.isEmpty) {
      if (showToast) _showValidationError('Please select your country');
      return false;
    }
    if (city.isEmpty) {
      if (showToast) _showValidationError('Please select your city');
      return false;
    }
    if (password.isEmpty) {
      if (showToast) _showValidationError('Please enter your password');
      return false;
    }
    if (password.length < 6) {
      if (showToast) _showValidationError('Password must be at least 6 characters');
      return false;
    }
    if (confirmPassword.isEmpty) {
      if (showToast) _showValidationError('Please confirm your password');
      return false;
    }
    if (password != confirmPassword) {
      if (showToast) _showValidationError('Passwords do not match');
      return false;
    }
    if (!agreeTerms) {
      if (showToast) _showValidationError('Please agree to terms and conditions');
      return false;
    }
    return true;
  }

  bool validateVerificationInfo({bool showToast = true}) {
    if (selectedRole.toLowerCase() == 'user') return true;

    final docNum = selectedVerificationDoc == 0
        ? nationalIdNumberController.text.trim()
        : selectedVerificationDoc == 1
            ? passportNumberController.text.trim()
            : drivingLicenseNumberController.text.trim();

    if (docNum.isEmpty) {
      final docName = selectedVerificationDoc == 0
          ? 'National ID'
          : selectedVerificationDoc == 1
              ? 'Passport'
              : 'Driving License';
      if (showToast) _showValidationError('Please enter your $docName number');
      return false;
    }

    final hasFront = idFrontImagePath != null && idFrontImagePath!.isNotEmpty;
    final hasBack = idBackImagePath != null && idBackImagePath!.isNotEmpty;
    final hasPassportDoc = passportDocPath != null && passportDocPath!.isNotEmpty;
    final hasPassportImgs = passportImages.isNotEmpty;

    if (selectedVerificationDoc == 0 || selectedVerificationDoc == 2) {
      if (!hasFront) {
        if (showToast) _showValidationError('Please upload the front side of your document');
        return false;
      }
      if (!hasBack) {
        if (showToast) _showValidationError('Please upload the back side of your document');
        return false;
      }
    } else {
      if (!hasFront && !hasPassportDoc && !hasPassportImgs) {
        if (showToast) _showValidationError('Please upload your passport photo/document');
        return false;
      }
    }

    return true;
  }

  bool validateBusinessInfo({bool showToast = true}) {
    if (selectedRole.toLowerCase() == 'user') return true;

    if (businessStoreNameController.text.trim().isEmpty) {
      if (showToast) _showValidationError('Please enter business / store name');
      return false;
    }
    if (selectedBusinessType < 0) {
      if (showToast) _showValidationError('Please select business type');
      return false;
    }
    if (businessCityController.text.trim().isEmpty) {
      if (showToast) _showValidationError('Please enter business city');
      return false;
    }
    if (businessAddressController.text.trim().isEmpty) {
      if (showToast) _showValidationError('Please enter business address');
      return false;
    }
    return true;
  }

  bool validatePaymentInfo({bool showToast = true}) {
    if (selectedRole.toLowerCase() == 'user') return true;

    if (selectedPaymentMethod < 0) {
      if (showToast) _showValidationError('Please select a payment method');
      return false;
    }
    if (accountHolderNameController.text.trim().isEmpty) {
      if (showToast) _showValidationError('Please enter account holder name');
      return false;
    }
    if (mobileMoneyNumberController.text.trim().isEmpty) {
      if (showToast) _showValidationError('Please enter mobile money number');
      return false;
    }
    return true;
  }

  void setProfileSetupStep(int step) {
    if (step < profileSetupStep) {
      profileSetupStep = step;
      update();
      return;
    }
    if (step >= 1) {
      if (!validatePersonalInfo()) return;
      if (!validateVerificationInfo()) {
        profileSetupSubTab = 1;
        update();
        return;
      }
    }
    if (step >= 2) {
      if (!validateBusinessInfo()) return;
    }
    profileSetupStep = step;
    update();
  }

  void setProfileSetupSubTab(int tab) {
    if (tab == 1) {
      if (!validatePersonalInfo()) return;
    }
    profileSetupSubTab = tab;
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

  Future<void> registerUser() async {
    if (isRegistering.value) return;
    isRegistering.value = true;
    update();

    try {
      if (!validatePersonalInfo()) return;

      if (selectedRole.toLowerCase() == 'seller' || selectedRole.toLowerCase() == 'artist') {
        if (!validateVerificationInfo()) {
          profileSetupStep = 0;
          profileSetupSubTab = 1;
          update();
          return;
        }
        if (!validateBusinessInfo()) {
          profileSetupStep = 1;
          update();
          return;
        }
        if (!validatePaymentInfo()) {
          profileSetupStep = 2;
          update();
          return;
        }
      }

    final email = signupEmailController.text.trim();
    final password = signupPasswordController.text;
    final confirmPassword = signupConfirmPasswordController.text;
    final fullName = signupNameController.text.trim();
    final phone = signupPhoneController.text.trim();
    final country = signupCountryController.text.trim();
    final city = signupCityController.text.trim();
    final username = signupUsernameController.text.trim().isNotEmpty
        ? signupUsernameController.text.trim()
        : (email.contains('@') ? email.split('@').first : fullName.replaceAll(' ', '').toLowerCase());

    final Map<String, dynamic> payload;

    if (selectedRole.toLowerCase() == 'seller') {
      final paymentMethodStr = selectedPaymentMethod == 1 ? 'AIRTEL_MOBILE_MONEY' : 'MTN_MOBILE_MONEY';
      final momoNum = selectedPaymentMethod == 1
          ? (airtelPhoneController.text.trim().isNotEmpty ? airtelPhoneController.text.trim() : phone)
          : (momoPhoneController.text.trim().isNotEmpty ? momoPhoneController.text.trim() : phone);
      final docTypeStr = switch (selectedVerificationDoc) {
        1 => 'PASSPORT',
        2 => 'DRIVING_LICENSE',
        _ => 'NATIONAL_ID',
      };
      final docNum = docNumberController.text.trim().isNotEmpty
          ? docNumberController.text.trim()
          : (nationalIdNumberController.text.trim().isNotEmpty
              ? nationalIdNumberController.text.trim()
              : (passportNumberController.text.trim().isNotEmpty
                  ? passportNumberController.text.trim()
                  : (drivingLicenseNumberController.text.trim().isNotEmpty
                      ? drivingLicenseNumberController.text.trim()
                      : 'NIN-123456789')));

      payload = {
        'fullName': fullName,
        'email': email,
        'phoneNumber': phone.isNotEmpty ? phone : '+2349087654321',
        'country': country.isNotEmpty ? country : 'Nigeria',
        'city': city.isNotEmpty ? city : 'Ikeja',
        'stateName': businessStateController.text.trim().isNotEmpty ? businessStateController.text.trim() : 'Lagos',
        'password': password,
        'confirmPassword': confirmPassword,
        'storeName': businessStoreNameController.text.trim().isNotEmpty
            ? businessStoreNameController.text.trim()
            : (businessNameController.text.trim().isNotEmpty ? businessNameController.text.trim() : '$fullName Store'),
        'businessTypeId': 'd6878811-a7f6-49ef-933e-1e204bdcc942',
        if (businessRegNumberController.text.trim().isNotEmpty)
          'registrationNumber': businessRegNumberController.text.trim(),
        'businessCity': businessCityController.text.trim().isNotEmpty ? businessCityController.text.trim() : (city.isNotEmpty ? city : 'Ikeja'),
        'businessAddress': businessAddressController.text.trim().isNotEmpty ? businessAddressController.text.trim() : '123, Market Road',
        if (businessWebsiteController.text.trim().isNotEmpty)
          'website': businessWebsiteController.text.trim(),
        'businessDescription': businessDescriptionController.text.trim().isNotEmpty
            ? businessDescriptionController.text.trim()
            : 'We sell authentic African merchandise.',
        'paymentMethod': paymentMethodStr,
        'accountHolderName': accountHolderNameController.text.trim().isNotEmpty
            ? accountHolderNameController.text.trim()
            : fullName,
        'mobileMoneyNumber': momoNum.isNotEmpty ? momoNum : '+2349087654321',
        'documentType': docTypeStr,
        'documentNumber': docNum,
        if (idFrontImagePath != null && idFrontImagePath!.isNotEmpty)
          'frontSide': idFrontImagePath,
        if (idBackImagePath != null && idBackImagePath!.isNotEmpty)
          'backSide': idBackImagePath,
        if (passportImages.isNotEmpty)
          'passportFiles': passportImages,
      };
    } else if (selectedRole.toLowerCase() == 'artist') {
      final paymentMethodStr = selectedPaymentMethod == 1 ? 'AIRTEL_MOBILE_MONEY' : 'MTN_MOBILE_MONEY';
      final momoNum = selectedPaymentMethod == 1
          ? (airtelPhoneController.text.trim().isNotEmpty ? airtelPhoneController.text.trim() : phone)
          : (momoPhoneController.text.trim().isNotEmpty ? momoPhoneController.text.trim() : phone);
      final docTypeStr = switch (selectedVerificationDoc) {
        1 => 'PASSPORT',
        2 => 'DRIVING_LICENSE',
        _ => 'NATIONAL_ID',
      };
      final docNum = docNumberController.text.trim().isNotEmpty
          ? docNumberController.text.trim()
          : (passportNumberController.text.trim().isNotEmpty
              ? passportNumberController.text.trim()
              : (nationalIdNumberController.text.trim().isNotEmpty
                  ? nationalIdNumberController.text.trim()
                  : (drivingLicenseNumberController.text.trim().isNotEmpty
                      ? drivingLicenseNumberController.text.trim()
                      : 'PASS-987654321')));
      final stageName = signupUsernameController.text.trim().isNotEmpty
          ? signupUsernameController.text.trim()
          : (businessStoreNameController.text.trim().isNotEmpty
              ? businessStoreNameController.text.trim()
              : fullName);

      payload = {
        'fullName': fullName,
        'stageName': stageName,
        'email': email,
        'phoneNumber': phone.isNotEmpty ? phone : '+233541234567',
        'country': country.isNotEmpty ? country : 'Ghana',
        'city': city.isNotEmpty ? city : 'Accra',
        'password': password,
        'confirmPassword': confirmPassword,
        'paymentMethod': paymentMethodStr,
        'accountHolderName': accountHolderNameController.text.trim().isNotEmpty
            ? accountHolderNameController.text.trim()
            : fullName,
        'mobileMoneyNumber': momoNum.isNotEmpty ? momoNum : (phone.isNotEmpty ? phone : '+233541234567'),
        'documentType': docTypeStr,
        'documentNumber': docNum,
        if (idFrontImagePath != null && idFrontImagePath!.isNotEmpty)
          'frontSide': idFrontImagePath,
        if (idBackImagePath != null && idBackImagePath!.isNotEmpty)
          'backSide': idBackImagePath,
        if (passportImages.isNotEmpty)
          'passportFiles': passportImages,
      };
    } else {
      payload = {
        'fullName': fullName,
        'username': username,
        'phoneNumber': phone.isNotEmpty ? phone : '+2348012345689',
        'city': city.isNotEmpty ? city : 'Lagos',
        'country': country.isNotEmpty ? country : 'Nigeria',
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
      };
    }

    final registerUrl = switch (selectedRole.toLowerCase()) {
      'artist' => ApiConstants.registerArtist,
      'seller' => ApiConstants.registerSeller,
      _ => ApiConstants.registerUser,
    };

    final sanitizedPayload = {
      ...payload,
      'password': '********',
      'confirmPassword': '********',
    };

    debugPrint('====================================');
    debugPrint('[AUTH REGISTER REQUEST]');
    debugPrint('URL: $registerUrl');
    debugPrint('Role: $selectedRole');
    debugPrint('Body: $sanitizedPayload');
    debugPrint('====================================');

    final ResponseData response = await registerUseCase.execute(
      payload,
      role: selectedRole,
    );

      debugPrint('====================================');
      debugPrint('[AUTH REGISTER RESPONSE]');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Success: ${response.isSuccess}');
      debugPrint('Response Body: ${response.responseData}');
      debugPrint('Error Message: ${response.errorMessage}');
      debugPrint('====================================');

      if (response.isSuccess) {
        final resData = response.responseData is Map
            ? response.responseData
            : {};
        final message = resData['message'] ??
            'Registration successful. An OTP has been sent to your email for verification.';

        Get.snackbar(
          'Registration Successful',
          message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withValues(alpha: 0.8),
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 8,
          duration: const Duration(seconds: 3),
        );

        // Navigate to OTP Screen
        Get.toNamed(
          AppRoute.verifyOtpScreen,
          arguments: {
            'email': email,
            'role': selectedRole,
          },
        );
      } else {
        Get.snackbar(
          'Registration Failed',
          response.errorMessage.isNotEmpty
              ? response.errorMessage
              : 'Failed to register account',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withValues(alpha: 0.8),
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 8,
        );
      }
    } catch (e) {
      debugPrint('[AUTH REGISTER EXCEPTION] $e');
      Get.snackbar(
        'Error',
        'An error occurred during registration: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
      );
    } finally {
      isRegistering.value = false;
      update();
    }
  }

  void onNextFromPersonalInfo() {
    if (!validatePersonalInfo()) return;

    if (selectedRole == 'Seller' || selectedRole == 'Artist') {
      profileSetupSubTab = 1;
      update();
    } else {
      // For User role, hitting the Register API
      registerUser();
    }
  }

  void onSignupSubmit() {
    registerUser();
  }

  // --- Registration OTP State & Actions ---
  final List<TextEditingController> regOtpControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> regOtpFocusNodes = List.generate(
    4,
    (_) => FocusNode(),
  );

  final RxInt otpCountdown = 60.obs;
  Timer? _otpTimer;

  String get formattedOtpTime {
    final mins = (otpCountdown.value ~/ 60).toString().padLeft(2, '0');
    final secs = (otpCountdown.value % 60).toString().padLeft(2, '0');
    return '$mins:$secs s';
  }

  void startOtpTimer() {
    _otpTimer?.cancel();
    otpCountdown.value = 60;
    _otpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (otpCountdown.value > 0) {
        otpCountdown.value--;
      } else {
        timer.cancel();
      }
    });
  }

  void stopOtpTimer() {
    _otpTimer?.cancel();
  }

  void clearRegOtpFields() {
    for (var c in regOtpControllers) {
      c.clear();
    }
    update();
  }

  void onRegOtpChanged(String value, int index) {
    update();
    if (value.isNotEmpty) {
      if (index < 3) {
        regOtpFocusNodes[index + 1].requestFocus();
      } else {
        regOtpFocusNodes[index].unfocus();
      }
    } else {
      if (index > 0) {
        regOtpFocusNodes[index - 1].requestFocus();
      }
    }
  }

  Future<void> verifyRegistrationOtp({
    required String email,
    String? role,
    String otpType = 'REGISTRATION',
  }) async {
    if (isOtpVerifying.value) return;
    final otp = regOtpControllers.map((c) => c.text.trim()).join();

    if (otp.length < 4) {
      Get.snackbar(
        'Incomplete OTP',
        'Please enter the full 4-digit verification code',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.withValues(alpha: 0.8),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
      );
      return;
    }

    isOtpVerifying.value = true;
    update();

    debugPrint('====================================');
    debugPrint('[AUTH VERIFY OTP REQUEST]');
    debugPrint('URL: ${ApiConstants.verifyOtp}');
    debugPrint('Body: {"email": "$email", "otp": "$otp", "otpType": "$otpType"}');
    debugPrint('====================================');

    try {
      final ResponseData response = await verifyOtpUseCase.execute(
        email: email,
        otp: otp,
        otpType: otpType,
      );

      debugPrint('====================================');
      debugPrint('[AUTH VERIFY OTP RESPONSE]');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Success: ${response.isSuccess}');
      debugPrint('Response Body: ${response.responseData}');
      debugPrint('Error Message: ${response.errorMessage}');
      debugPrint('====================================');

      if (response.isSuccess) {
        stopOtpTimer();

        final data = response.responseData is Map
            ? response.responseData['data']
            : null;
        final accessToken = data?['accessToken']?.toString() ?? '';
        final refreshToken = data?['refreshToken']?.toString() ?? '';

        String detectedRole = role ?? selectedRole;
        String? userId;

        if (accessToken.isNotEmpty) {
          final jwtData = decodeJwtPayload(accessToken);
          if (jwtData != null) {
            debugPrint('[AUTH JWT] Decoded Token: $jwtData');
            if (jwtData['role'] != null) {
              detectedRole = jwtData['role'].toString();
            }
            if (jwtData['sub'] != null) {
              userId = jwtData['sub'].toString();
            }
          }

          await StorageService.saveAuthData(
            accessToken: accessToken,
            refreshToken: refreshToken,
            userId: userId,
            email: email,
            role: detectedRole,
          );
        }

        Get.snackbar(
          'Verification Successful',
          (response.responseData is Map &&
                  response.responseData['message'] != null)
              ? response.responseData['message']
              : 'Account verified successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withValues(alpha: 0.8),
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 8,
          duration: const Duration(seconds: 2),
        );

        resetRegistrationForm();

        final targetRoleLower = detectedRole.toLowerCase();
        if (targetRoleLower.contains('artist')) {
          Get.offAllNamed(AppRoute.artistbottomNav);
        } else if (targetRoleLower.contains('seller')) {
          Get.offAllNamed(AppRoute.sellerbottomNav);
        } else {
          Get.offAllNamed(AppRoute.userbottomNav);
        }
      } else {
        Get.snackbar(
          'Verification Failed',
          response.errorMessage.isNotEmpty
              ? response.errorMessage
              : 'Invalid OTP or expired. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withValues(alpha: 0.8),
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 8,
        );
      }
    } catch (e) {
      debugPrint('[AUTH VERIFY OTP EXCEPTION] $e');
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
      );
    } finally {
      isOtpVerifying.value = false;
      update();
    }
  }

  Future<void> resendRegistrationOtp(String email) async {
    if (email.isEmpty) {
      Get.snackbar('Error', 'Email address is missing');
      return;
    }

    isResendingOtp.value = true;
    update();

    debugPrint('====================================');
    debugPrint('[AUTH RESEND OTP REQUEST]');
    debugPrint('URL: ${ApiConstants.resendOtp}');
    debugPrint('Body: {"email": "$email"}');
    debugPrint('====================================');

    try {
      final ResponseData response = await resendOtpUseCase.execute(email);

      debugPrint('====================================');
      debugPrint('[AUTH RESEND OTP RESPONSE]');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Success: ${response.isSuccess}');
      debugPrint('Response Body: ${response.responseData}');
      debugPrint('Error Message: ${response.errorMessage}');
      debugPrint('====================================');

      if (response.isSuccess) {
        startOtpTimer();
        clearRegOtpFields();

        Get.snackbar(
          'OTP Resent',
          (response.responseData is Map &&
                  response.responseData['message'] != null)
              ? response.responseData['message']
              : 'OTP resent successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withValues(alpha: 0.8),
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 8,
        );
      } else {
        Get.snackbar(
          'Failed to Resend',
          response.errorMessage.isNotEmpty
              ? response.errorMessage
              : 'Could not resend OTP. Please try again later.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withValues(alpha: 0.8),
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 8,
        );
      }
    } catch (e) {
      debugPrint('[AUTH RESEND OTP EXCEPTION] $e');
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
      );
    } finally {
      isResendingOtp.value = false;
      update();
    }
  }

  // --- Verification State ---
  int selectedVerificationDoc = 0; // 0=National ID, 1=Passport, 2=Driving License
  int get selectedDocTab => selectedVerificationDoc;
  set selectedDocTab(int val) => selectedVerificationDoc = val;
  void setDocTab(int index) => setVerificationDoc(index);

  final nationalIdNumberController = TextEditingController();
  final passportNumberController = TextEditingController();
  final drivingLicenseNumberController = TextEditingController();
  final docFirstNameController = TextEditingController();
  final docSurnameController = TextEditingController();
  final docNumberController = TextEditingController();
  final docDobController = TextEditingController();
  final docExpiryController = TextEditingController();
  final docNationalityController = TextEditingController();

  String? idFrontImagePath;
  String? idBackImagePath;
  String? selfieImagePath;

  // --- Business Details State ---
  int selectedBusinessType = -1; // 0=Individual, 1=Partnership, etc.
  final businessStoreNameController = TextEditingController();
  final businessNameController = TextEditingController();
  final businessEmailController = TextEditingController();
  final businessPhoneController = TextEditingController();
  final businessRegNumberController = TextEditingController();
  final businessCityController = TextEditingController();
  final businessAddressController = TextEditingController();
  final businessStateController = TextEditingController();
  final businessCountryController = TextEditingController();
  final businessWebsiteController = TextEditingController();
  final businessDescriptionController = TextEditingController();

  // --- Payment State ---
  int selectedPaymentMethod = 0; // 0=MTN Mobile Money, 1=Airtel Money
  final accountHolderNameController = TextEditingController();
  final mobileMoneyNumberController = TextEditingController();
  final momoPhoneController = TextEditingController();
  final airtelPhoneController = TextEditingController();

  void setVerificationDoc(int index) {
    selectedVerificationDoc = index;
    update();
  }

  void onNextFromVerification() {
    if (!validatePersonalInfo()) {
      profileSetupSubTab = 0;
      update();
      return;
    }
    if (!validateVerificationInfo()) return;

    profileSetupStep = 1; // Go to Business Info
    update();
  }

  void onNextFromBusinessInfo() {
    if (!validatePersonalInfo()) {
      profileSetupStep = 0;
      profileSetupSubTab = 0;
      update();
      return;
    }
    if (!validateVerificationInfo()) {
      profileSetupStep = 0;
      profileSetupSubTab = 1;
      update();
      return;
    }
    if (!validateBusinessInfo()) return;

    profileSetupStep = 2; // Go to Payment
    update();
  }

  void onCompleteSellerSignup() {
    if (!validatePersonalInfo()) {
      profileSetupStep = 0;
      profileSetupSubTab = 0;
      update();
      return;
    }
    if (!validateVerificationInfo()) {
      profileSetupStep = 0;
      profileSetupSubTab = 1;
      update();
      return;
    }
    if (!validateBusinessInfo()) {
      profileSetupStep = 1;
      update();
      return;
    }
    if (!validatePaymentInfo()) return;

    registerUser();
  }

  final ImagePicker _picker = ImagePicker();
  List<String> passportImages = [];
  String? passportDocPath;

  Future<void> pickIdFrontImage({ImageSource source = ImageSource.camera}) async {
    try {
      final XFile? photo = await _picker.pickImage(source: source);
      if (photo != null) {
        idFrontImagePath = photo.path;
        update();
      }
    } catch (e) {
      debugPrint('Error picking front ID: $e');
    }
  }

  Future<void> pickIdBackImage({ImageSource source = ImageSource.camera}) async {
    try {
      final XFile? photo = await _picker.pickImage(source: source);
      if (photo != null) {
        idBackImagePath = photo.path;
        update();
      }
    } catch (e) {
      debugPrint('Error picking back ID: $e');
    }
  }

  Future<void> pickPassportImage({ImageSource source = ImageSource.camera}) async {
    try {
      final XFile? photo = await _picker.pickImage(source: source);
      if (photo != null) {
        passportImages.add(photo.path);
        update();
      }
    } catch (e) {
      debugPrint('Error picking passport photo: $e');
    }
  }

  void removePassportImage(int index) {
    if (index >= 0 && index < passportImages.length) {
      passportImages.removeAt(index);
      update();
    }
  }

  Future<void> pickPassportDocument({ImageSource source = ImageSource.gallery}) async {
    try {
      final XFile? photo = await _picker.pickImage(source: source);
      if (photo != null) {
        passportDocPath = photo.path;
        update();
      }
    } catch (e) {
      debugPrint('Error picking passport doc: $e');
    }
  }

  void pickSelfieImage() {
    selfieImagePath = 'selected';
    update();
  }

  void setBusinessType(int index) {
    selectedBusinessType = index;
    update();
  }

  void setPaymentMethod(int index) {
    selectedPaymentMethod = index;
    update();
  }

  void onSellerSignupComplete() {
    onCompleteSellerSignup();
  }

  // --- Forgot Password State & Actions ---
  final forgotEmailController = TextEditingController();
  String? resetToken;

  final RxInt forgotOtpCountdown = 60.obs;
  Timer? _forgotOtpTimer;

  String get formattedForgotOtpTime {
    final mins = (forgotOtpCountdown.value ~/ 60).toString().padLeft(2, '0');
    final secs = (forgotOtpCountdown.value % 60).toString().padLeft(2, '0');
    return '$mins:$secs s';
  }

  void startForgotOtpTimer() {
    _forgotOtpTimer?.cancel();
    forgotOtpCountdown.value = 60;
    _forgotOtpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (forgotOtpCountdown.value > 0) {
        forgotOtpCountdown.value--;
      } else {
        timer.cancel();
      }
    });
  }

  void stopForgotOtpTimer() {
    _forgotOtpTimer?.cancel();
  }

  void clearForgotOtpFields() {
    for (var c in otpControllers) {
      c.clear();
    }
    update();
  }

  Future<void> onForgotPasswordSend() async {
    final email = forgotEmailController.text.trim();
    if (email.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your email address',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
      );
      return;
    }

    isForgotPasswordLoading.value = true;
    update();

    debugPrint('====================================');
    debugPrint('[AUTH FORGOT PASSWORD REQUEST]');
    debugPrint('URL: ${ApiConstants.forgotPassword}');
    debugPrint('Body: {"email": "$email"}');
    debugPrint('====================================');

    try {
      final ResponseData response = await forgotPasswordUseCase.execute(email);

      debugPrint('====================================');
      debugPrint('[AUTH FORGOT PASSWORD RESPONSE]');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Success: ${response.isSuccess}');
      debugPrint('Response Body: ${response.responseData}');
      debugPrint('Error Message: ${response.errorMessage}');
      debugPrint('====================================');

      if (response.isSuccess) {
        startForgotOtpTimer();
        clearForgotOtpFields();

        final message = (response.responseData is Map &&
                response.responseData['message'] != null)
            ? response.responseData['message']
            : 'OTP sent to email successfully';

        Get.snackbar(
          'Success',
          message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withValues(alpha: 0.8),
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 8,
          duration: const Duration(seconds: 3),
        );

        Get.toNamed(
          AppRoute.forgotPasswordOtpScreen,
          arguments: {'email': email},
        );
      } else {
        Get.snackbar(
          'Failed',
          response.errorMessage.isNotEmpty
              ? response.errorMessage
              : 'Failed to send reset code. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withValues(alpha: 0.8),
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 8,
        );
      }
    } catch (e) {
      debugPrint('[AUTH FORGOT PASSWORD EXCEPTION] $e');
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
      );
    } finally {
      isForgotPasswordLoading.value = false;
      update();
    }
  }

  // --- Forgot Password OTP State ---
  final List<TextEditingController> otpControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> otpFocusNodes = List.generate(4, (_) => FocusNode());

  void onOtpChanged(String value, int index) {
    update();
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

  Future<void> verifyOtp({String? email}) async {
    final otp = otpControllers.map((c) => c.text.trim()).join();
    final targetEmail = email ??
        (Get.arguments is Map ? Get.arguments['email'] : null) ??
        forgotEmailController.text.trim();

    if (targetEmail.isEmpty) {
      Get.snackbar(
        'Error',
        'Email address is missing',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
      );
      return;
    }

    if (otp.length < 4) {
      Get.snackbar(
        'Incomplete OTP',
        'Please enter the full 4-digit verification code',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.withValues(alpha: 0.8),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
      );
      return;
    }

    isForgotOtpVerifying.value = true;
    update();

    debugPrint('====================================');
    debugPrint('[AUTH VERIFY OTP (FORGOT PASSWORD) REQUEST]');
    debugPrint('URL: ${ApiConstants.verifyOtp}');
    debugPrint('Body: {"email": "$targetEmail", "otp": "$otp", "otpType": "PASSWORD_RESET"}');
    debugPrint('====================================');

    try {
      final ResponseData response = await verifyOtpUseCase.execute(
        email: targetEmail,
        otp: otp,
        otpType: 'PASSWORD_RESET',
      );

      debugPrint('====================================');
      debugPrint('[AUTH VERIFY OTP (FORGOT PASSWORD) RESPONSE]');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Success: ${response.isSuccess}');
      debugPrint('Response Body: ${response.responseData}');
      debugPrint('Error Message: ${response.errorMessage}');
      debugPrint('====================================');

      if (response.isSuccess) {
        stopForgotOtpTimer();

        final data = response.responseData is Map
            ? response.responseData['data']
            : null;
        resetToken = data?['resetToken']?.toString() ??
            (response.responseData is Map
                ? response.responseData['resetToken']?.toString()
                : null) ??
            '';

        debugPrint('[AUTH RESET TOKEN EXTRACTED] $resetToken');

        final message = (response.responseData is Map &&
                response.responseData['message'] != null)
            ? response.responseData['message']
            : 'OTP verified successfully';

        Get.snackbar(
          'Verification Successful',
          message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withValues(alpha: 0.8),
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 8,
          duration: const Duration(seconds: 2),
        );

        Get.toNamed(
          AppRoute.createNewPasswordScreen,
          arguments: {
            'email': targetEmail,
            'resetToken': resetToken,
          },
        );
      } else {
        Get.snackbar(
          'Verification Failed',
          response.errorMessage.isNotEmpty
              ? response.errorMessage
              : 'Invalid OTP or expired. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withValues(alpha: 0.8),
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 8,
        );
      }
    } catch (e) {
      debugPrint('[AUTH VERIFY OTP (FORGOT PASSWORD) EXCEPTION] $e');
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
      );
    } finally {
      isForgotOtpVerifying.value = false;
      update();
    }
  }

  Future<void> resendForgotPasswordOtp([String? email]) async {
    final targetEmail = email ??
        (Get.arguments is Map ? Get.arguments['email'] : null) ??
        forgotEmailController.text.trim();

    if (targetEmail.isEmpty) {
      Get.snackbar(
        'Error',
        'Email address is missing',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
      );
      return;
    }

    isForgotOtpResending.value = true;
    update();

    debugPrint('====================================');
    debugPrint('[AUTH RESEND FORGOT OTP REQUEST]');
    debugPrint('URL: ${ApiConstants.forgotPassword}');
    debugPrint('Body: {"email": "$targetEmail"}');
    debugPrint('====================================');

    try {
      final ResponseData response =
          await forgotPasswordUseCase.execute(targetEmail);

      debugPrint('====================================');
      debugPrint('[AUTH RESEND FORGOT OTP RESPONSE]');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Success: ${response.isSuccess}');
      debugPrint('Response Body: ${response.responseData}');
      debugPrint('Error Message: ${response.errorMessage}');
      debugPrint('====================================');

      if (response.isSuccess) {
        startForgotOtpTimer();
        clearForgotOtpFields();

        Get.snackbar(
          'OTP Resent',
          (response.responseData is Map &&
                  response.responseData['message'] != null)
              ? response.responseData['message']
              : 'OTP resent to your email successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withValues(alpha: 0.8),
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 8,
        );
      } else {
        Get.snackbar(
          'Failed to Resend',
          response.errorMessage.isNotEmpty
              ? response.errorMessage
              : 'Could not resend OTP. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withValues(alpha: 0.8),
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 8,
        );
      }
    } catch (e) {
      debugPrint('[AUTH RESEND FORGOT OTP EXCEPTION] $e');
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
      );
    } finally {
      isForgotOtpResending.value = false;
      update();
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

  Future<void> onUpdatePassword() async {
    final newPassword = newPasswordController.text;
    final confirmPassword = confirmNewPasswordController.text;
    final token = resetToken ??
        (Get.arguments is Map ? Get.arguments['resetToken']?.toString() : null);

    if (newPassword.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter a new password',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
      );
      return;
    }

    if (newPassword.length < 6) {
      Get.snackbar(
        'Error',
        'Password must be at least 6 characters long',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.withValues(alpha: 0.8),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
      );
      return;
    }

    if (newPassword != confirmPassword) {
      Get.snackbar(
        'Error',
        'Passwords do not match',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
      );
      return;
    }

    if (token == null || token.isEmpty) {
      Get.snackbar(
        'Error',
        'Reset token is missing or invalid. Please request a new OTP.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
      );
      return;
    }

    isResetPasswordLoading.value = true;
    update();

    debugPrint('====================================');
    debugPrint('[AUTH RESET PASSWORD REQUEST]');
    debugPrint('URL: ${ApiConstants.resetPassword}');
    debugPrint('Body: {"resetToken": "$token", "newPassword": "[PROTECTED]", "confirmNewPassword": "[PROTECTED]"}');
    debugPrint('====================================');

    try {
      final ResponseData response = await resetPasswordUseCase.execute(
        resetToken: token,
        newPassword: newPassword,
        confirmNewPassword: confirmPassword,
      );

      debugPrint('====================================');
      debugPrint('[AUTH RESET PASSWORD RESPONSE]');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Success: ${response.isSuccess}');
      debugPrint('Response Body: ${response.responseData}');
      debugPrint('Error Message: ${response.errorMessage}');
      debugPrint('====================================');

      if (response.isSuccess) {
        newPasswordController.clear();
        confirmNewPasswordController.clear();
        resetToken = null;

        final message = (response.responseData is Map &&
                response.responseData['message'] != null)
            ? response.responseData['message']
            : 'Password has been reset successfully';

        Get.snackbar(
          'Password Reset Successful',
          message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withValues(alpha: 0.8),
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 8,
          duration: const Duration(seconds: 3),
        );

        Get.offAllNamed(AppRoute.loginScreen);
      } else {
        Get.snackbar(
          'Reset Failed',
          response.errorMessage.isNotEmpty
              ? response.errorMessage
              : 'Failed to reset password. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withValues(alpha: 0.8),
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 8,
        );
      }
    } catch (e) {
      debugPrint('[AUTH RESET PASSWORD EXCEPTION] $e');
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
      );
    } finally {
      isResetPasswordLoading.value = false;
      update();
    }
  }

  @override
  void onClose() {
    _otpTimer?.cancel();
    _forgotOtpTimer?.cancel();
    loginEmailController.dispose();
    loginPasswordController.dispose();
    signupNameController.dispose();
    signupUsernameController.dispose();
    signupEmailController.dispose();
    signupPhoneController.dispose();
    signupAddressController.dispose();
    signupCityController.dispose();
    signupStateController.dispose();
    signupCountryController.dispose();
    signupPasswordController.dispose();
    signupConfirmPasswordController.dispose();
    forgotEmailController.dispose();
    nationalIdNumberController.dispose();
    passportNumberController.dispose();
    drivingLicenseNumberController.dispose();
    docFirstNameController.dispose();
    docSurnameController.dispose();
    docNumberController.dispose();
    docDobController.dispose();
    docExpiryController.dispose();
    docNationalityController.dispose();
    businessStoreNameController.dispose();
    businessNameController.dispose();
    businessEmailController.dispose();
    businessPhoneController.dispose();
    businessRegNumberController.dispose();
    businessCityController.dispose();
    businessAddressController.dispose();
    businessStateController.dispose();
    businessCountryController.dispose();
    businessWebsiteController.dispose();
    businessDescriptionController.dispose();
    accountHolderNameController.dispose();
    mobileMoneyNumberController.dispose();
    momoPhoneController.dispose();
    airtelPhoneController.dispose();
    for (var c in otpControllers) {
      c.dispose();
    }
    for (var n in otpFocusNodes) {
      n.dispose();
    }
    for (var c in regOtpControllers) {
      c.dispose();
    }
    for (var n in regOtpFocusNodes) {
      n.dispose();
    }
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.onClose();
  }
}
