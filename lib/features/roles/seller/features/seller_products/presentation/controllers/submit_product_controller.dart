import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riddimafrica/routes/app_routes.dart';
import '../../data/models/product_variant_model.dart';
import '../../data/models/seller_product_model.dart';

class SellerSubmitProductController extends GetxController {
  final ImagePicker _imagePicker = ImagePicker();

  // Wizard Step: 1, 2, or 3
  final RxInt currentStep = 1.obs;

  // Step 1 Controllers
  final TextEditingController productNameController = TextEditingController(text: 'Tour Edition Cap');
  final TextEditingController shortDescriptionController = TextEditingController(
    text: 'Handwoven Ashanti Kente scarf in vibrant gold and green patterns. Made from 100% silk by skilled artisans in Kumasi, Ghana.',
  );
  final TextEditingController materialController = TextEditingController(text: '100% Silk');
  final TextEditingController originController = TextEditingController(text: 'Kumasi, Ghana');
  final TextEditingController dimensionController = TextEditingController(text: '772 Px');

  // Step 2 Photos (can hold local file paths or URLs)
  final RxString mainPhotoUrl = 'https://images.unsplash.com/photo-1579783902614-a3fb3927b675?w=600'.obs;
  final RxList<String> additionalPhotos = <String>[
    'https://images.unsplash.com/photo-1579783902614-a3fb3927b675?w=300',
  ].obs;

  // Step 3 Controllers
  final TextEditingController sellingPriceController = TextEditingController(text: '12500');
  final TextEditingController weightController = TextEditingController(text: '0.5');
  final TextEditingController stockQuantityController = TextEditingController(text: '01');
  final TextEditingController authenticityController = TextEditingController();

  // Category selection
  final List<String> categories = [
    'Cap',
    'Textiles & Fabrics',
    'Digital Products',
    'Accessories',
    'Jewelry',
    'Art & Crafts',
  ];
  final RxString selectedCategory = 'Cap'.obs;

  // Processing Time Options
  final List<String> processingTimeOptions = [
    '1-2 Business days',
    '3-5 Business days',
    '1-2 Weeks',
  ];
  final RxString selectedProcessingTime = '1-2 Business days'.obs;

  // Digital License Type
  final RxString digitalLicenseType = 'One-Time Purchase'.obs;

  // Color & Size Variant Matrix
  final RxList<ColorVariantModel> colorVariants = <ColorVariantModel>[
    const ColorVariantModel(
      colorName: 'Red',
      hexColor: '#E53935',
      sizes: [
        ProductVariantItem(size: 'XXL', quantity: 220, price: 1200),
        ProductVariantItem(size: 'XL', quantity: 370, price: 1500),
      ],
    ),
    const ColorVariantModel(
      colorName: 'Purple',
      hexColor: '#8E24AA',
      sizes: [
        ProductVariantItem(size: 'XXL', quantity: 220, price: 1200),
        ProductVariantItem(size: 'XL', quantity: 370, price: 1500),
      ],
    ),
  ].obs;

  bool get isDigitalProduct => selectedCategory.value == 'Digital Products';

  @override
  void onClose() {
    productNameController.dispose();
    shortDescriptionController.dispose();
    materialController.dispose();
    originController.dispose();
    dimensionController.dispose();
    sellingPriceController.dispose();
    weightController.dispose();
    stockQuantityController.dispose();
    authenticityController.dispose();
    super.onClose();
  }

  void setCategory(String category) {
    selectedCategory.value = category;
    if (category == 'Digital Products') {
      if (productNameController.text == 'Tour Edition Cap') {
        productNameController.text = 'Aesthetic Bird Image';
      }
      sellingPriceController.text = '6400';
    } else {
      if (productNameController.text == 'Aesthetic Bird Image') {
        productNameController.text = 'Tour Edition Cap';
      }
      sellingPriceController.text = '12500';
    }
  }

  void addColorVariant(ColorVariantModel variant) {
    colorVariants.add(variant);
  }

  void addSizeToVariant(int colorIndex, ProductVariantItem sizeItem) {
    if (colorIndex >= 0 && colorIndex < colorVariants.length) {
      final variant = colorVariants[colorIndex];
      final updatedSizes = List<ProductVariantItem>.from(variant.sizes)..add(sizeItem);
      colorVariants[colorIndex] = variant.copyWith(sizes: updatedSizes);
    }
  }

  void removeSizeFromVariant(int colorIndex, int sizeIndex) {
    if (colorIndex >= 0 && colorIndex < colorVariants.length) {
      final variant = colorVariants[colorIndex];
      if (sizeIndex >= 0 && sizeIndex < variant.sizes.length) {
        final updatedSizes = List<ProductVariantItem>.from(variant.sizes)..removeAt(sizeIndex);
        colorVariants[colorIndex] = variant.copyWith(sizes: updatedSizes);
      }
    }
  }

  Future<void> pickMainPhoto({ImageSource source = ImageSource.gallery}) async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 1440,
        maxHeight: 1440,
      );
      if (image != null) {
        mainPhotoUrl.value = image.path;
      }
    } catch (e) {
      debugPrint('Error picking main photo: $e');
    }
  }

  Future<void> pickAdditionalPhoto({ImageSource source = ImageSource.gallery}) async {
    try {
      if (additionalPhotos.length >= 4) return;

      if (source == ImageSource.gallery) {
        final List<XFile> images = await _imagePicker.pickMultiImage(
          imageQuality: 85,
          limit: 4 - additionalPhotos.length,
        );
        for (final img in images) {
          if (additionalPhotos.length < 4) {
            additionalPhotos.add(img.path);
          }
        }
      } else {
        final XFile? image = await _imagePicker.pickImage(
          source: source,
          imageQuality: 85,
        );
        if (image != null && additionalPhotos.length < 4) {
          additionalPhotos.add(image.path);
        }
      }
    } catch (e) {
      debugPrint('Error picking additional photo: $e');
    }
  }

  void removeAdditionalPhoto(int index) {
    if (index >= 0 && index < additionalPhotos.length) {
      additionalPhotos.removeAt(index);
    }
  }

  void nextStep() {
    if (currentStep.value < 3) {
      currentStep.value++;
    }
  }

  void previousStep() {
    if (currentStep.value > 1) {
      currentStep.value--;
    }
  }

  void navigateToReviewTracking() {
    final submittedProduct = SellerProductModel(
      id: 'sub-001',
      name: productNameController.text.trim().isEmpty
          ? 'Ashanti Kente Scarf'
          : productNameController.text.trim(),
      code: 'PRD-2024-00182',
      category: selectedCategory.value,
      submittedDate: 'Jun 15, 2026',
      status: SellerProductStatus.pending,
      price: double.tryParse(sellingPriceController.text.trim()) ?? 18000.0,
      imageUrl: mainPhotoUrl.value.isNotEmpty
          ? mainPhotoUrl.value
          : 'https://images.unsplash.com/photo-1579783902614-a3fb3927b675?w=600',
      material: materialController.text.trim(),
      origin: originController.text.trim(),
      colorVariants: colorVariants,
    );

    Get.offNamed(
      AppRoute.sellerReviewTracking,
      arguments: submittedProduct,
    );
  }
}
