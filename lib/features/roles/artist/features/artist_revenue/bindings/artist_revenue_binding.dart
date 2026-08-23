import 'package:get/get.dart';
import '../data/datasources/artist_revenue_remote_data_source.dart';
import '../data/repositories/artist_revenue_repository_impl.dart';
import '../domain/repositories/artist_revenue_repository.dart';
import '../domain/usecases/get_artist_revenue_stats_usecase.dart';
import '../domain/usecases/get_artist_transactions_usecase.dart';
import '../domain/usecases/request_artist_payout_usecase.dart';
import '../presentation/controllers/artist_revenue_controller.dart';
import '../presentation/controllers/artist_request_payment_controller.dart';

class ArtistRevenueBinding extends Bindings {
  @override
  void dependencies() {
    // ─── Data Source ────────────────────────────────────────────────────────
    Get.lazyPut<ArtistRevenueRemoteDataSource>(
      () => ArtistRevenueRemoteDataSourceImpl(),
      fenix: true,
    );

    // ─── Repository ─────────────────────────────────────────────────────────
    Get.lazyPut<ArtistRevenueRepository>(
      () => ArtistRevenueRepositoryImpl(
        remoteDataSource: Get.find<ArtistRevenueRemoteDataSource>(),
      ),
      fenix: true,
    );

    // ─── Use Cases ──────────────────────────────────────────────────────────
    Get.lazyPut<GetArtistRevenueStatsUseCase>(
      () => GetArtistRevenueStatsUseCase(
        Get.find<ArtistRevenueRepository>(),
      ),
      fenix: true,
    );

    Get.lazyPut<GetArtistTransactionsUseCase>(
      () => GetArtistTransactionsUseCase(
        Get.find<ArtistRevenueRepository>(),
      ),
      fenix: true,
    );

    Get.lazyPut<RequestArtistPayoutUseCase>(
      () => RequestArtistPayoutUseCase(
        Get.find<ArtistRevenueRepository>(),
      ),
      fenix: true,
    );

    // ─── Controllers ────────────────────────────────────────────────────────
    Get.lazyPut<ArtistRevenueController>(
      () => ArtistRevenueController(
        getRevenueStatsUseCase: Get.find<GetArtistRevenueStatsUseCase>(),
        getTransactionsUseCase: Get.find<GetArtistTransactionsUseCase>(),
      ),
      fenix: true,
    );

    Get.lazyPut<ArtistRequestPaymentController>(
      () => ArtistRequestPaymentController(
        requestPayoutUseCase: Get.find<RequestArtistPayoutUseCase>(),
      ),
      fenix: true,
    );
  }
}
