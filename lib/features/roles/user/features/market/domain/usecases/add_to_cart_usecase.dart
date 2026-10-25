import '../repositories/market_repository.dart';

class AddToCartUseCase {
  final MarketRepository _repository;

  AddToCartUseCase(this._repository);

  Future<bool> execute({
    required String productId,
    required int quantity,
    String? color,
    String? size,
  }) {
    return _repository.addToCart(
      productId: productId,
      quantity: quantity,
      color: color,
      size: size,
    );
  }
}
