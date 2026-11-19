import 'package:get/get.dart';

class ArtistSettingsController extends GetxController {
  final RxBool ordersNotification = true.obs;
  final RxBool productApprovalNotification = true.obs;
  final RxBool earningsSettlementNotification = false.obs;
  final RxBool promotionsNotification = false.obs;

  void toggleOrders(bool val) => ordersNotification.value = val;
  void toggleProductApproval(bool val) =>
      productApprovalNotification.value = val;
  void toggleEarningsSettlement(bool val) =>
      earningsSettlementNotification.value = val;
  void togglePromotions(bool val) => promotionsNotification.value = val;
}
