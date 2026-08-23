import '../models/artist_revenue_model.dart';
import '../models/artist_transaction_model.dart';
import '../../domain/entities/artist_transaction_entity.dart';

abstract class ArtistRevenueRemoteDataSource {
  Future<ArtistRevenueModel> fetchRevenueStats();
  Future<List<ArtistTransactionModel>> fetchTransactions({
    ArtistTransactionStatus? status,
  });
  Future<bool> submitPayoutRequest({
    required String orderId,
    required String paymentMethod,
    required String phoneNumber,
    String? message,
  });
}

class ArtistRevenueRemoteDataSourceImpl
    implements ArtistRevenueRemoteDataSource {
  @override
  Future<ArtistRevenueModel> fetchRevenueStats() async {
    // Simulating remote network latency
    await Future.delayed(const Duration(milliseconds: 300));
    return ArtistRevenueModel.mockData();
  }

  @override
  Future<List<ArtistTransactionModel>> fetchTransactions({
    ArtistTransactionStatus? status,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final list = ArtistTransactionModel.getInitialTransactions();
    if (status != null) {
      return list.where((t) => t.status == status).toList();
    }
    return list;
  }

  @override
  Future<bool> submitPayoutRequest({
    required String orderId,
    required String paymentMethod,
    required String phoneNumber,
    String? message,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));
    return true;
  }
}
