import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riddimafrica/core/core.dart';
import '../controllers/submit_product_controller.dart';

class SubmitStep2Photos extends GetView<SubmitProductController> {
  const SubmitStep2Photos({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main Photo Label
          _buildLabel(context, 'MAIN PHOTO *'),
          const SizedBox(height: 10),

          // Main Photo Container
          Obx(
            () => GestureDetector(
              onTap: () => _showImageSourcePicker(
                context,
                onSelected: (source) => controller.pickMainPhoto(source: source),
              ),
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.white.withValues(alpha: 0.1),
                  ),
                ),
                child: controller.mainPhotoUrl.value.isNotEmpty
                    ? Stack(
                        fit: StackFit.expand,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: _buildImageWidget(controller.mainPhotoUrl.value),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: Colors.black54,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      )
                    : _buildUploadPrompt(context),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Additional Photos Header
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildLabel(context, 'ADDITIONAL PHOTOS'),
                Text(
                  '${controller.additionalPhotos.length}/4 added',
                  style: AppTextStyle(context).regularTextStyle(
                    color: AppColors.primarytext,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Additional Photos Grid (4 slots)
          Obx(
            () => Row(
              children: List.generate(4, (index) {
                final hasImage = index < controller.additionalPhotos.length;

                return Expanded(
                  child: Container(
                    height: 72,
                    margin: EdgeInsets.only(right: index < 3 ? 10 : 0),
                    child: hasImage
                        ? Stack(
                            fit: StackFit.expand,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: _buildImageWidget(controller.additionalPhotos[index]),
                              ),
                              Positioned(
                                top: 4,
                                right: 4,
                                child: GestureDetector(
                                  onTap: () => controller.removeAdditionalPhoto(index),
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: const BoxDecoration(
                                      color: Colors.black87,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : GestureDetector(
                            onTap: () => _showImageSourcePicker(
                              context,
                              onSelected: (source) =>
                                  controller.pickAdditionalPhoto(source: source),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.white.withValues(alpha: 0.03),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: AppColors.white.withValues(alpha: 0.08),
                                ),
                              ),
                              child: const Icon(
                                Icons.add_circle_outline,
                                color: AppColors.primarytext,
                                size: 24,
                              ),
                            ),
                          ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 40),

          // Navigation buttons (Back and Next)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                onPressed: () => controller.previousStep(),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.white.withValues(alpha: 0.2)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: Text(
                  'Back',
                  style: AppTextStyle(context).mediumTextStyle(
                    color: AppColors.white,
                    fontSize: 14,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => controller.nextStep(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6F2C57),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Next',
                      style: AppTextStyle(context).boldTextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(Icons.arrow_forward, size: 16, color: Colors.white),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildImageWidget(String path) {
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return Image.network(
        path,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          color: AppColors.white.withValues(alpha: 0.05),
          child: const Icon(Icons.image, color: Colors.grey),
        ),
      );
    } else {
      final file = File(path);
      if (file.existsSync()) {
        return Image.file(
          file,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            color: AppColors.white.withValues(alpha: 0.05),
            child: const Icon(Icons.image, color: Colors.grey),
          ),
        );
      } else {
        return Image.network(
          path,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            color: AppColors.white.withValues(alpha: 0.05),
            child: const Icon(Icons.image, color: Colors.grey),
          ),
        );
      }
    }
  }

  void _showImageSourcePicker(
    BuildContext context, {
    required Function(ImageSource) onSelected,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2C1A0D),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Select Photo Source',
                  style: AppTextStyle(context).boldTextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.camera_alt_outlined, color: AppColors.secondary),
                  ),
                  title: Text(
                    'Take a Photo',
                    style: AppTextStyle(context).mediumTextStyle(
                      color: AppColors.white,
                      fontSize: 14,
                    ),
                  ),
                  onTap: () {
                    Get.back();
                    onSelected(ImageSource.camera);
                  },
                ),
                const Divider(height: 1, color: Color(0x1AFFFFFF)),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00B4D8).withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.photo_library_outlined, color: Color(0xFF00B4D8)),
                  ),
                  title: Text(
                    'Choose from Gallery',
                    style: AppTextStyle(context).mediumTextStyle(
                      color: AppColors.white,
                      fontSize: 14,
                    ),
                  ),
                  onTap: () {
                    Get.back();
                    onSelected(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildUploadPrompt(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.cloud_upload_outlined,
          color: AppColors.primarytext,
          size: 40,
        ),
        const SizedBox(height: 8),
        Text(
          'Tap to upload main photo',
          style: AppTextStyle(context).mediumTextStyle(
            color: AppColors.white,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'PNG, JPG up to 10MB',
          style: AppTextStyle(context).regularTextStyle(
            color: AppColors.primarytext.withValues(alpha: 0.6),
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(BuildContext context, String text) {
    return Text(
      text,
      style: AppTextStyle(context).boldTextStyle(
        color: AppColors.primarytext,
        fontSize: 11,
        letterSpacing: 0.8,
      ),
    );
  }
}
