import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/widgets/app_cached_image.dart';
import 'package:flutter/material.dart';

class ProductImageSection extends StatelessWidget {
  final String imageUrl;
  final double rating;
  final int reviews;
  final int activeDot;
  final ValueChanged<int>? onDotSelected;

  const ProductImageSection({
    super.key,
    required this.imageUrl,
    this.rating = 4.9,
    this.reviews = 128,
    this.activeDot = 0,
    this.onDotSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF7F8F9),
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: 1.0,
            child: AppCachedImage(
              imageUrl: imageUrl,
              fit: BoxFit.contain,
              fallbackIcon: Icons.inventory_2_outlined,
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFF1E382B),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.verified_outlined,
                    color: Colors.white,
                    size: 12,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'AUTHENTIC ITEM',
                    style: AppTypography.labelCaps.copyWith(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    '$rating ($reviews)',
                    style: AppTypography.labelSm.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                final isSelected = activeDot == index;
                return GestureDetector(
                  onTap: () => onDotSelected?.call(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: isSelected ? 18 : 6,
                    height: 5,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primaryContainer
                          : Colors.black26,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
