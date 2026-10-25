import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:riddimafrica/core/core.dart';

/// ─────────────────────────────────────────────────────────────────────────────
/// Base Shimmer Wrapper (Facebook / Meta Style)
/// ─────────────────────────────────────────────────────────────────────────────
class AppShimmer extends StatelessWidget {
  final Widget child;
  final Color? baseColor;
  final Color? highlightColor;

  const AppShimmer({
    super.key,
    required this.child,
    this.baseColor,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? AppColors.primaryappbrown,
      highlightColor: highlightColor ?? const Color(0xFF4A2C18),
      period: const Duration(milliseconds: 1500),
      child: child,
    );
  }
}

/// ─────────────────────────────────────────────────────────────────────────────
/// Reusable Placeholder Elements
/// ─────────────────────────────────────────────────────────────────────────────
class ShimmerBox extends StatelessWidget {
  final double? width;
  final double? height;
  final double borderRadius;
  final Color? color;

  const ShimmerBox({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 8.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color ?? AppColors.primaryappbrownsecond,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}

class ShimmerCircle extends StatelessWidget {
  final double size;
  final Color? color;

  const ShimmerCircle({
    super.key,
    required this.size,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color ?? AppColors.primaryappbrownsecond,
      ),
    );
  }
}

/// ─────────────────────────────────────────────────────────────────────────────
/// Product Card Shimmer (Single & Grid)
/// ─────────────────────────────────────────────────────────────────────────────
class ProductCardShimmer extends StatelessWidget {
  const ProductCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryappbrown,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: AppColors.primaryappbrownsecond.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image skeleton
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
              child: Container(
                color: AppColors.primaryappbrownsecond,
                width: double.infinity,
              ),
            ),
          ),
          // Content skeleton
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ShimmerBox(width: double.infinity, height: 12),
                const SizedBox(height: 6),
                const ShimmerBox(width: 80, height: 10),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    ShimmerBox(width: 65, height: 14),
                    ShimmerBox(width: 40, height: 12),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductGridShimmer extends StatelessWidget {
  final int itemCount;

  const ProductGridShimmer({
    super.key,
    this.itemCount = 6,
  });

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.65,
        ),
        itemCount: itemCount,
        itemBuilder: (_, _) => const ProductCardShimmer(),
      ),
    );
  }
}

/// ─────────────────────────────────────────────────────────────────────────────
/// Horizontal Products Shimmer (For Home Screen sections)
/// ─────────────────────────────────────────────────────────────────────────────
class ProductHorizontalShimmer extends StatelessWidget {
  final int itemCount;
  final double height;

  const ProductHorizontalShimmer({
    super.key,
    this.itemCount = 4,
    this.height = 240,
  });

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: SizedBox(
        height: height,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: itemCount,
          separatorBuilder: (_, _) => const SizedBox(width: 14),
          itemBuilder: (_, _) => const SizedBox(
            width: 160,
            child: ProductCardShimmer(),
          ),
        ),
      ),
    );
  }
}

