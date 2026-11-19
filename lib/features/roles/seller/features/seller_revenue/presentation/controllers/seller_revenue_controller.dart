import 'package:get/get.dart';
import '../../data/models/seller_revenue_model.dart';

class SellerRevenueController extends GetxController {
  final RxString totalRevenueMonth = 'UGX 234,500'.obs;
  final RxString settledAmount = 'UGX 189,200'.obs;
  final RxString payoutInProgressAmount = 'UGX 45,300'.obs;

  // Tab: 0 = Settled to Mobile money, 1 = Payout in progress
  final RxInt selectedTab = 0.obs;

  final RxList<SellerTransactionModel> allTransactions =
      <SellerTransactionModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    allTransactions.assignAll(SellerTransactionModel.getInitialTransactions());
  }

  void setTab(int index) {
    selectedTab.value = index;
  }

  List<SellerTransactionModel> get recentTransactions =>
      allTransactions.take(3).toList();

  List<SellerTransactionModel> get settledTransactions => allTransactions
      .where((t) => t.status == SellerTransactionStatus.settled)
      .toList();

  List<SellerTransactionModel> get inProgressTransactions => allTransactions
      .where((t) => t.status == SellerTransactionStatus.inProgress)
      .toList();

  List<SellerTransactionModel> get currentTabTransactions =>
      selectedTab.value == 0 ? settledTransactions : inProgressTransactions;
}
