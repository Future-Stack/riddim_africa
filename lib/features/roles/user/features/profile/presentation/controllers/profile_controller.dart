import 'dart:developer';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../data/datasources/profile_remote_data_source.dart';
import '../../data/models/user_profile_model.dart';
import '../../../home/data/models/product_model.dart';

class ProfileController extends GetxController {
  final ProfileRemoteDataSource _remoteDataSource;

  ProfileController({ProfileRemoteDataSource? remoteDataSource})
      : _remoteDataSource = remoteDataSource ??
            (Get.isRegistered<ProfileRemoteDataSource>()
                ? Get.find<ProfileRemoteDataSource>()
                : ProfileRemoteDataSource());

  // State Management
  final Rx<UserProfileModel?> profile = Rx<UserProfileModel?>(null);
  final RxBool isLoading = false.obs;
  final RxBool isUpdating = false.obs;
  final RxString errorMessage = ''.obs;

  // Reactive Profile Info
  final RxString userId = ''.obs;
  final RxString role = ''.obs;
  final RxString name = ''.obs;
  final RxString username = ''.obs;
  final RxString email = ''.obs;
  final RxString phoneNumber = ''.obs;
  final RxString city = ''.obs;
  final RxString country = ''.obs;
  final RxString location = ''.obs;
  final RxString profileImageUrl = ''.obs;
  final RxString profileImagePath = ''.obs; // For picked local image
  final RxBool isVerified = false.obs;
  final RxString memberSince = ''.obs;

  // Stats
  final RxInt ordersCount = 0.obs;
  final RxInt wishlistCount = 0.obs;
  final RxInt artistCount = 0.obs;

  // Mock list of wishlist products (used by WishlistScreen)
  final RxList<ProductModel> wishlist = <ProductModel>[
    const ProductModel(
      id: 'w1',
      imageUrl:
          'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?q=80&w=500&auto=format&fit=crop',
      title: 'Kente Drum Bag',
      subtitle: 'Craft Studio UG',
      rating: 4.9,
      categoryText: 'Bags',
      price: 'UGX 45,000',
    ),
    const ProductModel(
      id: 'w2',
      imageUrl:
          'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?q=80&w=500&auto=format&fit=crop',
      title: 'Ankara Print Hoodie',
      subtitle: 'AfroStyle KLA',
      rating: 4.8,
      categoryText: 'Hoodies',
      price: 'UGX 78,000',
    ),
    const ProductModel(
      id: 'w3',
      imageUrl:
          'https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?q=80&w=500&auto=format&fit=crop',
      title: 'Beaded Necklace Set',
      subtitle: 'Zuri Jewels',
      rating: 4.7,
      categoryText: 'Jewelry',
      price: 'UGX 32,000',
    ),
  ].obs;

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  // Fetch User Profile from GET /api/v1/user/profile
  Future<void> fetchProfile() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _remoteDataSource.getUserProfile();

