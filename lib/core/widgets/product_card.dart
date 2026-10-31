import 'dart:async';
import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/widgets/shimmer/app_shimmer.dart';
import 'package:aura/core/widgets/app_cached_image.dart';
import 'package:flutter/material.dart';
import 'custom_badge.dart';

class ProductCard extends StatefulWidget {
  final String title;
  final String price;
  final String imageUrl;
  final double rating;
  final int reviewsCount;
  final String? badgeText;
  final bool isFavorite;
  final VoidCallback? onFavoriteTap;
  final VoidCallback? onAddToCart;
  final VoidCallback? onTap;
  final bool isLoading;
  final bool isFavoriteLoading;
  final bool isCartLoading;

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.reviewsCount,
    this.badgeText,
    this.isFavorite = false,
    this.onFavoriteTap,
    this.onAddToCart,
    this.onTap,
    this.isLoading = false,
    this.isFavoriteLoading = false,
    this.isCartLoading = false,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _localFavoriteShimmer = false;
  bool _localCartShimmer = false;
  Timer? _favTimer;
  Timer? _cartTimer;

  @override
  void dispose() {
    _favTimer?.cancel();
    _cartTimer?.cancel();
    super.dispose();
  }

  void _handleFavoriteTap() {
    if (widget.onFavoriteTap == null) return;
    setState(() => _localFavoriteShimmer = true);
    _favTimer?.cancel();
    _favTimer = Timer(const Duration(milliseconds: 700), () {
      if (mounted) setState(() => _localFavoriteShimmer = false);
    });
    widget.onFavoriteTap!();
  }

  void _handleAddToCart() {
    if (widget.onAddToCart == null) return;
    setState(() => _localCartShimmer = true);
    _cartTimer?.cancel();
    _cartTimer = Timer(const Duration(milliseconds: 700), () {
      if (mounted) setState(() => _localCartShimmer = false);
    });
    widget.onAddToCart!();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.outlineVariant, width: 0.8),
        ),
        child: AppShimmer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    ShimmerBox(width: 80, height: 12, borderRadius: 4),
                    SizedBox(height: 6),
                    ShimmerBox(width: double.infinity, height: 14, borderRadius: 4),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ShimmerBox(width: 60, height: 16, borderRadius: 4),
                        ShimmerBox.circular(size: 28),
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

    final showFavShimmer = widget.isFavoriteLoading || _localFavoriteShimmer;
    final showCartShimmer = widget.isCartLoading || _localCartShimmer;

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.outlineVariant, width: 0.8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    child: AppCachedImage(
                      imageUrl: widget.imageUrl,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  if (widget.badgeText != null)
                    Positioned(
                      top: 10,
                      left: 10,
                      child: CustomBadge(text: widget.badgeText!),
                    ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: _handleFavoriteTap,
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.85),
                          shape: BoxShape.circle,
                        ),
                        child: showFavShimmer
                            ? const AppShimmer(
                                child: ShimmerBox.circular(size: 32),
                              )
                            : Icon(
                                widget.isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border_rounded,
                                size: 16,
                                color: widget.isFavorite
                                    ? AppColors.error
                                    : AppColors.onSurface,
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Details
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, size: 14, color: AppColors.secondary),
                      const SizedBox(width: 3),
                      Text(
                        '${widget.rating}',
                        style: AppTypography.bodySm.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        '(${widget.reviewsCount})',
                        style: AppTypography.bodySm.copyWith(
                          color: AppColors.onSurfaceVariant,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.headlineSm.copyWith(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.price,
                        style: AppTypography.priceCatalog.copyWith(
                          color: AppColors.onSurface,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      GestureDetector(
                        onTap: _handleAddToCart,
                        child: showCartShimmer
                            ? Container(
                                width: 30,
                                height: 30,
                                decoration: const BoxDecoration(
                                  color: AppColors.primaryContainer,
                                  shape: BoxShape.circle,
                                ),
                                child: const AppShimmer(
                                  child: ShimmerBox.circular(size: 30),
                                ),
                              )
                            : Container(
                                width: 30,
                                height: 30,
                                decoration: const BoxDecoration(
                                  color: AppColors.primaryContainer,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                      ),
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