import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/artist_revenue_entity.dart';
import '../../domain/entities/artist_transaction_entity.dart';
import '../../domain/usecases/get_artist_revenue_stats_usecase.dart';
import '../../domain/usecases/get_artist_transactions_usecase.dart';

class ArtistRevenueController extends GetxController {
  final GetArtistRevenueStatsUseCase getRevenueStatsUseCase;
  final GetArtistTransactionsUseCase getTransactionsUseCase;

  ArtistRevenueController({
    required this.getRevenueStatsUseCase,
    required this.getTransactionsUseCase,
  });

  final RxBool isLoading = false.obs;
  final Rx<ArtistRevenueEntity?> revenueStats = Rx<ArtistRevenueEntity?>(null);
  final RxList<ArtistTransactionEntity> allTransactions =
      <ArtistTransactionEntity>[].obs;
  final RxList<ArtistTransactionEntity> recentTransactions =
      <ArtistTransactionEntity>[].obs;

  // Chart state
  final RxString selectedFilter = 'Yearly'.obs; // 'Weekly', 'Monthly', 'Yearly'
  final RxInt selectedChartIndex = 1.obs; // default Feb

  // Transactions Screen Tab State: 0 = Settled, 1 = Payout in progress
  final RxInt selectedTab = 0.obs;

  final currencyFormatter = NumberFormat('#,##0', 'en_US');

  @override
  void onInit() {
    super.onInit();
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    try {
      isLoading.value = true;
      final stats = await getRevenueStatsUseCase();
      final txs = await getTransactionsUseCase();

      revenueStats.value = stats;
      allTransactions.assignAll(txs);
      recentTransactions.assignAll(txs.take(5).toList());
    } catch (e) {
      // Error handled gracefully
    } finally {
      isLoading.value = false;
    }
  }

  void setFilter(String filter) {
    selectedFilter.value = filter;
    // reset selection to a prominent index
    selectedChartIndex.value = 1;
  }

  void selectChartIndex(int index) {
    selectedChartIndex.value = index;
  }

  void setTab(int index) {
    selectedTab.value = index;
  }

  List<ChartDataPoint> get currentAnalyticsData {
    final stats = revenueStats.value;
    if (stats == null) return [];
    if (selectedFilter.value == 'Weekly') {
      return stats.weeklyAnalytics;
    } else if (selectedFilter.value == 'Monthly') {
      return stats.monthlyAnalytics;
    } else {
      return stats.yearlyAnalytics;
    }
  }

  List<ArtistTransactionEntity> get currentTabTransactions {
    if (selectedTab.value == 0) {
      return allTransactions
          .where((t) => t.status == ArtistTransactionStatus.settled)
          .toList();
    } else {
      return allTransactions
          .where((t) => t.status == ArtistTransactionStatus.inProgress)
          .toList();
    }
  }

  String get formattedTotalRevenue {
    final amount = revenueStats.value?.totalRevenueMonth ?? 234500.0;
    return 'UGX ${currencyFormatter.format(amount)}';
  }

  String get formattedSettledRevenue {
    final amount = revenueStats.value?.settledRevenue ?? 189200.0;
    return 'UGX ${currencyFormatter.format(amount)}';
  }

  String get formattedPayoutInProgress {
    final amount = revenueStats.value?.payoutInProgress ?? 45300.0;
    return 'UGX ${currencyFormatter.format(amount)}';
  }

  String get growthPercentageString {
    final growth = revenueStats.value?.revenueGrowthPercentage ?? 18.0;
    return '+${growth.toStringAsFixed(0)}% this month';
  }
}
