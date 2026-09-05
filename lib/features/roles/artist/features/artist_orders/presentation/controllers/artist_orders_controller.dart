import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/artist_order_model.dart';

class ArtistOrdersController extends GetxController {
  final RxInt selectedTab = 0.obs; // 0: Active, 1: Completed, 2: Cancelled
  final RxBool isSearchVisible = false.obs;
  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;

  final RxList<ArtistOrderModel> allOrders = <ArtistOrderModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    allOrders.assignAll(ArtistOrderModel.getInitialOrders());
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void setTab(int index) {
    selectedTab.value = index;
  }

  void toggleSearch() {
    isSearchVisible.value = !isSearchVisible.value;
    if (!isSearchVisible.value) {
      searchController.clear();
      searchQuery.value = '';
    }
  }

  void onSearchChanged(String query) {
    searchQuery.value = query.toLowerCase();
  }

  int get activeCount => allOrders
      .where((o) =>
          o.status == ArtistOrderStatus.newOrder ||
          o.status == ArtistOrderStatus.processing ||
          o.status == ArtistOrderStatus.pending)
      .length;

  int get completedCount =>
      allOrders.where((o) => o.status == ArtistOrderStatus.delivered).length;

  int get cancelledCount =>
      allOrders.where((o) => o.status == ArtistOrderStatus.cancelled).length;

  List<ArtistOrderModel> get filteredOrders {
    List<ArtistOrderModel> list;
    if (selectedTab.value == 0) {
      list = allOrders
          .where((o) =>
              o.status == ArtistOrderStatus.newOrder ||
              o.status == ArtistOrderStatus.processing ||
              o.status == ArtistOrderStatus.pending)
          .toList();
    } else if (selectedTab.value == 1) {
      list = allOrders
          .where((o) => o.status == ArtistOrderStatus.delivered)
          .toList();
    } else {
      list = allOrders
          .where((o) => o.status == ArtistOrderStatus.cancelled)
          .toList();
    }

    if (searchQuery.value.isNotEmpty) {
      list = list.where((o) {
        return o.productTitle.toLowerCase().contains(searchQuery.value) ||
            o.id.toLowerCase().contains(searchQuery.value) ||
            o.customerName.toLowerCase().contains(searchQuery.value);
      }).toList();
    }

    return list;
  }
}