      if (response.isSuccess) {
        final dynamic rawData = response.responseData;
        Map<String, dynamic>? dataMap;

        if (rawData is Map<String, dynamic>) {
          if (rawData['data'] is Map<String, dynamic>) {
            dataMap = rawData['data'] as Map<String, dynamic>;
          } else {
            dataMap = rawData;
          }
        }

        if (dataMap != null) {
          final userProfile = UserProfileModel.fromJson(dataMap);
          profile.value = userProfile;
          _populateFields(userProfile);
          log('[PROFILE] User profile loaded successfully for ${userProfile.email}');
        } else {
          errorMessage.value = 'Failed to parse profile data.';
        }
      } else {
        errorMessage.value = response.errorMessage.isNotEmpty
            ? response.errorMessage
            : 'Failed to fetch user profile';
        log('[PROFILE ERROR] ${response.errorMessage}');
      }
    } catch (e, stack) {
      log('[PROFILE EXCEPTION] $e', error: e, stackTrace: stack);
      errorMessage.value = 'An error occurred while loading profile: $e';
    } finally {
      isLoading.value = false;
    }
  }

  void _populateFields(UserProfileModel p) {
    userId.value = p.userId ?? '';
    role.value = p.role ?? 'USER';
    name.value = p.fullName ?? '';
    username.value = p.username ?? '';
    email.value = p.email ?? '';
    phoneNumber.value = p.phoneNumber ?? '';
    city.value = p.city ?? '';
    country.value = p.country ?? '';
    location.value = p.location ??
        ([p.city, p.country].where((e) => e != null && e.isNotEmpty).join(', '));
    profileImageUrl.value = p.profileImage ?? '';
    isVerified.value = p.isVerified;

    ordersCount.value = p.stats.orders;
    wishlistCount.value = p.stats.wishlist;
    artistCount.value = p.stats.artist;

    if (p.createdAt != null) {
      try {
        memberSince.value = DateFormat('MMMM yyyy').format(p.createdAt!);
      } catch (_) {
        memberSince.value = '';
      }
    }
  }

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

  // Method to update profile via PATCH /api/v1/user/profile
  Future<bool> updateProfileDetails({
    required String newName,
    required String newUsername,
    required String newPhone,
    required String newCity,
    required String newCountry,
    String? stateName,
    String? stageName,
    String? genre,
    String? bio,
  }) async {
    try {
      isUpdating.value = true;
      final response = await _remoteDataSource.updateProfile(
        fullName: newName,
        username: newUsername,
        phoneNumber: newPhone,
        country: newCountry,
        city: newCity,
        stateName: stateName,
        stageName: stageName,
        genre: genre,
        bio: bio,
        profileImagePath:
            profileImagePath.value.isNotEmpty ? profileImagePath.value : null,
      );

      if (response.isSuccess) {
        final dynamic rawData = response.responseData;
        Map<String, dynamic>? dataMap;

        if (rawData is Map<String, dynamic>) {
          if (rawData['data'] is Map<String, dynamic>) {
            final inner = rawData['data'] as Map<String, dynamic>;
            if (inner['profile'] is Map<String, dynamic>) {
              dataMap = inner['profile'] as Map<String, dynamic>;
            } else {
              dataMap = inner;
            }
          } else if (rawData['profile'] is Map<String, dynamic>) {
            dataMap = rawData['profile'] as Map<String, dynamic>;
          } else {
            dataMap = rawData;
          }
        }

        if (dataMap != null) {
          final updatedProfile = UserProfileModel.fromJson(dataMap);
          profile.value = updatedProfile;
          _populateFields(updatedProfile);
          profileImagePath.value = ''; // Reset local file path
        } else {
          name.value = newName;
          username.value = newUsername;
          phoneNumber.value = newPhone;
          city.value = newCity;
          country.value = newCountry;
          location.value = '$newCity, $newCountry';
        }

        Get.back();
        Get.snackbar(
          'Success',
          (response.responseData is Map &&
                  response.responseData['message'] != null)
              ? response.responseData['message'].toString()
              : 'Profile updated successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
        return true;
      } else {
        Get.snackbar(
          'Error',
          response.errorMessage.isNotEmpty
              ? response.errorMessage
              : 'Failed to update profile',
          snackPosition: SnackPosition.BOTTOM,
        );
        return false;
      }
    } catch (e, stack) {
      log('[UPDATE PROFILE EXCEPTION] $e', error: e, stackTrace: stack);
      Get.snackbar(
        'Error',
        'An unexpected error occurred: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      isUpdating.value = false;
    }
  }

  // Wrapper for existing calls from EditProfileScreen
  Future<void> saveProfile({
    required String newName,
    required String newUsername,
    required String newEmail,
    required String newPhone,
    required String newCity,
    required String newCountry,
  }) async {
    await updateProfileDetails(
      newName: newName,
      newUsername: newUsername,
      newPhone: newPhone,
      newCity: newCity,
      newCountry: newCountry,
    );
  }

  // Toggle favorite status on wishlist
  void toggleWishlist(ProductModel item) {
    if (wishlist.any((element) => element.id == item.id)) {
      wishlist.removeWhere((element) => element.id == item.id);
      wishlistCount.value = wishlist.length;
      Get.snackbar(
        'Removed',
        '${item.title} removed from wishlist',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      wishlist.add(item);
      wishlistCount.value = wishlist.length;
      Get.snackbar(
        'Added',
        '${item.title} added to wishlist',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
