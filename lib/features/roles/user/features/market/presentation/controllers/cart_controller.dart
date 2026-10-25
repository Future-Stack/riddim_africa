import 'package:get/get.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../../domain/usecases/get_cart_items_usecase.dart';

class CartController extends GetxController {
  final GetCartItemsUseCase _getCartItemsUseCase;

  CartController(this._getCartItemsUseCase);

  // State
  final RxBool isLoading = true.obs;
  final RxList<CartItemEntity> cartItems = <CartItemEntity>[].obs;

  // Computed
  int get totalItems => cartItems.length;

  String get subtotalText {
    int total = 0;
    for (final item in cartItems) {
      final numericPrice = _parsePrice(item.price);
      total += numericPrice * item.quantity;
    }
    return 'UGX ${_formatNumber(total)}';
  }

  String get shippingFeeText => 'UGX 5,500';

  String get totalText {
    int subtotal = 0;
    for (final item in cartItems) {
      final numericPrice = _parsePrice(item.price);
      subtotal += numericPrice * item.quantity;
    }
    final total = subtotal + 5500;
    return 'UGX ${_formatNumber(total)}';
  }

  @override
  void onInit() {
    super.onInit();
    loadCartItems();
  }

  Future<void> loadCartItems() async {
    isLoading.value = true;
    try {
      final items = await _getCartItemsUseCase.execute();
      cartItems.value = items;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load cart');
    } finally {
      isLoading.value = false;
    }
  }

  void incrementQuantity(int index) {
    final item = cartItems[index];
    cartItems[index] = item.copyWith(quantity: item.quantity + 1);
  }

  void decrementQuantity(int index) {
    final item = cartItems[index];
    if (item.quantity > 1) {
      cartItems[index] = item.copyWith(quantity: item.quantity - 1);
    }
  }

  void removeItem(int index) {
    cartItems.removeAt(index);
  }

  void proceedToCheckout() {
    Get.toNamed(
      '/marketCheckout',
      arguments: {
        'checkoutType': 'CART',
        'cartItems': cartItems.toList(),
      },
    );
  }

  // ─── Helpers ──────────────────────────────────────────────
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
}
