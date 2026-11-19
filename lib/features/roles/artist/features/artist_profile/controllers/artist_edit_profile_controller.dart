import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riddimafrica/core/core.dart';
import '../data/models/artist_profile_model.dart';
import 'artist_profile_controller.dart';

class ArtistEditProfileController extends GetxController {
  // Tab index: 0 = Basic Info, 1 = Business Info
  final RxInt selectedTab = 0.obs;

  // Basic Info Form Controllers
  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController countryController;
  late TextEditingController cityController;
  late TextEditingController stateController;

  // Business Info Form Controllers
  late TextEditingController storeNameController;
  late TextEditingController regNumberController;
  late TextEditingController businessCityController;
  late TextEditingController businessAddressController;
  late TextEditingController websiteController;
  late TextEditingController businessDescriptionController;

  final RxnString selectedBusinessType = RxnString();
  final List<String> businessTypes = [
    'Individual / Sole Proprietor',
    'Registered Business / Company',
    'Creator / Independent Artisan',
    'Wholesaler / Manufacturer',
  ];

  final RxBool isSaving = false.obs;
  final RxString avatarUrl = ''.obs;
  final Rx<File?> selectedImageFile = Rx<File?>(null);

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    final profile = Get.isRegistered<ArtistProfileController>()
        ? Get.find<ArtistProfileController>().profile.value
        : ArtistProfileModel.mockArtist;

    avatarUrl.value = profile.avatarUrl;

    // Initialize Basic Info
    fullNameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    countryController = TextEditingController();
    cityController = TextEditingController();
    stateController = TextEditingController();

    // Initialize Business Info
    storeNameController = TextEditingController(text: 'Afro Merch Store');
    regNumberController = TextEditingController();
    businessCityController = TextEditingController();
    businessAddressController = TextEditingController();
    websiteController = TextEditingController();
    businessDescriptionController = TextEditingController();
    selectedBusinessType.value = null;
  }

  void setTab(int index) {
    selectedTab.value = index;
  }

  void setBusinessType(String type) {
    selectedBusinessType.value = type;
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      if (pickedFile != null) {
        selectedImageFile.value = File(pickedFile.path);
      }
    } catch (e) {
      Get.snackbar(
        'Image Selection Failed',
        'Could not access image: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF5A1E1E),
        colorText: Colors.white,
      );
    }
  }

  void showImagePickerOptions(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: const Color(0xFF22140A),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          border: Border.all(
            color: AppColors.white.withValues(alpha: 0.1),
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              16.verticalSpace,
              Text(
                'Change Profile Photo',
                style: AppTextStyle(context).boldTextStyle(
                  fontSize: 16.sp,
                  color: Colors.white,
                ),
              ),
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildPickerOption(
                    context: context,
                    icon: Icons.camera_alt_rounded,
                    label: 'Camera',
                    onTap: () {
                      Get.back();
                      pickImage(ImageSource.camera);
                    },
                  ),
                  _buildPickerOption(
                    context: context,
                    icon: Icons.photo_library_rounded,
                    label: 'Gallery',
                    onTap: () {
                      Get.back();
                      pickImage(ImageSource.gallery);
                    },
                  ),
                  if (selectedImageFile.value != null)
                    _buildPickerOption(
                      context: context,
                      icon: Icons.delete_outline_rounded,
                      label: 'Remove',
                      iconColor: Colors.redAccent,
                      onTap: () {
                        Get.back();
                        selectedImageFile.value = null;
                      },
                    ),
                ],
              ),
              12.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPickerOption({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color? iconColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56.w,
            height: 56.w,
            decoration: BoxDecoration(
              color: const Color(0xFF161E28),
              shape: BoxShape.circle,
              border: Border.all(
                color: (iconColor ?? const Color(0xFF35C0AD))
                    .withValues(alpha: 0.3),
              ),
            ),
            child: Icon(
              icon,
              color: iconColor ?? const Color(0xFF35C0AD),
              size: 24.sp,
            ),
          ),
          8.verticalSpace,
          Text(
            label,
            style: AppTextStyle(context).mediumTextStyle(
              fontSize: 12.sp,
              color: AppColors.primarytext,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> saveChanges() async {
    isSaving.value = true;
    await Future.delayed(const Duration(milliseconds: 600));

    final updated = ArtistProfileModel(
      name: fullNameController.text.trim().isEmpty
          ? 'Elishin Nakato'
          : fullNameController.text.trim(),
      email: emailController.text.trim().isEmpty
          ? 'aisha.nakato@gmail.com'
          : emailController.text.trim(),
      phone: phoneController.text.trim().isEmpty
          ? '+256 700 123 456'
          : phoneController.text.trim(),
      country: countryController.text.trim().isEmpty
          ? 'Uganda'
          : countryController.text.trim(),
      city: cityController.text.trim().isEmpty
          ? 'Kampala'
          : cityController.text.trim(),
      state: stateController.text.trim().isEmpty
          ? 'Central Region'
          : stateController.text.trim(),
      avatarUrl: selectedImageFile.value != null
          ? selectedImageFile.value!.path
          : avatarUrl.value,
      isVerified: true,
      productsCount: '1.2 k',
      soldCount: '80',
      ratings: '4.8',
      storeName: storeNameController.text.trim(),
      businessType: selectedBusinessType.value ?? '',
      regNumber: regNumberController.text.trim(),
      businessAddress: businessAddressController.text.trim(),
      website: websiteController.text.trim(),
      businessDescription: businessDescriptionController.text.trim(),
    );

    if (Get.isRegistered<ArtistProfileController>()) {
      Get.find<ArtistProfileController>().updateProfile(updated);
    }

    isSaving.value = false;
    Get.back();
    Get.snackbar(
      'Profile Updated',
      'Your seller profile changes have been saved successfully.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1B4324),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 3),
    );
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    countryController.dispose();
    cityController.dispose();
    stateController.dispose();
    storeNameController.dispose();
    regNumberController.dispose();
    businessCityController.dispose();
    businessAddressController.dispose();
    websiteController.dispose();
    businessDescriptionController.dispose();
    super.onClose();
  }
}
