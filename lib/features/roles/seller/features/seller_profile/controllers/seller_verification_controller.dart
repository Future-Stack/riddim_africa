import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SellerVerificationController extends GetxController {
  final RxString selectedFileName = ''.obs;
  final Rx<File?> selectedFile = Rx<File?>(null);
  final RxBool isUploading = false.obs;
  final RxBool isSubmitted = false.obs;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickDocument() async {
    try {
      final XFile? file = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
      );
      if (file != null) {
        selectedFile.value = File(file.path);
        selectedFileName.value = file.name;
      }
    } catch (e) {
      selectedFileName.value = 'Business_License_2025.jpg';
    }
  }

  void clearDocument() {
    selectedFileName.value = '';
    selectedFile.value = null;
  }

  Future<void> submitVerification(Function() onSuccess) async {
    if (selectedFileName.isEmpty) {
      selectedFileName.value = 'Business_License_2025.pdf';
    }
    isUploading.value = true;
    await Future.delayed(const Duration(milliseconds: 700));
    isUploading.value = false;
    isSubmitted.value = true;
    onSuccess();
  }
}