/// ─────────────────────────────────────────────────────────────────────────────
/// Product Detail Screen Shimmer
/// ─────────────────────────────────────────────────────────────────────────────
class ProductDetailShimmer extends StatelessWidget {
  const ProductDetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Image Gallery skeleton
            Container(
              height: 320,
              color: AppColors.primaryappbrownsecond,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title skeleton
                  const ShimmerBox(width: 240, height: 22, borderRadius: 6),
                  const SizedBox(height: 12),
                  // Price skeleton
                  const ShimmerBox(width: 120, height: 26, borderRadius: 6),
                  const SizedBox(height: 14),
                  // Rating & category
                  Row(
                    children: const [
                      ShimmerBox(width: 80, height: 14),
                      SizedBox(width: 16),
                      ShimmerBox(width: 100, height: 14),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Seller Card skeleton
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primaryappbrownsecond,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        const ShimmerCircle(size: 44),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            ShimmerBox(width: 120, height: 14),
                            SizedBox(height: 6),
                            ShimmerBox(width: 80, height: 10),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Description skeleton
                  const ShimmerBox(width: 100, height: 16),
                  const SizedBox(height: 10),
                  const ShimmerBox(width: double.infinity, height: 12),
                  const SizedBox(height: 6),
                  const ShimmerBox(width: double.infinity, height: 12),
                  const SizedBox(height: 6),
                  const ShimmerBox(width: 180, height: 12),
                  const SizedBox(height: 24),
                  // Action buttons skeleton
                  Row(
                    children: const [
                      Expanded(child: ShimmerBox(height: 48, borderRadius: 12)),
                      SizedBox(width: 12),
                      Expanded(child: ShimmerBox(height: 48, borderRadius: 12)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ─────────────────────────────────────────────────────────────────────────────
/// Profile Screen Shimmer
/// ─────────────────────────────────────────────────────────────────────────────
class ProfileScreenShimmer extends StatelessWidget {
  const ProfileScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Avatar
            const Center(child: ShimmerCircle(size: 100)),
            const SizedBox(height: 16),
            // Name
            const ShimmerBox(width: 160, height: 20, borderRadius: 6),
            const SizedBox(height: 8),
            // Username / Email
            const ShimmerBox(width: 120, height: 12),
            const SizedBox(height: 6),
            const ShimmerBox(width: 100, height: 12),
            const SizedBox(height: 24),
            // 3 Stats Boxes
            Row(
              children: const [
                Expanded(child: ShimmerBox(height: 64, borderRadius: 12)),
                SizedBox(width: 12),
                Expanded(child: ShimmerBox(height: 64, borderRadius: 12)),
                SizedBox(width: 12),
                Expanded(child: ShimmerBox(height: 64, borderRadius: 12)),
              ],
            ),
            const SizedBox(height: 30),
            // Menu items
            for (int i = 0; i < 5; i++) ...[
              Container(
                height: 56,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: AppColors.primaryappbrownsecond,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// ─────────────────────────────────────────────────────────────────────────────
/// Order List Shimmer
/// ─────────────────────────────────────────────────────────────────────────────
class OrderListShimmer extends StatelessWidget {
  final int count;

  const OrderListShimmer({super.key, this.count = 4});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        itemCount: count,
        separatorBuilder: (_, _) => const SizedBox(height: 14),
        itemBuilder: (_, _) => Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.primaryappbrown,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              const ShimmerBox(width: 70, height: 70, borderRadius: 10),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    ShimmerBox(width: 140, height: 14),
                    SizedBox(height: 8),
                    ShimmerBox(width: 90, height: 12),
                    SizedBox(height: 8),
                    ShimmerBox(width: 60, height: 12),
                  ],
                ),
              ),
              const ShimmerBox(width: 70, height: 26, borderRadius: 20),
            ],
          ),
        ),
      ),
    );
  }
}

/// ─────────────────────────────────────────────────────────────────────────────
/// Cart List Shimmer
/// ─────────────────────────────────────────────────────────────────────────────
class CartListShimmer extends StatelessWidget {
  final int count;

  const CartListShimmer({super.key, this.count = 3});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        itemCount: count,
        separatorBuilder: (_, _) => const SizedBox(height: 14),
        itemBuilder: (_, _) => Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primaryappbrown,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              const ShimmerBox(width: 80, height: 80, borderRadius: 12),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    ShimmerBox(width: 140, height: 14),
                    SizedBox(height: 6),
                    ShimmerBox(width: 80, height: 12),
                    SizedBox(height: 8),
                    ShimmerBox(width: 65, height: 16),
                  ],
                ),
              ),
              const ShimmerBox(width: 80, height: 32, borderRadius: 20),
            ],
          ),
        ),
      ),
    );
  }
}

/// ─────────────────────────────────────────────────────────────────────────────
/// Home Screen Full Shimmer
/// ─────────────────────────────────────────────────────────────────────────────
class HomeScreenShimmer extends StatelessWidget {
  const HomeScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            // Banner Carousel Shimmer
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                height: 170,
                decoration: BoxDecoration(
                  color: AppColors.primaryappbrownsecond,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Section Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  ShimmerBox(width: 140, height: 18),
                  ShimmerBox(width: 60, height: 14),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Horizontal Products List
            const ProductHorizontalShimmer(itemCount: 3, height: 210),
            const SizedBox(height: 28),
            // Section Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  ShimmerBox(width: 130, height: 18),
                  ShimmerBox(width: 60, height: 14),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Artist Avatars Row
            SizedBox(
              height: 100,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: 5,
                separatorBuilder: (_, _) => const SizedBox(width: 14),
                itemBuilder: (_, _) => Column(
                  children: const [
                    ShimmerCircle(size: 64),
                    SizedBox(height: 8),
                    ShimmerBox(width: 50, height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
