import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/utils/constants/icon_path.dart';
import 'package:riddimafrica/features/bottom_nav/domain/entities/nav_model.dart';
import 'package:riddimafrica/features/roles/seller/features/seller_home/presentation/screens/seller_home_screen.dart';

import 'package:riddimafrica/features/roles/seller/features/seller_products/presentation/screens/seller_products_screen.dart';
import 'package:riddimafrica/features/roles/seller/features/seller_orders/presentation/screens/seller_orders_screen.dart';
import 'package:riddimafrica/features/roles/seller/features/seller_revenue/presentation/screens/seller_revenue_screen.dart';

import 'package:riddimafrica/features/roles/seller/features/seller_profile/presentation/screens/seller_profile_screen.dart';

// ─── Controller ─────────────────────────────────────────────────────────────

class SellerBottomNavController extends GetxController {
  final RxInt currentIndex = 0.obs; // default to Home (index 0)

  // ── Nav items — add/remove/reorder freely ──────────────────────────────
  final List<NavItem> selleritems = const [
    NavItem(title: 'Home', iconPath: IconPath.home),
    NavItem(title: 'Products', iconPath: IconPath.box),
    NavItem(title: 'Orders', iconPath: IconPath.cart),
    NavItem(title: 'Revenue', iconPath: IconPath.revenue),
    NavItem(title: 'Profile', iconPath: IconPath.profile),
  ];

  // ── Screens — keep in the same order as items ──────────────────────────
  final List<Widget> screens = const [
    SellerHomeScreen(),
    SellerProductsScreen(),
    SellerOrdersScreen(),
    SellerRevenueScreen(),
    SellerProfileScreen(),
  ];

  // ── Actions ────────────────────────────────────────────────────────────
  void changeIndex(int index) {
    assert(index >= 0 && index < selleritems.length, 'Index out of range');
    currentIndex.value = index;
  }

  void goTo(String tabTitle) {
    final idx = selleritems.indexWhere(
      (e) => e.title.toLowerCase() == tabTitle.toLowerCase(),
    );
    if (idx != -1) changeIndex(idx);
  }
}
