import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/entities/delivery_address_entity.dart';
import '../../domain/usecases/get_delivery_addresses_usecase.dart';

class CheckoutController extends GetxController {
  final GetDeliveryAddressesUseCase _getDeliveryAddressesUseCase;

  CheckoutController(this._getDeliveryAddressesUseCase);

  // State
  final RxBool isLoading = true.obs;
  final RxInt currentStep = 0.obs;
  final RxInt selectedAddressIndex = 0.obs;
  final RxBool isAddingNewAddress = false.obs;
  final RxString selectedAddressType = 'Home'.obs; // Home, Work, Other
  final RxString selectedPaymentMethod = 'Airtel Money'.obs; // MTN Mobile Money, Airtel Money

  // Data
  final RxList<DeliveryAddressEntity> addresses =
      <DeliveryAddressEntity>[].obs;

  // Form Controllers
  final TextEditingController fullNameController =
      TextEditingController(text: 'Richard Ngrava');
  final TextEditingController phoneController =
      TextEditingController(text: '+256452000000');
  final TextEditingController emailController =
      TextEditingController(text: 'richard@riddim.africa');

  // Add Address Form Controllers
  final TextEditingController cityController = TextEditingController(text: 'Kampala');
  final TextEditingController streetAddressController =
      TextEditingController(text: 'Plot 12, Buganda Road');
  final TextEditingController specialInstructionController =
      TextEditingController();

  // Step Labels
  final List<String> stepLabels = const [
    'Shipping',
    'Review',
    'Payment',
    'Processing',
  ];

  int get totalSteps => stepLabels.length;

  @override
  void onInit() {
    super.onInit();
    _loadAddresses();
  }

  @override
  void onClose() {
    fullNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    cityController.dispose();
    streetAddressController.dispose();
    specialInstructionController.dispose();
    super.onClose();
  }

  Future<void> _loadAddresses() async {
    isLoading.value = true;
    try {
      final result = await _getDeliveryAddressesUseCase.execute();
      addresses.value = result;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load addresses');
    } finally {
      isLoading.value = false;
    }
  }

  void selectAddress(int index) {
    selectedAddressIndex.value = index;
  }

  void nextStep() {
    if (currentStep.value < totalSteps - 1) {
      currentStep.value++;
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  void showAddAddressForm() {
    isAddingNewAddress.value = true;
  }

  void hideAddAddressForm() {
    isAddingNewAddress.value = false;
  }

  void selectAddressType(String type) {
    selectedAddressType.value = type;
  }

  void selectPaymentMethod(String method) {
    selectedPaymentMethod.value = method;
  }

  void saveAddress() {
    if (cityController.text.trim().isEmpty ||
        streetAddressController.text.trim().isEmpty) {
      Get.snackbar(
        'Required Fields',
        'Please enter City and Street Address',
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
      return;
    }

    final newAddress = DeliveryAddressEntity(
      id: 'addr_${DateTime.now().millisecondsSinceEpoch}',
      label: selectedAddressType.value,
      address: '${streetAddressController.text.trim()}, ${cityController.text.trim()}',
    );

    addresses.add(newAddress);
    selectedAddressIndex.value = addresses.length - 1;

    // Reset Form fields
    cityController.clear();
    streetAddressController.clear();
    specialInstructionController.clear();
    isAddingNewAddress.value = false;

    Get.snackbar(
      'Success',
      'Address saved successfully!',
      backgroundColor: Colors.green.withValues(alpha: 0.8),
      colorText: Colors.white,
    );
  }
}
