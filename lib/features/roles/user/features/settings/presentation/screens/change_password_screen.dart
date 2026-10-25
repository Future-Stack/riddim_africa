import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:riddimafrica/core/core.dart';
import '../controllers/settings_controller.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final SettingsController controller = Get.find<SettingsController>();

  final currentPasswordCtrl = TextEditingController();
  final newPasswordCtrl = TextEditingController();
  final confirmPasswordCtrl = TextEditingController();

  @override
  void dispose() {
    currentPasswordCtrl.dispose();
    newPasswordCtrl.dispose();
    confirmPasswordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: const GlobalAppBar(
        title: 'Settings',
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(8),
                Text(
                  'Change Password',
                  style: AppTextStyle(context).boldTextStyle(
                    color: AppColors.onboardingbutton,
                    fontSize: 22,
                  ),
                ),
                const Gap(24),

                // ─── Current Password ──────────────────────────────────────
                Obx(() => ProTextField(
                      labelText: 'Current Password',
                      hintText: 'Enter current password',
                      obscureText: controller.obscureCurrentPassword.value,
                      controller: currentPasswordCtrl,
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.obscureCurrentPassword.value
                              ? Iconsax.eye_slash
                              : Iconsax.eye,
                          color: AppColors.primarytext,
                        ),
                        onPressed: controller.toggleObscureCurrent,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter current password';
                        }
                        return null;
                      },
                    )),
                const Gap(20),

                // ─── New Password ──────────────────────────────────────────
                Obx(() => ProTextField(
                      labelText: 'New Password',
                      hintText: 'Enter new password',
                      obscureText: controller.obscureNewPassword.value,
                      controller: newPasswordCtrl,
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.obscureNewPassword.value
                              ? Iconsax.eye_slash
                              : Iconsax.eye,
                          color: AppColors.primarytext,
                        ),
                        onPressed: controller.toggleObscureNew,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter new password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    )),
                const Gap(20),

                // ─── Re-Enter New Password ─────────────────────────────────
                Obx(() => ProTextField(
                      labelText: 'Re-Enter New Password',
                      hintText: 'Re-enter new password',
                      obscureText: controller.obscureConfirmPassword.value,
                      controller: confirmPasswordCtrl,
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.obscureConfirmPassword.value
                              ? Iconsax.eye_slash
                              : Iconsax.eye,
                          color: AppColors.primarytext,
                        ),
                        onPressed: controller.toggleObscureConfirm,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please re-enter new password';
                        }
                        if (value != newPasswordCtrl.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    )),
                const Gap(32),

                // ─── Confirm Button ────────────────────────────────────────
                Obx(
                  () => ProElevatedButton(
                    text: 'Confirm',
                    isLoading: controller.isLoadingChangePassword.value,
                    backgroundColor: AppColors.secondary,
                    textColor: AppColors.white,
                    onPressed: controller.isLoadingChangePassword.value
                        ? null
                        : () {
                            if (_formKey.currentState?.validate() ?? false) {
                              controller.updatePassword(
                                currentPassword: currentPasswordCtrl.text.trim(),
                                newPassword: newPasswordCtrl.text.trim(),
                                confirmPassword: confirmPasswordCtrl.text.trim(),
                              );
                            }
                          },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
