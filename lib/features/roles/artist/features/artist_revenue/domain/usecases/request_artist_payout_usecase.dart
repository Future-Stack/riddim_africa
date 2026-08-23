import '../repositories/artist_revenue_repository.dart';

class RequestArtistPayoutUseCase {
  final ArtistRevenueRepository repository;

  RequestArtistPayoutUseCase(this.repository);

  Future<bool> call({
    required String orderId,
    required String paymentMethod,
    required String phoneNumber,
    String? message,
  }) async {
    return await repository.requestPayout(
      orderId: orderId,
      paymentMethod: paymentMethod,
      phoneNumber: phoneNumber,
      message: message,
    );
  }
}
