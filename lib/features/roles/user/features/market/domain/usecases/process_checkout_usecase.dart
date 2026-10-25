import '../entities/checkout_result_entity.dart';
import '../repositories/market_repository.dart';

class ProcessCheckoutUseCase {
  final MarketRepository _repository;

  ProcessCheckoutUseCase(this._repository);

  Future<CheckoutResultEntity> execute({
    required String? shippingInfoId,
    required Map<String, dynamic> shippingDetails,
    required String paymentMethod,
    required String checkoutType,
    Map<String, dynamic>? directPurchase,
  }) {
    return _repository.processCheckout(
      shippingInfoId: shippingInfoId,
      shippingDetails: shippingDetails,
      paymentMethod: paymentMethod,
      checkoutType: checkoutType,
      directPurchase: directPurchase,
    );
  }
}
