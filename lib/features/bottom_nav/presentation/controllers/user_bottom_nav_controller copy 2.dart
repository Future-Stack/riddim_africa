import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import 'package:riddimafrica/features/roles/user/features/home/presentation/screens/home_screen.dart';
import '../../domain/entities/nav_model.dart';

// ─── Placeholder screens ───────────────────────────────────────────────────
// Replace these with your actual screen widgets.

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      const _PlaceholderPage(label: 'Products');
}

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});
  @override
  Widget build(BuildContext context) => const _PlaceholderPage(label: 'Orders');
}

class RevenueScreen extends StatelessWidget {
  const RevenueScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      const _PlaceholderPage(label: 'Revenue');
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      const _PlaceholderPage(label: 'Profile');
}

class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage({required this.label});
  final String label;
  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: Text(label, style: AppTextStyle(context).mediumTextStyle()),
    ),
  );
}

// ─── Controller ─────────────────────────────────────────────────────────────

class UserBottomNavController extends GetxController {
  final RxInt currentIndex = 0.obs; // default to Home (index 0)

  // ── Nav items — add/remove/reorder freely ──────────────────────────────
  final List<NavItem> useritems = const [
    NavItem(title: 'Home', iconPath: IconPath.home),
    NavItem(title: 'Market', iconPath: IconPath.market),
    NavItem(title: 'Radio', iconPath: IconPath.radio),
    NavItem(title: 'Cart', iconPath: IconPath.cartNew),
    NavItem(title: 'Profile', iconPath: IconPath.profile),
  ];

  // ── Screens — keep in the same order as items ──────────────────────────
  final List<Widget> screens = const [
    UserHomeScreen(),
    ProductsScreen(),
    OrdersScreen(),
    RevenueScreen(),
    ProfileScreen(),
  ];

  // ── Actions ────────────────────────────────────────────────────────────
  void changeIndex(int index) {
    assert(index >= 0 && index < useritems.length, 'Index out of range');
    currentIndex.value = index;
  }

  void goTo(String tabTitle) {
    final idx = useritems.indexWhere(
      (e) => e.title.toLowerCase() == tabTitle.toLowerCase(),
    );
    if (idx != -1) changeIndex(idx);
  }
}
