import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riddimafrica/core/core.dart';

class ArtistDocumentDetailController extends GetxController {
  final Map<String, Rx<File?>> customFiles = {};
  final ImagePicker _picker = ImagePicker();

  Rx<File?> getFileFor(String side) {
    if (!customFiles.containsKey(side)) {
      customFiles[side] = Rx<File?>(null);
    }
    return customFiles[side]!;
  }

  Future<void> pickFileFor(String side, ImageSource source) async {
    try {
      final XFile? file = await _picker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1080,
      );
      if (file != null) {
        getFileFor(side).value = File(file.path);
        Get.snackbar(
          'Photo Updated',
          '$side uploaded successfully.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF163E1C),
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          icon: const Icon(Icons.check_circle, color: Color(0xFF34C759)),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Selection Failed',
        'Could not access image: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF5A1E1E),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
      );
    }
  }

  void showPickerOptions(BuildContext context, String side) {
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
                'Upload $side',
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
                      pickFileFor(side, ImageSource.camera);
                    },
                  ),
                  _buildPickerOption(
                    context: context,
                    icon: Icons.photo_library_rounded,
                    label: 'Gallery',
                    onTap: () {
                      Get.back();
                      pickFileFor(side, ImageSource.gallery);
                    },
                  ),
                  if (getFileFor(side).value != null)
                    _buildPickerOption(
                      context: context,
                      icon: Icons.delete_outline_rounded,
                      label: 'Remove',
                      iconColor: Colors.redAccent,
                      onTap: () {
                        Get.back();
                        getFileFor(side).value = null;
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
}
