import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:riddimafrica/core/core.dart';
import 'package:riddimafrica/features/bottom_nav/presentation/controllers/artist_bottom_nav_controller.dart';
import 'package:riddimafrica/features/bottom_nav/domain/entities/nav_model.dart';
import '../../controllers/artist_edit_profile_controller.dart';

class ArtistEditProfileScreen extends StatelessWidget {
  const ArtistEditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<ArtistEditProfileController>()
        ? Get.find<ArtistEditProfileController>()
        : Get.put(ArtistEditProfileController());

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leadingWidth: 56.w,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF271B16),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ),
        title: Text(
          'Edit Profile',
          style: AppTextStyle(context).boldTextStyle(
            fontSize: 18.sp,
            color: Colors.white,
          ),
        ),
        centerTitle: false,
      ),
      bottomNavigationBar: _buildBottomBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar Change Section
              Center(
                child: GestureDetector(
                  onTap: () => controller.showImagePickerOptions(context),
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Obx(
                            () => Container(
                              width: 86.w,
                              height: 86.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.onboardingbutton
                                      .withValues(alpha: 0.5),
                                  width: 2.w,
                                ),
                              ),
                              child: ClipOval(
                                child: controller.selectedImageFile.value != null
                                    ? Image.file(
                                        controller.selectedImageFile.value!,
                                        fit: BoxFit.cover,
                                      )
                                    : controller.avatarUrl.value
                                            .startsWith('http')
                                        ? CachedNetworkImage(
                                            imageUrl:
                                                controller.avatarUrl.value,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                Container(
                                              color: AppColors
                                                  .primaryappbrownsecond,
                                              child: const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  color: AppColors
                                                      .onboardingbutton,
                                                ),
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Container(
                                              color: AppColors
                                                  .primaryappbrownsecond,
                                              child: const Icon(
                                                Icons.person,
                                                color: AppColors.primarytext,
                                                size: 40,
                                              ),
                                            ),
                                          )
                                        : Image.file(
                                            File(controller.avatarUrl.value),
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error,
                                                    stackTrace) =>
                                                Container(
                                              color: AppColors
                                                  .primaryappbrownsecond,
                                              child: const Icon(
                                                Icons.person,
                                                color: AppColors.primarytext,
                                                size: 40,
                                              ),
                                            ),
                                          ),
                              ),
                            ),
                          ),
                          // Camera overlay badge
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 26.w,
                              height: 26.w,
                              decoration: BoxDecoration(
                                color: const Color(0xFFBA473C),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.primary,
                                  width: 2.w,
                                ),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 13.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      8.verticalSpace,
                      Text(
                        'Tap to change photo',
                        style: AppTextStyle(context).regularTextStyle(
                          fontSize: 12.sp,
                          color: AppColors.primarytext,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              20.verticalSpace,

              // Underline-style Tab Switcher (Basic Info vs Business Info)
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildUnderlineTabItem(
                      context: context,
                      title: 'Basic Info',
                      iconPath: IconPath.basicInfo,
                      fallbackIcon: Icons.shield_outlined,
                      isSelected: controller.selectedTab.value == 0,
                      onTap: () => controller.setTab(0),
                    ),
                    32.horizontalSpace,
                    _buildUnderlineTabItem(
                      context: context,
                      title: 'Business Info',
                      iconPath: IconPath.businessInfo,
                      fallbackIcon: Icons.business_center_outlined,
                      isSelected: controller.selectedTab.value == 1,
                      onTap: () => controller.setTab(1),
                    ),
                  ],
                ),
              ),
              22.verticalSpace,

              // Dynamic Tab Body
              Obx(
                () => controller.selectedTab.value == 0
                    ? _buildBasicInfoTab(context, controller)
                    : _buildBusinessInfoTab(context, controller),
              ),
              24.verticalSpace,

              // Save Changes Button
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: controller.isSaving.value
                        ? null
                        : () => controller.saveChanges(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFBA473C),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      elevation: 0,
                    ),
                    child: controller.isSaving.value
                        ? SizedBox(
                            width: 20.w,
                            height: 20.w,
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'Save Changes',
                            style: AppTextStyle(context).boldTextStyle(
                              fontSize: 15.sp,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ),
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUnderlineTabItem({
    required BuildContext context,
    required String title,
    required String iconPath,
    required IconData fallbackIcon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final activeColor = const Color(0xFFE5A83B);
    final inactiveColor = const Color(0xFF8E8E93);
    final indicatorColor = const Color(0xFF35C0AD);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                iconPath,
                width: 16.w,
                height: 16.w,
                color: isSelected ? activeColor : inactiveColor,
                errorBuilder: (context, error, stackTrace) => Icon(
                  fallbackIcon,
                  size: 16.sp,
                  color: isSelected ? activeColor : inactiveColor,
                ),
              ),
              8.horizontalSpace,
              Text(
                title,
                style: AppTextStyle(context).boldTextStyle(
                  fontSize: 13.sp,
                  color: isSelected ? activeColor : inactiveColor,
                ),
              ),
            ],
          ),
          6.verticalSpace,
          // Underline indicator
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 2.5.h,
            width: title == 'Basic Info' ? 88.w : 100.w,
            decoration: BoxDecoration(
              color: isSelected ? indicatorColor : Colors.transparent,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInfoTab(
      BuildContext context, ArtistEditProfileController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Personal Info Section Header
        Text(
          'Personal Info',
          style: AppTextStyle(context).boldTextStyle(
            fontSize: 15.sp,
            color: const Color(0xFFE5A83B),
          ),
        ),
        14.verticalSpace,

        _buildInputField(
          context: context,
          label: 'Full Name',
          hint: 'Enter Full Name',
          controller: controller.fullNameController,
        ),
        14.verticalSpace,

        _buildInputField(
          context: context,
          label: 'Email Address',
          hint: 'Enter Email Address',
          controller: controller.emailController,
          keyboardType: TextInputType.emailAddress,
        ),
        14.verticalSpace,

        _buildInputField(
          context: context,
          label: 'Phone Number',
          hint: 'Enter Phone Number',
          controller: controller.phoneController,
          keyboardType: TextInputType.phone,
        ),
        20.verticalSpace,

        // Address Section Header
        Text(
          'Address',
          style: AppTextStyle(context).boldTextStyle(
            fontSize: 15.sp,
            color: const Color(0xFFE5A83B),
          ),
        ),
        14.verticalSpace,

        _buildInputField(
          context: context,
          label: 'Country',
          hint: 'Enter Your Country Name',
          controller: controller.countryController,
        ),
        14.verticalSpace,

        _buildInputField(
          context: context,
          label: 'City Name',
          hint: 'Enter City',
          controller: controller.cityController,
        ),
        14.verticalSpace,

        _buildInputField(
          context: context,
          label: 'State Name',
          hint: 'Enter State Name',
          controller: controller.stateController,
        ),
      ],
    );
  }

  Widget _buildBusinessInfoTab(
      BuildContext context, ArtistEditProfileController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInputField(
          context: context,
          label: 'Business / Store Name',
          hint: 'Afro Merch Store',
          controller: controller.storeNameController,
        ),
        14.verticalSpace,

        // Business Type Dropdown
        Text(
          'Business Type',
          style: AppTextStyle(context).mediumTextStyle(
            fontSize: 12.sp,
            color: AppColors.primarytext,
          ),
        ),
        6.verticalSpace,
        Obx(
          () => Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            decoration: BoxDecoration(
              color: const Color(0xFF161E28),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: controller.selectedBusinessType.value,
                hint: Text(
                  'Select Type',
                  style: AppTextStyle(context).regularTextStyle(
                    fontSize: 13.sp,
                    color: const Color(0xFF6C7C8E),
                  ),
                ),
                isExpanded: true,
                dropdownColor: const Color(0xFF161E28),
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: const Color(0xFF35C0AD),
                  size: 20.sp,
                ),
                items: controller.businessTypes
                    .map(
                      (type) => DropdownMenuItem(
                        value: type,
                        child: Text(
                          type,
                          style: AppTextStyle(context).regularTextStyle(
                            fontSize: 13.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (val) {
                  if (val != null) controller.setBusinessType(val);
                },
              ),
            ),
          ),
        ),
        14.verticalSpace,

        _buildInputField(
          context: context,
          label: 'Reg. Number (optional)',
          hint: 'e.g. R12399',
          controller: controller.regNumberController,
        ),
        14.verticalSpace,

        _buildInputField(
          context: context,
          label: 'Your City',
          hint: 'Enter City',
          controller: controller.businessCityController,
        ),
        14.verticalSpace,

        _buildInputField(
          context: context,
          label: 'Business Address',
          hint: 'Enter Address',
          controller: controller.businessAddressController,
        ),
        14.verticalSpace,

        _buildInputField(
          context: context,
          label: 'Website',
          hint: 'https://yourbusiness.com',
          controller: controller.websiteController,
          keyboardType: TextInputType.url,
        ),
        14.verticalSpace,

        _buildInputField(
          context: context,
          label: 'Business Description',
          hint: 'Brief description',
          controller: controller.businessDescriptionController,
          maxLines: 4,
        ),
      ],
    );
  }

  Widget _buildInputField({
    required BuildContext context,
    required String label,
    required String hint,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle(context).mediumTextStyle(
            fontSize: 12.sp,
            color: AppColors.primarytext,
          ),
        ),
        6.verticalSpace,
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF161E28),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            maxLines: maxLines,
            style: AppTextStyle(context).regularTextStyle(
              fontSize: 13.sp,
              color: Colors.white,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: AppTextStyle(context).regularTextStyle(
                fontSize: 13.sp,
                color: const Color(0xFF6C7C8E),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 14.w,
                vertical: maxLines > 1 ? 12.h : 13.h,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(
                  color: Color(0xFF35C0AD),
                  width: 1.5,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(
                  color: Colors.redAccent,
                  width: 1,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(
                  color: Colors.redAccent,
                  width: 1.5,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    final bottomNavController = Get.isRegistered<ArtistBottomNavController>()
        ? Get.find<ArtistBottomNavController>()
        : null;

    final artistitems = const [
      NavItem(title: 'Home', iconPath: IconPath.home),
      NavItem(title: 'Products', iconPath: IconPath.box),
      NavItem(title: 'Orders', iconPath: IconPath.cart),
      NavItem(title: 'Revenue', iconPath: IconPath.revenue),
      NavItem(title: 'Profile', iconPath: IconPath.profile),
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 24,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(
              artistitems.length,
              (index) {
                final item = artistitems[index];
                final isSelected = index == 4; // Profile active
                final selectedColor = AppColors.white;
                final unselectedColor = AppColors.primarytext;

                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (index != 4 && bottomNavController != null) {
                        Get.back();
                        bottomNavController.changeIndex(index);
                      }
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      padding: const EdgeInsets.only(top: 8, bottom: 4),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            item.iconPath,
                            width: 22,
                            height: 22,
                            colorFilter: ColorFilter.mode(
                              isSelected ? selectedColor : unselectedColor,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            item.title,
                            style: AppTextStyle(context).mediumTextStyle(
                              fontSize: 11.sp,
                              color:
                                  isSelected ? selectedColor : unselectedColor,
                            ),
                          ),
                          const SizedBox(height: 5),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            height: 2.5,
                            width: isSelected ? 20 : 0,
                            decoration: BoxDecoration(
                              color: selectedColor,
                              borderRadius: BorderRadius.circular(1.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
