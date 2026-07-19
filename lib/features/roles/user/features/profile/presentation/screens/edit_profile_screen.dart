import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import '../controllers/profile_controller.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final ProfileController controller = Get.find<ProfileController>();

  late TextEditingController nameCtrl;
  late TextEditingController usernameCtrl;
  late TextEditingController emailCtrl;
  late TextEditingController phoneCtrl;
  late TextEditingController cityCtrl;
  late TextEditingController countryCtrl;

  @override
  void initState() {
    super.initState();
    nameCtrl = TextEditingController(text: controller.name.value);
    usernameCtrl = TextEditingController(text: controller.username.value);
    emailCtrl = TextEditingController(text: controller.email.value);
    phoneCtrl = TextEditingController(text: controller.phoneNumber.value);
    cityCtrl = TextEditingController(text: controller.city.value);
    countryCtrl = TextEditingController(text: controller.country.value);
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    usernameCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
    cityCtrl.dispose();
    countryCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: GlobalAppBar(
        title: 'Edit Profile',
        actions: [
          // Glowing Save pill button
          Padding(
            padding: const EdgeInsets.only(right: 16, top: 10, bottom: 10),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.secondary.withValues(alpha: 0.4),
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: InkWell(
                onTap: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    controller.saveProfile(
                      newName: nameCtrl.text.trim(),
                      newUsername: usernameCtrl.text.trim(),
                      newEmail: emailCtrl.text.trim(),
                      newPhone: phoneCtrl.text.trim(),
                      newCity: cityCtrl.text.trim(),
                      newCountry: countryCtrl.text.trim(),
                    );
                  }
                },
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Center(
                    child: Text(
                      'Save',
                      style: AppTextStyle(context).boldTextStyle(
                        color: AppColors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ─── Profile Photo ─────────────────────────────────────────
                Center(
                  child: Stack(
                    children: [
                      Obx(() {
                        final imagePath = controller.profileImagePath.value;
                        return Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.primaryappbrownsecond,
                              width: 3,
                            ),
                            image: DecorationImage(
                              image: imagePath.isNotEmpty
                                  ? FileImage(File(imagePath)) as ImageProvider
                                  : const NetworkImage(
                                      'https://images.unsplash.com/photo-1531123897727-8f129e1688ce?w=500',
                                    ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }),
                      Positioned(
                        bottom: 0,
                        right: 4,
                        child: GestureDetector(
                          onTap: controller.pickProfileImage,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: AppColors.secondary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: AppColors.white,
                              size: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(8),
                Center(
                  child: Text(
                    'Tap to change photo',
                    style: AppTextStyle(context).mediumTextStyle(
                      color: AppColors.primarytext,
                      fontSize: 12,
                    ),
                  ),
                ),
                const Gap(24),

                // ─── Personal Information Section ───────────────────────────
                Text(
                  'Personal Information',
                  style: AppTextStyle(context).boldTextStyle(
                    color: AppColors.onboardingbutton,
                    fontSize: 16,
                  ),
                ),
                const Gap(16),

                ProTextField(
                  labelText: 'Full Name',
                  hintText: 'Enter your full name',
                  controller: nameCtrl,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const Gap(16),

                ProTextField(
                  labelText: 'User Name',
                  hintText: 'Enter your user name',
                  controller: usernameCtrl,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
                const Gap(16),

                ProTextField(
                  labelText: 'Email',
                  hintText: 'Enter your email address',
                  controller: emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!GetUtils.isEmail(value.trim())) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const Gap(16),

                ProTextField(
                  labelText: 'Phone Number',
                  hintText: 'Enter your phone number',
                  controller: phoneCtrl,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                const Gap(24),

                // ─── Location Section ───────────────────────────────────────
                Text(
                  'LOCATION',
                  style: AppTextStyle(context).boldTextStyle(
                    color: AppColors.onboardingbutton,
                    fontSize: 13,
                  ),
                ),
                const Gap(16),

                ProTextField(
                  labelText: 'City',
                  hintText: 'Enter your city',
                  controller: cityCtrl,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your city';
                    }
                    return null;
                  },
                ),
                const Gap(16),

                ProTextField(
                  labelText: 'Country',
                  hintText: 'Enter your country',
                  controller: countryCtrl,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your country';
                    }
                    return null;
                  },
                ),
                const Gap(24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
