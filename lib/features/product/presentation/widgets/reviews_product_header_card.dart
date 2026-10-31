import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/widgets/app_cached_image.dart';
import 'package:aura/features/product/domain/entities/sub_entities/product_item_entity.dart';
import 'package:flutter/material.dart';

class ReviewsProductHeaderCard extends StatelessWidget {
  final ProductItemEntity product;
  final VoidCallback? onWriteReview;

  const ReviewsProductHeaderCard({
    super.key,
    required this.product,
    this.onWriteReview,
  });

  @override
  Widget build(BuildContext context) {
    final title = product.name;
    final price = '${product.minPrice.toStringAsFixed(0)} EGP';
    final imageUrl = product.imageUrl;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.spaceMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE9ECEF)),
      ),
      child: Row(
        children: [
          AppCachedImage(
            imageUrl: imageUrl,
            width: 52,
            height: 52,
            borderRadius: BorderRadius.circular(12),
            fit: BoxFit.cover,
            fallbackIcon: Icons.shopping_bag_outlined,
          ),
          const SizedBox(width: AppSpacing.spaceSm + 2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'VERIFIED PRODUCT',
                      style: AppTypography.labelCaps.copyWith(
                        color: const Color(0xFF1E382B),
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.verified_rounded,
                      color: Color(0xFF1E382B),
                      size: 12,
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  title,
                  style: AppTypography.bodySm.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (price.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    price.endsWith('EGP') ? price : '$price EGP',
                    style: AppTypography.bodySm.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppColors.onSurface,
                    ),
                  ),
                ],
              ],
            ),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E382B),
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: onWriteReview,
            icon: const Icon(Icons.edit_outlined, color: Colors.white, size: 14),
            label: Text(
              'Review',
              style: AppTypography.bodySm.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}