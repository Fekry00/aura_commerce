import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/orders/domain/entities/order_item_entity.dart';
import 'package:aura/features/orders/presentation/widgets/tracking_dispatch_item_card.dart';
import 'package:flutter/material.dart';

class TrackingCuratedDispatchItems extends StatelessWidget {
  final List<OrderItemEntity>? items;
  final VoidCallback? onInspectCertificate;

  const TrackingCuratedDispatchItems({
    super.key,
    this.items,
    this.onInspectCertificate,
  });

  @override
  Widget build(BuildContext context) {
    final dispatchItems = items ?? const [];
    final count = dispatchItems.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Curated Dispatch ($count)',
              style: AppTypography.headlineSm.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.slateHeadline,
              ),
            ),
            Text(
              'Vault Authenticated',
              style: AppTypography.labelCaps.copyWith(
                color: AppColors.secondary,
                fontWeight: FontWeight.w700,
                fontSize: 10,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.spaceSm + 2),
        if (dispatchItems.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              'No items specified for this consignment.',
              style: AppTypography.bodySm.copyWith(color: AppColors.slateBody),
            ),
          )
        else
          ...dispatchItems.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.spaceSm),
              child: TrackingDispatchItemCard(
                category: 'HAUTE CURATION',
                title: item.productName,
                subtitle: item.productSlug ?? 'Verified Vault Allocation',
                qty: 'Qty: ${item.quantity.toString().padLeft(2, '0')}',
                price: '\$${item.price.toStringAsFixed(2)}',
                serialTag: 'N°${item.productId}',
                imageUrl: (item.productThumbnail != null &&
                        item.productThumbnail!.isNotEmpty)
                    ? item.productThumbnail!
                    : 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?q=80&w=300',
              ),
            ),
          ),
        const SizedBox(height: AppSpacing.spaceSm),
        InkWell(
          onTap: onInspectCertificate,
          borderRadius: BorderRadius.circular(AppSpacing.spaceSm),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.spaceMd,
              vertical: AppSpacing.spaceSm + 2,
            ),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(AppSpacing.spaceSm),
              border: Border.all(
                color: AppColors.outlineVariant.withValues(alpha: 0.6),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.verified_outlined,
                  size: 16,
                  color: AppColors.secondary,
                ),
                const SizedBox(width: AppSpacing.spaceSm),
                Expanded(
                  child: Text(
                    'Inspect Digital Certificate of Authenticity & NFT',
                    style: AppTypography.bodySm.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.slateHeadline,
                      fontSize: 11,
                    ),
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  size: 18,
                  color: AppColors.slateBody,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
