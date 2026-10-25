import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../../domain/entities/delivery_address_entity.dart';
import '../../domain/entities/market_product_entity.dart';
import '../../domain/usecases/get_delivery_addresses_usecase.dart';
import '../../domain/usecases/save_delivery_address_usecase.dart';
import '../../domain/usecases/process_checkout_usecase.dart';
import '../../domain/usecases/get_cart_items_usecase.dart';

class CheckoutController extends GetxController {
  final GetDeliveryAddressesUseCase _getDeliveryAddressesUseCase;
  final SaveDeliveryAddressUseCase _saveDeliveryAddressUseCase;
  final ProcessCheckoutUseCase _processCheckoutUseCase;
  final GetCartItemsUseCase _getCartItemsUseCase;

  CheckoutController(
    this._getDeliveryAddressesUseCase,
    this._saveDeliveryAddressUseCase,
    this._processCheckoutUseCase,
    this._getCartItemsUseCase,
  );

  // State
  final RxBool isLoading = true.obs;
  final RxBool isSavingAddress = false.obs;
  final RxBool isProcessingCheckout = false.obs;
  final RxInt currentStep = 0.obs;
  final RxInt selectedAddressIndex = 0.obs;
  final RxBool isAddingNewAddress = false.obs;
  final RxString selectedAddressType = 'Home'.obs; // Home, Work, Other
  final RxString selectedPaymentMethod =
      'MTN Mobile Money'.obs; // MTN Mobile Money, Airtel Money

  // Checkout Type & Direct Purchase details
  final RxString checkoutType = 'CART'.obs; // 'DIRECT' or 'CART'
  final Rx<MarketProductEntity?> directProduct = Rx<MarketProductEntity?>(null);
  final RxString directProductId = ''.obs;
  final RxString directProductTitle = ''.obs;
  final RxString directProductImage = ''.obs;
  final RxString directProductPrice = ''.obs;
  final Rx<num?> directProductRawPrice = Rx<num?>(null);
  final RxInt directQuantity = 1.obs;
  final RxString directColor = ''.obs;
  final RxString directSize = ''.obs;

  // Cart items for CART checkout
  final RxList<CartItemEntity> checkoutCartItems = <CartItemEntity>[].obs;

  // Saved Addresses Data
  final RxList<DeliveryAddressEntity> addresses =
      <DeliveryAddressEntity>[].obs;

  // Order Result
  final RxString showOrderId = ''.obs;
  final RxString orderId = ''.obs;

  // Form Controllers
  final TextEditingController fullNameController =
      TextEditingController(text: 'John Doe');
  final TextEditingController phoneController =
      TextEditingController(text: '+256700000000');
  final TextEditingController emailController =
      TextEditingController(text: 'john@example.com');

  // Add Address Form Controllers
  final TextEditingController cityController =
      TextEditingController(text: 'Kampala');
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

  // Pricing calculations
  int get subtotal {
    if (checkoutType.value == 'DIRECT') {
      final raw = directProductRawPrice.value;
      if (raw != null) {
        return (raw * directQuantity.value).toInt();
      }
      final parsed = _parsePrice(directProductPrice.value);
      return parsed * directQuantity.value;
    } else {
      int total = 0;
      for (final item in checkoutCartItems) {
        final price = item.rawPrice?.toInt() ?? _parsePrice(item.price);
        total += price * item.quantity;
      }
      return total > 0 ? total : 35000;
    }
  }

  int get deliveryFee => 5500;

  int get totalAmount => subtotal + deliveryFee;

  String get subtotalFormatted => 'UGX ${_formatNumber(subtotal)}';
  String get deliveryFeeFormatted => 'UGX ${_formatNumber(deliveryFee)}';
  String get totalAmountFormatted => 'UGX ${_formatNumber(totalAmount)}';

  @override
  void onInit() {
    super.onInit();
    _initFromArguments();
    _loadAddresses();
  }

