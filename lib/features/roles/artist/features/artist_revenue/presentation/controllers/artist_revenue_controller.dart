import 'package:get/get.dart';
import '../../data/models/artist_revenue_model.dart';

class ArtistRevenueController extends GetxController {
  final RxString totalRevenueMonth = 'UGX 234,500'.obs;
  final RxString settledAmount = 'UGX 189,200'.obs;
  final RxString payoutInProgressAmount = 'UGX 45,300'.obs;

  // Tab: 0 = Settled to Mobile money, 1 = Payout in progress
  final RxInt selectedTab = 0.obs;

  final RxList<ArtistTransactionModel> allTransactions =
      <ArtistTransactionModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    allTransactions.assignAll(ArtistTransactionModel.getInitialTransactions());
  }

  void setTab(int index) {
    selectedTab.value = index;
  }

  List<ArtistTransactionModel> get recentTransactions =>
      allTransactions.take(3).toList();

  List<ArtistTransactionModel> get settledTransactions => allTransactions
      .where((t) => t.status == ArtistTransactionStatus.settled)
      .toList();

  List<ArtistTransactionModel> get inProgressTransactions => allTransactions
      .where((t) => t.status == ArtistTransactionStatus.inProgress)
      .toList();

  List<ArtistTransactionModel> get currentTabTransactions =>
      selectedTab.value == 0 ? settledTransactions : inProgressTransactions;
}
