import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../home/data/models/product_model.dart';

class ProfileController extends GetxController {
  // Reactive Profile Info
  final RxString name = 'Aisha Nakato'.obs;
  final RxString username = 'aisha.nakato'.obs;
  final RxString email = 'aisha.nakato@gmail.com'.obs;
  final RxString phoneNumber = '+256 700 123 456'.obs;
  final RxString city = 'Kampala'.obs;
  final RxString country = 'Uganda'.obs;
  final RxString profileImagePath = ''.obs;

  // Mock list of wishlist products
  final RxList<ProductModel> wishlist = <ProductModel>[
    const ProductModel(
      id: 'w1',
      imageUrl: 'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?q=80&w=500&auto=format&fit=crop',
      title: 'Kente Drum Bag',
      subtitle: 'Craft Studio UG',
      rating: 4.9,
      categoryText: 'Bags',
      price: 'UGX 45,000',
    ),
    const ProductModel(
      id: 'w2',
      imageUrl: 'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?q=80&w=500&auto=format&fit=crop',
      title: 'Ankara Print Hoodie',
      subtitle: 'AfroStyle KLA',
      rating: 4.8,
      categoryText: 'Hoodies',
      price: 'UGX 78,000',
    ),
    const ProductModel(
      id: 'w3',
      imageUrl: 'https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?q=80&w=500&auto=format&fit=crop',
      title: 'Beaded Necklace Set',
      subtitle: 'Zuri Jewels',
      rating: 4.7,
      categoryText: 'Jewelry',
      price: 'UGX 32,000',
    ),
  ].obs;

  final ImagePicker _picker = ImagePicker();

  // Method to pick profile photo
  Future<void> pickProfileImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        profileImagePath.value = image.path;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: $e');
    }
  }

  // Method to update profile details
  void saveProfile({
    required String newName,
    required String newUsername,
    required String newEmail,
    required String newPhone,
    required String newCity,
    required String newCountry,
  }) {
    name.value = newName;
    username.value = newUsername;
    email.value = newEmail;
    phoneNumber.value = newPhone;
    city.value = newCity;
    country.value = newCountry;
    
    Get.back();
    Get.snackbar(
      'Success',
      'Profile updated successfully',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // Toggle favorite status on wishlist
  void toggleWishlist(ProductModel item) {
    if (wishlist.any((element) => element.id == item.id)) {
      wishlist.removeWhere((element) => element.id == item.id);
      Get.snackbar(
        'Removed',
        '${item.title} removed from wishlist',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      wishlist.add(item);
      Get.snackbar(
        'Added',
        '${item.title} added to wishlist',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
