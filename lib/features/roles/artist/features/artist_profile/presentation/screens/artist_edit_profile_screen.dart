import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import '../controllers/artist_profile_controller.dart';
import '../widgets/verified_badge_pill.dart';

class ArtistEditProfileScreen extends StatefulWidget {
  const ArtistEditProfileScreen({super.key});

  @override
  State<ArtistEditProfileScreen> createState() => _ArtistEditProfileScreenState();
}

class _ArtistEditProfileScreenState extends State<ArtistEditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final ArtistProfileController controller = Get.find<ArtistProfileController>();

  late TextEditingController fullNameCtrl;
  late TextEditingController stageNameCtrl;
  late TextEditingController emailCtrl;
  late TextEditingController phoneCtrl;
  late TextEditingController countryCtrl;
  late TextEditingController cityCtrl;
  late TextEditingController stateCtrl;

  @override
  void initState() {
    super.initState();
    final profile = controller.profile.value;
    fullNameCtrl = TextEditingController(text: profile?.fullName ?? '');
    stageNameCtrl = TextEditingController(text: profile?.stageName ?? '');
    emailCtrl = TextEditingController(text: profile?.email ?? '');
    phoneCtrl = TextEditingController(text: profile?.phoneNumber ?? '');
    countryCtrl = TextEditingController(text: profile?.country ?? '');
    cityCtrl = TextEditingController(text: profile?.cityName ?? '');
    stateCtrl = TextEditingController(text: profile?.stateName ?? '');
  }

  @override
  void dispose() {
    fullNameCtrl.dispose();
    stageNameCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
    countryCtrl.dispose();
    cityCtrl.dispose();
    stateCtrl.dispose();
    super.dispose();
  }

  void _onSaveChanges() {
    if (_formKey.currentState?.validate() ?? false) {
      controller.saveProfile(
        fullName: fullNameCtrl.text.trim(),
        stageName: stageNameCtrl.text.trim(),
        email: emailCtrl.text.trim(),
        phone: phoneCtrl.text.trim(),
        country: countryCtrl.text.trim(),
        city: cityCtrl.text.trim(),
        state: stateCtrl.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: const GlobalAppBar(
        title: 'Edit Profile',
        showDivider: false,
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Obx(
            () => ProElevatedButton(
              text: 'Save Changes',
              onPressed: _onSaveChanges,
              isLoading: controller.isSaving.value,
              backgroundColor: AppColors.secondary,
              borderRadius: 14,
              height: 52,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ─── Avatar & Camera ────────────────────────────────────────
                Center(
                  child: Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Obx(() {
                            final localPath = controller.localAvatarPath.value;
                            final avatarUrl = controller.profile.value?.avatarUrl ??
                                'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500';
                            return Container(
                              width: 95.w,
                              height: 95.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.cardBorder,
                                  width: 2.5,
                                ),
                                image: DecorationImage(
                                  image: localPath.isNotEmpty
                                      ? FileImage(File(localPath)) as ImageProvider
                                      : NetworkImage(avatarUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }),
                          Positioned(
                            bottom: 0,
                            right: 2,
                            child: GestureDetector(
                              onTap: controller.pickAvatarImage,
                              child: Container(
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  color: AppColors.secondary,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.primary,
                                    width: 2.5,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: AppColors.white,
                                  size: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tap to change photo',
                        style: AppTextStyle(context).regularTextStyle(
                          color: AppColors.primarytext,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const VerifiedBadgePill(),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // ─── Section 1: Personal Info ───────────────────────────────
                Text(
                  'Personal Info',
                  style: AppTextStyle(context).boldTextStyle(
                    color: const Color(0xFFE6B650),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),

                _buildInputField(
                  context,
                  label: 'Full Name',
                  hintText: 'Enter Full Name',
                  controller: fullNameCtrl,
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'Please enter full name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),

                _buildInputField(
                  context,
                  label: 'Stage Name',
                  hintText: 'Enter Stage Name',
                  controller: stageNameCtrl,
                ),
                const SizedBox(height: 14),

                _buildInputField(
                  context,
                  label: 'Email Address',
                  hintText: 'Enter Email Address',
                  controller: emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'Please enter email address';
                    }
                    if (!GetUtils.isEmail(val.trim())) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),

                _buildInputField(
                  context,
                  label: 'Phone Number',
                  hintText: 'Enter Phone Number',
                  controller: phoneCtrl,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 24),

                // ─── Section 2: Address ─────────────────────────────────────
                Text(
                  'Address',
                  style: AppTextStyle(context).boldTextStyle(
                    color: const Color(0xFFE6B650),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),

                _buildInputField(
                  context,
                  label: 'Country',
                  hintText: 'Enter Your Country Name',
                  controller: countryCtrl,
                ),
                const SizedBox(height: 14),

                _buildInputField(
                  context,
                  label: 'City Name',
                  hintText: 'Enter Your City',
                  controller: cityCtrl,
                ),
                const SizedBox(height: 14),

                _buildInputField(
                  context,
                  label: 'State Name',
                  hintText: 'Enter State Name',
                  controller: stateCtrl,
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
    BuildContext context, {
    required String label,
    required String hintText,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle(context).mediumTextStyle(
            fontSize: 14,
            color: AppColors.primarytext,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          style: AppTextStyle(context).regularTextStyle(
            fontSize: 14,
            color: AppColors.white,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTextStyle(context).regularTextStyle(
              fontSize: 14,
              color: const Color(0xFF6B7D8E),
            ),
            filled: true,
            fillColor: AppColors.textfieldcolor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.bordercolor, width: 1.2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          ),
        ),
      ],
    );
  }
}
