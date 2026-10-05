import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riddimafrica/core/core.dart';
import 'package:riddimafrica/features/authentication/presentation/controllers/auth_controller.dart';
import 'package:riddimafrica/routes/app_routes.dart';

class ProfileSetupScreen extends StatelessWidget {
  const ProfileSetupScreen({super.key});

  static const _steps = [
    {'label': 'Basic Info', 'icon': IconPath.basicInfo},
    {'label': 'Business Info', 'icon': IconPath.businessInfo},
    {'label': 'Payment', 'icon': IconPath.paymentInfo},
  ];

  static const List<String> _businessTypes = [
    'Individual / Solo Trader',
    'Partnership',
    'Registered Company',
    'NGO / Non-profit',
  ];

  static const List<String> _paymentMethods = [
    'MTN Mobile Money',
    'Airtel Money',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.backgroundcolor,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.cardBorder),
            ),
            child: const Icon(Icons.arrow_back, color: AppColors.white, size: 18),
          ),
          onPressed: () {
            final controller = Get.find<AuthController>();
            if (controller.profileSetupStep > 0) {
              controller.setProfileSetupStep(controller.profileSetupStep - 1);
            } else if (controller.profileSetupSubTab > 0) {
              controller.setProfileSetupSubTab(0);
            } else {
              Get.back();
            }
          },
        ),
      ),
      body: SafeArea(
        child: GetBuilder<AuthController>(
          builder: (controller) {
            return Column(
              children: [
                // ── Top Logo & Title ──────────────────────────────────────
                Image.asset(ImagePath.onlogo3, height: 60.h, fit: BoxFit.contain),
                SizedBox(height: 6.h),

                // Step 0: Basic Info -> Show Profile Setup title & role selector
                if (controller.profileSetupStep == 0 && controller.profileSetupSubTab == 0) ...[
                  Text(
                    'Profile Setup',
                    style: AppTextStyle(context).boldTextStyle(
                      fontSize: AppTextStyle.title,
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Select Your Role to RiddimAfrica',
                    style: AppTextStyle(context).regularTextStyle(
                      fontSize: AppTextStyle.md,
                      color: AppColors.onboardingtext,
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // Role selector radios
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: ['User', 'Artist', 'Seller'].map((role) {
                      final isSelected = controller.selectedRole == role;
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: GestureDetector(
                          onTap: () => controller.setRole(role),
                          child: Row(
                            children: [
                              Container(
                                width: 18.w,
                                height: 18.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColors.bordercolor
                                        : AppColors.onboardingtext,
                                    width: 2,
                                  ),
                                ),
                                child: isSelected
                                    ? Center(
                                        child: Container(
                                          width: 9.w,
                                          height: 9.w,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.bordercolor,
                                          ),
                                        ),
                                      )
                                    : null,
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                role,
                                style: AppTextStyle(context).mediumTextStyle(
                                  fontSize: AppTextStyle.md,
                                  color: isSelected
                                      ? AppColors.white
                                      : AppColors.onboardingtext,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 14.h),
                ],

                // ── Step Tabs (Basic Info | Business Info | Payment) ──────
                if (controller.selectedRole != 'User') ...[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      children: List.generate(_steps.length, (i) {
                        final isActive = controller.profileSetupStep == i;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () => controller.setProfileSetupStep(i),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 6.h),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        _steps[i]['icon'] as String,
                                        width: 18.w,
                                        height: 18.w,
                                        fit: BoxFit.contain,
                                        color: isActive
                                            ? AppColors.multicolor
                                            : AppColors.onboardingtext,
                                      ),
                                      SizedBox(width: 5.w),
                                      Text(
                                        _steps[i]['label'] as String,
                                        style: AppTextStyle(context).mediumTextStyle(
                                          fontSize: 12,
                                          color: isActive
                                              ? AppColors.multicolor
                                              : AppColors.onboardingtext,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 2.5,
                                  decoration: BoxDecoration(
                                    color: isActive
                                        ? AppColors.bordercolor
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // ── Sub-tabs for Step 0 (Personal Info | Verification) ────
                  if (controller.profileSetupStep == 0) ...[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        children: [
                          _buildSubTab(context, controller, 'Personal Info', 0),
                          SizedBox(width: 8.w),
                          _buildSubTab(context, controller, 'Verificaiton', 1),
                        ],
                      ),
                    ),
                    SizedBox(height: 14.h),
                  ],
                ],

                // ── Scrollable Form Body ──────────────────────────────────
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    physics: const BouncingScrollPhysics(),
                    child: _buildCurrentStepContent(context, controller),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // ── Current Content Router ────────────────────────────────────────────────
  Widget _buildCurrentStepContent(BuildContext context, AuthController controller) {
    if (controller.selectedRole == 'User') {
      return _buildPersonalInfoView(context, controller);
    }
    if (controller.profileSetupStep == 0) {
      if (controller.profileSetupSubTab == 0) {
        return _buildPersonalInfoView(context, controller);
      } else {
        return _buildVerificationView(context, controller);
      }
    } else if (controller.profileSetupStep == 1) {
      return _buildBusinessInfoView(context, controller);
    } else {
      return _buildPaymentView(context, controller);
    }
  }

  // ── Sub-tab Pill ─────────────────────────────────────────────────────────
  Widget _buildSubTab(
    BuildContext context,
    AuthController controller,
    String label,
    int index,
  ) {
    final isSelected = controller.profileSetupSubTab == index;
    return GestureDetector(
      onTap: () => controller.setProfileSetupSubTab(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.purple : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppColors.purple : AppColors.cardBorder,
          ),
        ),
        child: Text(
          label,
          style: AppTextStyle(context).mediumTextStyle(
            fontSize: AppTextStyle.md,
            color: isSelected ? AppColors.white : AppColors.onboardingtext,
          ),
        ),
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // 1. PERSONAL INFO VIEW
  // ══════════════════════════════════════════════════════════════════════════
  Widget _buildPersonalInfoView(BuildContext context, AuthController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildYellowHeader(context, 'Personal Info'),
        SizedBox(height: 12.h),
        ProTextField(
          controller: controller.signupNameController,
          labelText: 'Full Name',
          hintText: 'Enter Full Name',
        ),
        SizedBox(height: 10.h),
        ProTextField(
          controller: controller.signupEmailController,
          labelText: 'Email Address',
          hintText: 'Enter Email Address',
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 10.h),
        ProTextField(
          controller: controller.signupPhoneController,
          labelText: 'Phone Number',
          hintText: 'Enter Phone Number',
          keyboardType: TextInputType.phone,
        ),
        SizedBox(height: 20.h),

        _buildYellowHeader(context, 'Address'),
        SizedBox(height: 12.h),
        ProTextField(
          controller: controller.signupCountryController,
          labelText: 'Country',
          hintText: 'Select Your Country',
          readOnly: true,
          suffixIcon: const Icon(
            Icons.arrow_drop_down,
            color: AppColors.secondary,
            size: 28,
          ),
          onTap: () => _showCountryPicker(context, controller),
        ),
        SizedBox(height: 10.h),
        ProTextField(
          controller: controller.signupCityController,
          labelText: 'City Name',
          hintText: controller.signupCountryController.text.isEmpty
              ? 'Select Country First'
              : 'Select City',
          readOnly: true,
          suffixIcon: const Icon(
            Icons.arrow_drop_down,
            color: AppColors.secondary,
            size: 28,
          ),
          onTap: () => _showCityPicker(context, controller),
        ),
        SizedBox(height: 10.h),
        ProTextField(
          controller: controller.signupStateController,
          labelText: 'State Name',
          hintText: 'Enter State Name',
        ),
        SizedBox(height: 20.h),

        _buildYellowHeader(context, 'SECURITY SETUP'),
        SizedBox(height: 12.h),
        ProTextField(
          controller: controller.signupPasswordController,
          labelText: 'Password',
          hintText: 'Enter password',
          obscureText: controller.obscureSignupPassword,
          suffixIcon: GestureDetector(
            onTap: controller.toggleSignupPasswordVisibility,
            child: Icon(
              controller.obscureSignupPassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: AppColors.bordercolor,
              size: 20,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        ProTextField(
          controller: controller.signupConfirmPasswordController,
          labelText: 'Confirm Password',
          hintText: 'Enter password',
          obscureText: controller.obscureSignupConfirmPassword,
          suffixIcon: GestureDetector(
            onTap: controller.toggleSignupConfirmPasswordVisibility,
            child: Icon(
              controller.obscureSignupConfirmPassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: AppColors.bordercolor,
              size: 20,
            ),
          ),
        ),
        SizedBox(height: 16.h),

        Row(
          children: [
            SizedBox(
              height: 20.h,
              width: 20.h,
              child: Checkbox(
                value: controller.agreeTerms,
                onChanged: controller.toggleAgreeTerms,
                side: const BorderSide(color: AppColors.onboardingtext, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                fillColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return AppColors.bordercolor;
                  }
                  return Colors.transparent;
                }),
                checkColor: AppColors.white,
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              'I agree to Terms & Conditions',
              style: AppTextStyle(context).regularTextStyle(
                fontSize: AppTextStyle.sm,
                color: AppColors.onboardingtext,
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),

        ProElevatedButton(
          text: controller.selectedRole == 'User' ? 'Create Account' : 'Next',
          isLoading: controller.isRegistering.value,
          trailingIcon: controller.selectedRole == 'User' ? null : Icons.arrow_forward_ios,
          iconSize: 14,
          height: 52,
          borderRadius: 30,
          gradient: const LinearGradient(
            colors: [AppColors.secondary, AppColors.secondary],
          ),
          onPressed: controller.onNextFromPersonalInfo,
        ),
        SizedBox(height: 28.h),
      ],
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // 2. VERIFICATION VIEW (Identity Verification)
  // ══════════════════════════════════════════════════════════════════════════
  Widget _buildVerificationView(BuildContext context, AuthController controller) {
    final docs = ['National ID', 'Passport', 'Driving License'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildYellowHeader(context, 'Identity Verification'),
        SizedBox(height: 4.h),
        Text(
          'Please upload your legal documents to verify your identity',
          style: AppTextStyle(context).regularTextStyle(
            fontSize: AppTextStyle.sm,
            color: AppColors.onboardingtext,
          ),
        ),
        SizedBox(height: 16.h),

        // Document Type Radio Buttons
        Row(
          children: docs.asMap().entries.map((e) {
            final isSelected = controller.selectedVerificationDoc == e.key;
            return Expanded(
              child: GestureDetector(
                onTap: () => controller.setVerificationDoc(e.key),
                child: Row(
                  children: [
                    Container(
                      width: 16.w,
                      height: 16.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected
                              ? AppColors.bordercolor
                              : AppColors.onboardingtext,
                          width: 2,
                        ),
                      ),
                      child: isSelected
                          ? Center(
                              child: Container(
                                width: 8.w,
                                height: 8.w,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.bordercolor,
                                ),
                              ),
                            )
                          : null,
                    ),
                    SizedBox(width: 5.w),
                    Flexible(
                      child: Text(
                        e.value,
                        style: AppTextStyle(context).mediumTextStyle(
                          fontSize: 11,
                          color: isSelected ? AppColors.white : AppColors.onboardingtext,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 16.h),

        // Document Number Field
        ProTextField(
          controller: controller.selectedVerificationDoc == 0
              ? controller.nationalIdNumberController
              : controller.selectedVerificationDoc == 1
                  ? controller.passportNumberController
                  : controller.drivingLicenseNumberController,
          labelText: controller.selectedVerificationDoc == 0
              ? 'National ID No.'
              : controller.selectedVerificationDoc == 1
                  ? 'Passport No.'
                  : 'License No.',
          hintText: controller.selectedVerificationDoc == 0
              ? 'Enter National ID No.'
              : controller.selectedVerificationDoc == 1
                  ? 'Enter Passport No.'
                  : 'Enter License No.',
        ),
        SizedBox(height: 16.h),

        // Upload Section
        Text(
          'Upload Your Document',
          style: AppTextStyle(context).mediumTextStyle(
            fontSize: AppTextStyle.md,
            color: AppColors.onboardingtext,
          ),
        ),
        SizedBox(height: 12.h),

        // Button 1: Upload File in JPG / PDF (with Dashed / Dotted Border)
        GestureDetector(
          onTap: () {
            Get.toNamed(
              AppRoute.sellerIdPhotoUploadScreen,
              arguments: {
                'docType': controller.selectedVerificationDoc,
                'isDocument': true,
              },
            );
          },
          child: CustomPaint(
            painter: DashedRectPainter(
              color: AppColors.bordercolor.withValues(alpha: 0.6),
              strokeWidth: 1.2,
              gap: 4.5,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 14.h),
              decoration: BoxDecoration(
                color: AppColors.textfieldcolor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    IconPath.uploadTray,
                    width: 22.w,
                    height: 22.w,
                    fit: BoxFit.contain,
                    color: AppColors.white,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'Upload your file in JPG / PDF',
                    style: AppTextStyle(context).mediumTextStyle(
                      fontSize: AppTextStyle.md,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 10.h),

        Center(
          child: Text(
            'or,',
            style: AppTextStyle(context).mediumTextStyle(
              fontSize: 13,
              color: AppColors.multicolor,
            ),
          ),
        ),
        SizedBox(height: 10.h),

        // Button 2: Take photo of the document (with Dashed / Dotted Border)
        GestureDetector(
          onTap: () {
            Get.toNamed(
              AppRoute.sellerIdPhotoUploadScreen,
              arguments: {
                'docType': controller.selectedVerificationDoc,
                'isDocument': false,
              },
            );
          },
          child: CustomPaint(
            painter: DashedRectPainter(
              color: AppColors.bordercolor.withValues(alpha: 0.6),
              strokeWidth: 1.2,
              gap: 4.5,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 14.h),
              decoration: BoxDecoration(
                color: AppColors.textfieldcolor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    IconPath.cameraPlus,
                    width: 22.w,
                    height: 22.w,
                    fit: BoxFit.contain,
                    color: AppColors.white,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'Take photo of the document',
                    style: AppTextStyle(context).mediumTextStyle(
                      fontSize: AppTextStyle.md,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 18.h),

        // ── Uploaded Images Thumbnail Row (with close icon) ─────────────────
        _buildUploadedThumbnailsRow(context, controller),
        SizedBox(height: 14.h),

        // Bottom info note
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.info_outline, color: AppColors.onboardingtext, size: 14),
            SizedBox(width: 6.w),
            Expanded(
              child: Text(
                'Please upload the front side and back side of your National ID card',
                style: AppTextStyle(context).regularTextStyle(
                  fontSize: 11,
                  color: AppColors.onboardingtext,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 24.h),

        ProElevatedButton(
          text: 'Next',
          trailingIcon: Icons.arrow_forward_ios,
          iconSize: 14,
          height: 52,
          borderRadius: 30,
          gradient: const LinearGradient(
            colors: [AppColors.secondary, AppColors.secondary],
          ),
          onPressed: controller.onNextFromVerification,
        ),
        SizedBox(height: 28.h),
      ],
    );
  }

  // ── Uploaded thumbnails row showing real user images with (x) delete button ─
  Widget _buildUploadedThumbnailsRow(BuildContext context, AuthController controller) {
    final List<Map<String, dynamic>> uploadedList = [];

    if (controller.idFrontImagePath != null && controller.idFrontImagePath!.isNotEmpty) {
      uploadedList.add({
        'path': controller.idFrontImagePath!,
        'onRemove': () {
          controller.idFrontImagePath = null;
          controller.update();
        },
      });
    }

    if (controller.idBackImagePath != null && controller.idBackImagePath!.isNotEmpty) {
      uploadedList.add({
        'path': controller.idBackImagePath!,
        'onRemove': () {
          controller.idBackImagePath = null;
          controller.update();
        },
      });
    }

    // If nothing uploaded yet, display sample thumbnails matching design
    if (uploadedList.isEmpty) {
      return Row(
        children: [
          _buildSampleThumbnailCard(
            'https://picsum.photos/300/200?random=11',
            onTap: () => controller.pickIdFrontImage(source: ImageSource.gallery),
          ),
          SizedBox(width: 14.w),
          _buildSampleThumbnailCard(
            'https://picsum.photos/300/200?random=12',
            onTap: () => controller.pickIdBackImage(source: ImageSource.gallery),
          ),
        ],
      );
    }

    return Row(
      children: uploadedList.map((item) {
        final String path = item['path'] as String;
        final VoidCallback onRemove = item['onRemove'] as VoidCallback;

        return Container(
          margin: EdgeInsets.only(right: 14.w),
          width: 80.w,
          height: 62.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.bordercolor.withValues(alpha: 0.5)),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: path.startsWith('http')
                    ? Image.network(path, width: 80.w, height: 62.h, fit: BoxFit.cover)
                    : path == 'selected'
                        ? Image.network('https://picsum.photos/300/200', width: 80.w, height: 62.h, fit: BoxFit.cover)
                        : Image.file(File(path), width: 80.w, height: 62.h, fit: BoxFit.cover),
              ),
              Positioned(
                top: 3,
                right: 3,
                child: GestureDetector(
                  onTap: onRemove,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.7),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.close, color: Colors.white, size: 12),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSampleThumbnailCard(String url, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80.w,
        height: 62.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.cardBorder),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                url,
                width: 80.w,
                height: 62.h,
                fit: BoxFit.cover,
                errorBuilder: (context, error, _) => const Icon(Icons.image, color: AppColors.onboardingtext),
              ),
            ),
            Positioned(
              top: 3,
              right: 3,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.7),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, color: Colors.white, size: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }


  // ══════════════════════════════════════════════════════════════════════════
  // 3. BUSINESS INFO VIEW
  // ══════════════════════════════════════════════════════════════════════════
  Widget _buildBusinessInfoView(BuildContext context, AuthController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ProTextField(
          controller: controller.businessStoreNameController,
          labelText: 'Business / Store Name',
          hintText: 'e.g. Afro Merch Store',
        ),
        SizedBox(height: 12.h),

        // Business Type Dropdown
        Text(
          'Business Type',
          style: AppTextStyle(context).mediumTextStyle(
            fontSize: AppTextStyle.md,
            color: AppColors.onboardingtext,
          ),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: () => _showRightSidePopup(
            context: context,
            badge: 'Development',
            title: 'Select business type',
            items: _businessTypes,
            selectedIndex: controller.selectedBusinessType,
            onSelected: (idx) => controller.setBusinessType(idx),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: AppColors.textfieldcolor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.textfieldcolor),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    controller.selectedBusinessType >= 0
                        ? _businessTypes[controller.selectedBusinessType]
                        : 'Select Type',
                    style: AppTextStyle(context).regularTextStyle(
                      fontSize: AppTextStyle.md,
                      color: controller.selectedBusinessType >= 0
                          ? AppColors.white
                          : AppColors.white.withValues(alpha: 0.5),
                    ),
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.bordercolor,
                  size: 22,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 12.h),

        ProTextField(
          controller: controller.businessRegNumberController,
          labelText: 'Reg. Number (optional)',
          hintText: 'e.g. R12399',
        ),
        SizedBox(height: 12.h),

        ProTextField(
          controller: controller.businessCityController,
          labelText: 'Business City',
          hintText: 'Enter Business City',
        ),
        SizedBox(height: 12.h),

        ProTextField(
          controller: controller.businessAddressController,
          labelText: 'Business Address',
          hintText: 'Enter Address',
        ),
        SizedBox(height: 12.h),

        ProTextField(
          controller: controller.businessWebsiteController,
          labelText: 'Website',
          hintText: 'https://your business.com',
          keyboardType: TextInputType.url,
        ),
        SizedBox(height: 12.h),

        ProTextField(
          controller: controller.businessDescriptionController,
          labelText: 'Business Description',
          hintText: 'Brief description',
        ),
        SizedBox(height: 24.h),

        ProElevatedButton(
          text: 'Next',
          trailingIcon: Icons.arrow_forward_ios,
          iconSize: 14,
          height: 52,
          borderRadius: 30,
          gradient: const LinearGradient(
            colors: [AppColors.secondary, AppColors.secondary],
          ),
          onPressed: controller.onNextFromBusinessInfo,
        ),
        SizedBox(height: 28.h),
      ],
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // 4. PAYMENT VIEW (Image 1 style)
  // ══════════════════════════════════════════════════════════════════════════
  Widget _buildPaymentView(BuildContext context, AuthController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Payment method',
          style: AppTextStyle(context).boldTextStyle(
            fontSize: AppTextStyle.title,
            color: AppColors.white,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          'Add your payment information to receive earnings from your successful product sales.',
          style: AppTextStyle(context).regularTextStyle(
            fontSize: AppTextStyle.sm,
            color: AppColors.onboardingtext,
          ),
        ),
        SizedBox(height: 20.h),

        Text(
          'Payment Method',
          style: AppTextStyle(context).mediumTextStyle(
            fontSize: AppTextStyle.md,
            color: AppColors.onboardingtext,
          ),
        ),
        SizedBox(height: 8.h),

        // Payment Method Dropdown
        GestureDetector(
          onTap: () => _showRightSidePopup(
            context: context,
            badge: 'Development',
            title: 'Payment Method',
            items: _paymentMethods,
            selectedIndex: controller.selectedPaymentMethod,
            onSelected: (idx) => controller.setPaymentMethod(idx),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: AppColors.textfieldcolor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.textfieldcolor),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    controller.selectedPaymentMethod >= 0
                        ? _paymentMethods[controller.selectedPaymentMethod]
                        : 'Select payment method',
                    style: AppTextStyle(context).regularTextStyle(
                      fontSize: AppTextStyle.md,
                      color: controller.selectedPaymentMethod >= 0
                          ? AppColors.white
                          : AppColors.white.withValues(alpha: 0.5),
                    ),
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.bordercolor,
                  size: 22,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 14.h),

        // Account Holder Name Field
        ProTextField(
          controller: controller.accountHolderNameController,
          labelText: 'Account Holder Name',
          hintText: 'Enter Full Name',
        ),
        SizedBox(height: 14.h),

        // Mobile Money Number Field
        ProTextField(
          controller: controller.mobileMoneyNumberController,
          labelText: 'Mobile Money Number',
          hintText: 'Enter Number',
          keyboardType: TextInputType.phone,
        ),
        SizedBox(height: 32.h),

        ProElevatedButton(
          text: 'Create Account',
          trailingIcon: Icons.arrow_forward_ios,
          iconSize: 14,
          height: 52,
          borderRadius: 30,
          gradient: const LinearGradient(
            colors: [AppColors.secondary, AppColors.secondary],
          ),
          onPressed: controller.onCompleteSellerSignup,
        ),
        SizedBox(height: 28.h),
      ],
    );
  }

  // ── Right-side Animated Popup Dialog matching Mockup ─────────────────────
  void _showRightSidePopup({
    required BuildContext context,
    required String badge,
    required String title,
    required List<String> items,
    required int selectedIndex,
    required Function(int) onSelected,
  }) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: Colors.black.withValues(alpha: 0.6),
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (ctx, anim1, anim2) {
        return Align(
          alignment: Alignment.centerRight,
          child: Material(
            color: Colors.transparent,
            child: Container(
              margin: EdgeInsets.only(right: 16.w, left: 60.w),
              padding: EdgeInsets.all(18.w),
              decoration: BoxDecoration(
                color: const Color(0xFF1E2228),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.cardBorder.withValues(alpha: 0.8)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.5),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Development Badge
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF22C55E),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'Development',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),

                  // Title
                  Text(
                    title,
                    style: AppTextStyle(context).boldTextStyle(
                      color: AppColors.white,
                      fontSize: AppTextStyle.lg,
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // Options
                  ...items.asMap().entries.map((e) {
                    final bool isSelected = selectedIndex == e.key;
                    return InkWell(
                      onTap: () {
                        onSelected(e.key);
                        Navigator.pop(ctx);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Row(
                          children: [
                            Container(
                              width: 8.w,
                              height: 8.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSelected ? AppColors.white : AppColors.onboardingtext,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Text(
                                e.value,
                                style: AppTextStyle(context).mediumTextStyle(
                                  fontSize: AppTextStyle.md,
                                  color: isSelected ? AppColors.white : AppColors.onboardingtext,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (ctx, anim1, anim2, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: anim1, curve: Curves.easeOutCubic)),
          child: child,
        );
      },
    );
  }

  void _showCountryPicker(BuildContext context, AuthController controller) {
    final searchController = TextEditingController();
    final allCountries = AuthController.countryCityMap.keys.toList();
    final filteredCountries = RxList<String>(allCountries);

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.primary,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        side: BorderSide(color: AppColors.cardBorder),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.65,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      width: 40.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: AppColors.onboardingtext.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Select Country',
                        style: AppTextStyle(context).boldTextStyle(
                          fontSize: AppTextStyle.lg,
                          color: AppColors.white,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: AppColors.white, size: 20),
                        onPressed: () => Navigator.pop(ctx),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  TextField(
                    controller: searchController,
                    onChanged: (val) {
                      filteredCountries.assignAll(
                        allCountries.where(
                          (c) => c.toLowerCase().contains(val.toLowerCase()),
                        ),
                      );
                    },
                    style: AppTextStyle(context).regularTextStyle(
                      fontSize: AppTextStyle.md,
                      color: AppColors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search country...',
                      hintStyle: AppTextStyle(context).regularTextStyle(
                        fontSize: AppTextStyle.md,
                        color: AppColors.onboardingtext,
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppColors.onboardingtext,
                      ),
                      filled: true,
                      fillColor: AppColors.textfieldcolor,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 14.h),
                  Expanded(
                    child: Obx(
                      () => ListView.separated(
                        itemCount: filteredCountries.length,
                        separatorBuilder: (_, _) => const Divider(
                          color: AppColors.cardBorder,
                          height: 1,
                        ),
                        itemBuilder: (context, index) {
                          final country = filteredCountries[index];
                          final isSelected =
                              controller.signupCountryController.text == country;

                          return ListTile(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 2.h,
                            ),
                            title: Text(
                              country,
                              style: AppTextStyle(context).mediumTextStyle(
                                fontSize: AppTextStyle.md,
                                color: isSelected
                                    ? AppColors.secondary
                                    : AppColors.white,
                              ),
                            ),
                            trailing: isSelected
                                ? const Icon(
                                    Icons.check_circle,
                                    color: AppColors.secondary,
                                    size: 20,
                                  )
                                : null,
                            onTap: () {
                              controller.selectCountry(country);
                              Navigator.pop(ctx);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showCityPicker(BuildContext context, AuthController controller) {
    if (controller.signupCountryController.text.isEmpty) {
      Get.snackbar(
        'Country Required',
        'Please select a country first to view cities',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.withValues(alpha: 0.8),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
      );
      return;
    }

    final searchController = TextEditingController();
    final allCities = controller.availableCities;
    final filteredCities = RxList<String>(allCities);

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.primary,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        side: BorderSide(color: AppColors.cardBorder),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.65,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      width: 40.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: AppColors.onboardingtext.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Select City (${controller.signupCountryController.text})',
                        style: AppTextStyle(context).boldTextStyle(
                          fontSize: AppTextStyle.lg,
                          color: AppColors.white,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: AppColors.white, size: 20),
                        onPressed: () => Navigator.pop(ctx),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  if (allCities.length > 5) ...[
                    TextField(
                      controller: searchController,
                      onChanged: (val) {
                        filteredCities.assignAll(
                          allCities.where(
                            (c) => c.toLowerCase().contains(val.toLowerCase()),
                          ),
                        );
                      },
                      style: AppTextStyle(context).regularTextStyle(
                        fontSize: AppTextStyle.md,
                        color: AppColors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search city...',
                        hintStyle: AppTextStyle(context).regularTextStyle(
                          fontSize: AppTextStyle.md,
                          color: AppColors.onboardingtext,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: AppColors.onboardingtext,
                        ),
                        filled: true,
                        fillColor: AppColors.textfieldcolor,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 14.h),
                  ],
                  Expanded(
                    child: Obx(
                      () => filteredCities.isEmpty
                          ? Center(
                              child: Text(
                                'No cities found',
                                style: AppTextStyle(context).regularTextStyle(
                                  fontSize: AppTextStyle.md,
                                  color: AppColors.onboardingtext,
                                ),
                              ),
                            )
                          : ListView.separated(
                              itemCount: filteredCities.length,
                              separatorBuilder: (_, _) => const Divider(
                                color: AppColors.cardBorder,
                                height: 1,
                              ),
                              itemBuilder: (context, index) {
                                final city = filteredCities[index];
                                final isSelected =
                                    controller.signupCityController.text == city;

                                return ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 2.h,
                                  ),
                                  title: Text(
                                    city,
                                    style: AppTextStyle(context).mediumTextStyle(
                                      fontSize: AppTextStyle.md,
                                      color: isSelected
                                          ? AppColors.secondary
                                          : AppColors.white,
                                    ),
                                  ),
                                  trailing: isSelected
                                      ? const Icon(
                                          Icons.check_circle,
                                          color: AppColors.secondary,
                                          size: 20,
                                        )
                                      : null,
                                  onTap: () {
                                    controller.selectCity(city);
                                    Navigator.pop(ctx);
                                  },
                                );
                              },
                            ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildYellowHeader(BuildContext context, String title) {
    return Text(
      title,
      style: AppTextStyle(context).boldTextStyle(
        fontSize: AppTextStyle.md,
        color: AppColors.multicolor,
      ),
    );
  }
}

// ── Dashed Rect Painter for Exact Dotted/Dashed Boxes ────────────────────────
class DashedRectPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;

  DashedRectPainter({
    required this.color,
    this.strokeWidth = 1.0,
    this.gap = 4.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final Path path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(12),
      ));

    final Path dashedPath = Path();
    double distance = 0.0;
    for (final metric in path.computeMetrics()) {
      while (distance < metric.length) {
        final double length = gap;
        if (distance + length > metric.length) break;
        dashedPath.addPath(
          metric.extractPath(distance, distance + length),
          Offset.zero,
        );
        distance += length + gap;
      }
    }

    canvas.drawPath(dashedPath, paint);
  }

  @override
  bool shouldRepaint(covariant DashedRectPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.gap != gap;
  }
}

