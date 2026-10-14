import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class OrderManifestItemTile extends StatelessWidget {
  final String name;
  final String subtitle;
  final int quantity;
  final String price;
  final String imageUrl;

  const OrderManifestItemTile({
    super.key,
    required this.name,
    required this.subtitle,
    required this.quantity,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.spaceMd,
        vertical: AppSpacing.spaceSm + 2,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.spaceSm),
            child: SizedBox(
              width: 54,
              height: 54,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: AppColors.surfaceContainerLow,
                        child: const Icon(
                          Icons.inventory_2_outlined,
                          size: 24,
                          color: AppColors.slateBody,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 3,
                    bottom: 3,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 1.5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'x$quantity',
                        style: AppTypography.labelCaps.copyWith(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.spaceMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.bodyMd.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.slateHeadline,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.bodySm.copyWith(
                    color: AppColors.slateBody,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.spaceSm),
          Text(
            price,
            style: AppTypography.bodyLg.copyWith(
              color: AppColors.slateHeadline,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
