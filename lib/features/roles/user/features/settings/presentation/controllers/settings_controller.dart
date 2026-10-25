import 'dart:developer';
import 'package:get/get.dart';
import '../../data/datasources/settings_remote_data_source.dart';
import '../../domain/entities/faq_entity.dart';
import '../../domain/entities/policy_entity.dart';
import '../../domain/usecases/get_faqs_usecase.dart';
import '../../domain/usecases/get_policy_usecase.dart';

class SettingsController extends GetxController {
  final GetFaqsUseCase getFaqsUseCase;
  final GetPolicyUseCase getPolicyUseCase;
  final SettingsRemoteDataSource _remoteDataSource;

  SettingsController({
    required this.getFaqsUseCase,
    required this.getPolicyUseCase,
    SettingsRemoteDataSource? remoteDataSource,
  }) : _remoteDataSource = remoteDataSource ??
            (Get.isRegistered<SettingsRemoteDataSource>()
                ? Get.find<SettingsRemoteDataSource>()
                : SettingsRemoteDataSource());

  // Notification states
  final RxBool orderNotifications = true.obs;
  final RxBool artistUpdates = false.obs;
  final RxBool radioAlerts = true.obs;

  // Password visibility states for Change Password screen
  final RxBool obscureCurrentPassword = true.obs;
  final RxBool obscureNewPassword = true.obs;
  final RxBool obscureConfirmPassword = true.obs;

  // Change password loading state
  final RxBool isLoadingChangePassword = false.obs;

  // Policies and FAQs state
  final RxList<FaqEntity> faqs = <FaqEntity>[].obs;
  final RxList<PolicyEntity> privacyPolicy = <PolicyEntity>[].obs;
  final RxList<PolicyEntity> refundPolicy = <PolicyEntity>[].obs;
  final RxList<PolicyEntity> cookieNotice = <PolicyEntity>[].obs;
  final RxList<PolicyEntity> communityGuidelines = <PolicyEntity>[].obs;

  final RxBool isLoadingFaqs = false.obs;
  final RxBool isLoadingPolicies = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadFaqs();
    loadAllPolicies();
  }

  // Load FAQs
  Future<void> loadFaqs() async {
    isLoadingFaqs.value = true;
    try {
      final result = await getFaqsUseCase.execute();
      faqs.assignAll(result);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load FAQs: $e');
    } finally {
      isLoadingFaqs.value = false;
    }
  }

  // Load Policies
  Future<void> loadAllPolicies() async {
    isLoadingPolicies.value = true;
    try {
      final privacy = await getPolicyUseCase.execute('privacy');
      privacyPolicy.assignAll(privacy);

      final refund = await getPolicyUseCase.execute('refund');
      refundPolicy.assignAll(refund);

      final cookie = await getPolicyUseCase.execute('cookie');
      cookieNotice.assignAll(cookie);

      final community = await getPolicyUseCase.execute('community');
      communityGuidelines.assignAll(community);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load policy data: $e');
    } finally {
      isLoadingPolicies.value = false;
    }
  }

  // Change notification switch methods
  void setOrderNotifications(bool val) => orderNotifications.value = val;
  void setArtistUpdates(bool val) => artistUpdates.value = val;
  void setRadioAlerts(bool val) => radioAlerts.value = val;

  // Toggle visibility methods
  void toggleObscureCurrent() =>
      obscureCurrentPassword.value = !obscureCurrentPassword.value;
  void toggleObscureNew() =>
      obscureNewPassword.value = !obscureNewPassword.value;
  void toggleObscureConfirm() =>
      obscureConfirmPassword.value = !obscureConfirmPassword.value;

  // Update password method via POST /api/v1/auth/change-password
  Future<bool> updatePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    if (newPassword != confirmPassword) {
      Get.snackbar(
        'Error',
        'New password and confirm password do not match',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    try {
      isLoadingChangePassword.value = true;
      final response = await _remoteDataSource.changePassword(
        oldPassword: currentPassword,
        newPassword: newPassword,
        confirmNewPassword: confirmPassword,
      );

      if (response.isSuccess) {
        Get.back();
        Get.snackbar(
          'Success',
          (response.responseData is Map &&
                  response.responseData['message'] != null)
              ? response.responseData['message'].toString()
              : 'Password changed successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
        return true;
      } else {
        Get.snackbar(
          'Error',
          response.errorMessage.isNotEmpty
              ? response.errorMessage
              : 'Failed to change password',
          snackPosition: SnackPosition.BOTTOM,
        );
        return false;
      }
    } catch (e, stack) {
      log('[CHANGE PASSWORD EXCEPTION] $e', error: e, stackTrace: stack);
      Get.snackbar(
        'Error',
        'An unexpected error occurred: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      isLoadingChangePassword.value = false;
    }
  }
}
