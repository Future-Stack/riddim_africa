import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/utils/constants/icon_path.dart';
import 'package:riddimafrica/features/bottom_nav/domain/entities/nav_model.dart';
import 'package:riddimafrica/features/roles/artist/features/artist_home/presentation/screens/artist_home_screen.dart';
import 'package:riddimafrica/features/roles/artist/features/artist_products/presentation/screens/artist_products_screen.dart';
import 'package:riddimafrica/features/roles/artist/features/artist_orders/presentation/screens/artist_orders_screen.dart';
import 'package:riddimafrica/features/roles/artist/features/artist_revenue/presentation/screens/artist_revenue_screen.dart';
import 'package:riddimafrica/features/roles/artist/features/artist_profile/presentation/screens/artist_profile_screen.dart';

// ─── Controller ─────────────────────────────────────────────────────────────

class ArtistBottomNavController extends GetxController {
  final RxInt currentIndex = 0.obs; // default to Home (index 0)

  // ── Nav items — add/remove/reorder freely ──────────────────────────────
  final List<NavItem> artistitems = const [
    NavItem(title: 'Home', iconPath: IconPath.home),
    NavItem(title: 'Products', iconPath: IconPath.box),
    NavItem(title: 'Orders', iconPath: IconPath.cart),
    NavItem(title: 'Revenue', iconPath: IconPath.revenue),
    NavItem(title: 'Profile', iconPath: IconPath.profile),
  ];

  // ── Screens — keep in the same order as items ──────────────────────────
  final List<Widget> screens = const [
    ArtistHomeScreen(),
    ArtistProductsScreen(),
    ArtistOrdersScreen(),
    ArtistRevenueScreen(),
    ArtistProfileScreen(),
  ];

  // ── Actions ────────────────────────────────────────────────────────────
  void changeIndex(int index) {
    assert(index >= 0 && index < artistitems.length, 'Index out of range');
    currentIndex.value = index;
  }

  void goTo(String tabTitle) {
    final idx = artistitems.indexWhere(
      (e) => e.title.toLowerCase() == tabTitle.toLowerCase(),
    );
    if (idx != -1) changeIndex(idx);
  }
}

