import '../entities/artist_revenue_entity.dart';
import '../entities/artist_transaction_entity.dart';

abstract class ArtistRevenueRepository {
  Future<ArtistRevenueEntity> getRevenueStats();
  Future<List<ArtistTransactionEntity>> getTransactions({
    ArtistTransactionStatus? status,
  });
  Future<bool> requestPayout({
    required String orderId,
    required String paymentMethod,
    required String phoneNumber,
    String? message,
  });
}
