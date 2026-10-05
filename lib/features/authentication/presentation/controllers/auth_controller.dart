import 'dart:async';
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

        if (accessToken.isNotEmpty) {
          await StorageService.saveAuthData(
            accessToken: accessToken,
            refreshToken: refreshToken,
            email: email,
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

        // Check if there is a role or fallback
        if (email.toLowerCase().contains('seller')) {
          Get.offAllNamed(AppRoute.sellerbottomNav);
        } else if (email.toLowerCase().contains('artist')) {
          Get.offAllNamed(AppRoute.artistbottomNav);
        } else {
          Get.offAllNamed(AppRoute.userbottomNav);
        }
      } else {
        // Fallback for mock demo accounts
        if (email == 'seller@gmail.com' && password == '1234') {
          Get.offAllNamed(AppRoute.sellerbottomNav);
          return;
        } else if (email == 'artist@gmail.com' && password == '1234') {
          Get.offAllNamed(AppRoute.artistbottomNav);
          return;
        } else if (email == 'user@gmail.com' && password == '1234') {
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

  void setProfileSetupStep(int step) {
    profileSetupStep = step;
    update();
  }

  void setProfileSetupSubTab(int tab) {
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

    if (fullName.isEmpty) {
      Get.snackbar('Error', 'Please enter your full name');
      return;
    }
    if (email.isEmpty) {
      Get.snackbar('Error', 'Please enter your email address');
      return;
    }
    if (password.isEmpty) {
      Get.snackbar('Error', 'Please enter your password');
      return;
    }
    if (password != confirmPassword) {
      Get.snackbar('Error', 'Passwords do not match');
      return;
    }
    if (!agreeTerms) {
      Get.snackbar('Error', 'Please agree to terms and conditions');
      return;
    }

    final payload = {
      'fullName': fullName,
      'username': username,
      'phoneNumber': phone.isNotEmpty ? phone : '+2348012345689',
      'city': city.isNotEmpty ? city : 'Lagos',
      'country': country.isNotEmpty ? country : 'Nigeria',
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
    };

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

    isRegistering.value = true;
    update();

    debugPrint('====================================');
    debugPrint('[AUTH REGISTER REQUEST]');
    debugPrint('URL: $registerUrl');
    debugPrint('Role: $selectedRole');
    debugPrint('Body: $sanitizedPayload');
    debugPrint('====================================');

    try {
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

        if (accessToken.isNotEmpty) {
          await StorageService.saveAuthData(
            accessToken: accessToken,
            refreshToken: refreshToken,
            email: email,
            role: role ?? selectedRole,
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

        final targetRole = role ?? selectedRole;
        if (targetRole == 'Artist') {
          Get.offAllNamed(AppRoute.artistbottomNav);
        } else if (targetRole == 'Seller') {
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
    profileSetupStep = 1; // Go to Business Info
    update();
  }

  void onNextFromBusinessInfo() {
    profileSetupStep = 2; // Go to Payment
    update();
  }

  void onCompleteSellerSignup() {
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
    registerUser();
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
