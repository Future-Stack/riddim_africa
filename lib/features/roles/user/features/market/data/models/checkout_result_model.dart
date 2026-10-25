import '../../domain/entities/checkout_result_entity.dart';

class CheckoutResultModel extends CheckoutResultEntity {
  const CheckoutResultModel({
    required super.showOrderId,
    required super.orderId,
  });

  factory CheckoutResultModel.fromJson(Map<String, dynamic> json) {
    return CheckoutResultModel(
      showOrderId: (json['showOrderId'] ?? '').toString(),
      orderId: (json['orderId'] ?? '').toString(),
    );
  }
}
