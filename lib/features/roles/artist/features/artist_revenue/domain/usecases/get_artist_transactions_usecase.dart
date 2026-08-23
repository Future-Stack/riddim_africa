import '../entities/artist_transaction_entity.dart';
import '../repositories/artist_revenue_repository.dart';

class GetArtistTransactionsUseCase {
  final ArtistRevenueRepository repository;

  GetArtistTransactionsUseCase(this.repository);

  Future<List<ArtistTransactionEntity>> call({
    ArtistTransactionStatus? status,
  }) async {
    return await repository.getTransactions(status: status);
  }
}
