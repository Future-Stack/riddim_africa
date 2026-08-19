import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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
      final email = loginEmailController.text.trim();
      final password = loginPasswordController.text;

      if (email == 'seller@gmail.com' && password == '1234') {
        Get.offAllNamed(AppRoute.sellerbottomNav);
      } else if (email == 'artist@g.com') {
        Get.offAllNamed(AppRoute.artistbottomNav);
      } else {
        Get.offAllNamed(AppRoute.userbottomNav);
      }
    }
  }

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    update();
    try {
      final ResponseData response = await loginUseCase.execute(email, password);
      if (response.isSuccess) {
        Get.offAllNamed(AppRoute.artistbottomNav);
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
  final signupAddressController = TextEditingController();
  final signupCityController = TextEditingController();
  final signupStateController = TextEditingController();
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

  // Profile setup tab/step state
  int profileSetupStep = 0;    // 0=Basic Info, 1=Business Info, 2=Payment
  int profileSetupSubTab = 0;  // 0=Personal Info, 1=Verification

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

  void onSignupSubmit() {
    if (agreeTerms) {
      if (selectedRole == 'Seller') {
        // Seller goes through full verification flow
        selectedDocTab = 1; // Default to Passport tab
        update();
        Get.toNamed(AppRoute.sellerDocumentFormScreen);
      } else {
        Get.offAllNamed(AppRoute.userbottomNav);
      }
    } else {
      Get.snackbar('Error', 'Please agree to terms and conditions');
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
  int selectedBusinessType = -1; // 0=Individual / Solo Trader, 1=Partnership, 2=Registered Company, 3=NGO / Non-profit
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

  void onNextFromPersonalInfo() {
    if (selectedRole == 'Seller') {
      profileSetupSubTab = 1;
      update();
    } else {
      if (agreeTerms) {
        Get.offAllNamed(AppRoute.userbottomNav);
      } else {
        Get.snackbar('Error', 'Please agree to terms and conditions');
      }
    }
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
    Get.offAllNamed(AppRoute.sellerbottomNav);
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
    Get.offAllNamed(AppRoute.sellerbottomNav);
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
  final List<TextEditingController> otpControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
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
    if (newPasswordController.text.isNotEmpty &&
        confirmNewPasswordController.text.isNotEmpty) {
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
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.onClose();
  }
}