  void _initFromArguments() {
    final args = Get.arguments;
    if (args is Map<String, dynamic>) {
      final type = args['checkoutType'] as String? ?? 'CART';
      checkoutType.value = type;

      if (type == 'DIRECT') {
        directProductId.value = args['productId']?.toString() ?? '';
        directProductTitle.value = args['title']?.toString() ?? '';
        directProductImage.value = args['imageUrl']?.toString() ?? '';
        directProductPrice.value = args['price']?.toString() ?? '';
        directProductRawPrice.value = args['rawPrice'] as num?;
        directQuantity.value = args['quantity'] as int? ?? 1;
        directColor.value = args['color']?.toString() ?? '';
        directSize.value = args['size']?.toString() ?? '';
        if (args['product'] is MarketProductEntity) {
          directProduct.value = args['product'] as MarketProductEntity;
        }
      } else {
        if (args['cartItems'] is List<CartItemEntity>) {
          checkoutCartItems.value = args['cartItems'] as List<CartItemEntity>;
        }
      }
    }

    final storedEmail = StorageService.email;
    if (storedEmail != null && storedEmail.isNotEmpty) {
      emailController.text = storedEmail;
    }
  }

  Future<void> _loadAddresses() async {
    isLoading.value = true;
    try {
      final result = await _getDeliveryAddressesUseCase.execute();
      addresses.value = result;

      if (addresses.isNotEmpty) {
        final defaultIdx = addresses.indexWhere((a) => a.isDefault);
        final selectedIdx = defaultIdx != -1 ? defaultIdx : 0;
        selectAddress(selectedIdx);
      } else {
        fullNameController.text = 'John Doe';
        phoneController.text = '+256700000000';
        if (emailController.text.isEmpty) {
          emailController.text = 'john@example.com';
        }
      }

      if (checkoutType.value == 'CART' && checkoutCartItems.isEmpty) {
        try {
          final items = await _getCartItemsUseCase.execute();
          checkoutCartItems.value = items;
        } catch (_) {}
      }
    } catch (e) {
      log('CheckoutController._loadAddresses error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void selectAddress(int index) {
    if (index < 0 || index >= addresses.length) return;
    selectedAddressIndex.value = index;
    final addr = addresses[index];

    if (addr.fullName != null && addr.fullName!.isNotEmpty) {
      fullNameController.text = addr.fullName!;
    }
    if (addr.phoneNumber != null && addr.phoneNumber!.isNotEmpty) {
      phoneController.text = addr.phoneNumber!;
    }
    if (addr.email != null && addr.email!.isNotEmpty) {
      emailController.text = addr.email!;
    }
  }

  DeliveryAddressEntity? get selectedAddress {
    if (addresses.isEmpty || selectedAddressIndex.value >= addresses.length) {
      return null;
    }
    return addresses[selectedAddressIndex.value];
  }

  void nextStep() {
    if (currentStep.value == 0) {
      if (fullNameController.text.trim().isEmpty) {
        Get.snackbar(
          'Required Field',
          'Please enter your Full Name',
          backgroundColor: Colors.red.withValues(alpha: 0.8),
          colorText: Colors.white,
        );
        return;
      }
      if (phoneController.text.trim().isEmpty) {
        Get.snackbar(
          'Required Field',
          'Please enter your Phone Number',
          backgroundColor: Colors.red.withValues(alpha: 0.8),
          colorText: Colors.white,
        );
        return;
      }
      if (emailController.text.trim().isEmpty) {
        Get.snackbar(
          'Required Field',
          'Please enter your Email',
          backgroundColor: Colors.red.withValues(alpha: 0.8),
          colorText: Colors.white,
        );
        return;
      }
    }

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

  Future<void> saveAddress() async {
    final city = cityController.text.trim();
    final street = streetAddressController.text.trim();

    if (city.isEmpty || street.isEmpty) {
      Get.snackbar(
        'Required Fields',
        'Please enter City and Street Address',
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
      return;
    }

    isSavingAddress.value = true;
    try {
      final newAddressEntity = DeliveryAddressEntity(
        id: '',
        label: selectedAddressType.value.toUpperCase(),
        address: '$street, $city',
        fullName: fullNameController.text.trim().isNotEmpty
            ? fullNameController.text.trim()
            : 'John Doe',
        phoneNumber: phoneController.text.trim().isNotEmpty
            ? phoneController.text.trim()
            : '+256700000000',
        email: emailController.text.trim().isNotEmpty
            ? emailController.text.trim()
            : 'john@example.com',
        city: city,
        streetAddress: street,
        specialInstruction: specialInstructionController.text.trim(),
        latitude: 0.3236,
        longitude: 32.5806,
        isDefault: true,
      );

      final saved =
          await _saveDeliveryAddressUseCase.execute(newAddressEntity);
      addresses.add(saved);
      selectedAddressIndex.value = addresses.length - 1;

      cityController.clear();
      streetAddressController.clear();
      specialInstructionController.clear();
      isAddingNewAddress.value = false;

      Get.snackbar(
        'Success',
        'Shipping address saved successfully!',
        backgroundColor: Colors.green.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString().replaceAll('Exception: ', ''),
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
    } finally {
      isSavingAddress.value = false;
    }
  }

  Future<void> processOrderPayment() async {
    if (isProcessingCheckout.value) return;

    isProcessingCheckout.value = true;
    try {
      final selected = selectedAddress;
      final String? shippingInfoId = (selected?.id.isNotEmpty == true &&
              !selected!.id.startsWith('addr_'))
          ? selected.id
          : null;

      final Map<String, dynamic> shippingDetails = {
        'fullName': fullNameController.text.trim().isNotEmpty
            ? fullNameController.text.trim()
            : 'John Doe',
        'phoneNumber': phoneController.text.trim().isNotEmpty
            ? phoneController.text.trim()
            : '+256700000000',
        'email': emailController.text.trim().isNotEmpty
            ? emailController.text.trim()
            : 'john@example.com',
        'city': selected?.city ??
            (cityController.text.trim().isNotEmpty
                ? cityController.text.trim()
                : 'Kampala'),
        'streetAddress': selected?.streetAddress ??
            (streetAddressController.text.trim().isNotEmpty
                ? streetAddressController.text.trim()
                : 'Plot 12, Buganda Road'),
        'specialInstruction': selected?.specialInstruction ??
            specialInstructionController.text.trim(),
        'latitude': selected?.latitude ?? 0.3236,
        'longitude': selected?.longitude ?? 32.5806,
      };

      final paymentMethodParam = selectedPaymentMethod.value.contains('MTN')
          ? 'MTN_MOBILE_MONEY'
          : 'AIRTEL_MONEY';

      Map<String, dynamic>? directPurchaseMap;
      if (checkoutType.value == 'DIRECT') {
        directPurchaseMap = {
          'productId': directProductId.value,
          'quantity': directQuantity.value,
          if (directColor.value.isNotEmpty) 'color': directColor.value,
          if (directSize.value.isNotEmpty) 'size': directSize.value,
        };
      }

      final result = await _processCheckoutUseCase.execute(
        shippingInfoId: shippingInfoId,
        shippingDetails: shippingDetails,
        paymentMethod: paymentMethodParam,
        checkoutType: checkoutType.value,
        directPurchase: directPurchaseMap,
      );

      showOrderId.value = result.showOrderId;
      orderId.value = result.orderId;

      currentStep.value = 3;

      Get.snackbar(
        'Success',
        'Order ${result.showOrderId} placed successfully!',
        backgroundColor: AppColors.success.withValues(alpha: 0.9),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Checkout Failed',
        e.toString().replaceAll('Exception: ', ''),
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isProcessingCheckout.value = false;
    }
  }

  int _parsePrice(String price) {
    final cleaned = price.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(cleaned) ?? 0;
  }

  String _formatNumber(int number) {
    final str = number.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) buffer.write(',');
      buffer.write(str[i]);
    }
    return buffer.toString();
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
}
