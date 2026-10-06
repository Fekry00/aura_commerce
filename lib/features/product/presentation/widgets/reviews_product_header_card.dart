import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:flutter/material.dart';


class ReviewsProductHeaderCard extends StatelessWidget {
  final Map<String, dynamic> product;

  const ReviewsProductHeaderCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.spaceMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE9ECEF)),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                product['image'] ?? 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?q=80&w=200',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.watch_outlined, color: AppColors.slateBody),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.spaceSm + 2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'ATELIER FORMULATION',
                      style: AppTypography.labelCaps.copyWith(
                        color: const Color(0xFF1E382B),
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.verified_rounded, color: Color(0xFF1E382B), size: 12),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  product['title'] ?? 'Aethel Minimalist Chronograph',
                  style: AppTypography.bodySm.copyWith(fontWeight: FontWeight.w700),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  product['price'] ?? '\$1,450.00',
                  style: AppTypography.bodySm.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppColors.onSurface,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E382B),
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            onPressed: () {
              showCustomSnackBar(
                context,
                message: 'Opening review submission modal...',
                type: SnackBarType.info,
              );
            },
            icon: const Icon(Icons.edit_outlined, color: Colors.white, size: 14),
            label: Text(
              'Review',
              style: AppTypography.bodySm.copyWith(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}