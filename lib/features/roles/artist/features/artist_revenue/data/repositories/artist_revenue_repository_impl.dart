import '../../domain/entities/artist_revenue_entity.dart';
import '../../domain/entities/artist_transaction_entity.dart';
import '../../domain/repositories/artist_revenue_repository.dart';
import '../datasources/artist_revenue_remote_data_source.dart';

class ArtistRevenueRepositoryImpl implements ArtistRevenueRepository {
  final ArtistRevenueRemoteDataSource remoteDataSource;

  ArtistRevenueRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ArtistRevenueEntity> getRevenueStats() async {
    return await remoteDataSource.fetchRevenueStats();
  }

  @override
  Future<List<ArtistTransactionEntity>> getTransactions({
    ArtistTransactionStatus? status,
  }) async {
    return await remoteDataSource.fetchTransactions(status: status);
  }

  @override
  Future<bool> requestPayout({
    required String orderId,
    required String paymentMethod,
    required String phoneNumber,
    String? message,
  }) async {
    return await remoteDataSource.submitPayoutRequest(
      orderId: orderId,
      paymentMethod: paymentMethod,
      phoneNumber: phoneNumber,
      message: message,
    );
  }
}
