import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/orders/presentation/widgets/tracking_dispatch_item_card.dart';
import 'package:flutter/material.dart';

class TrackingCuratedDispatchItems extends StatelessWidget {
  final VoidCallback? onInspectCertificate;

  const TrackingCuratedDispatchItems({super.key, this.onInspectCertificate});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Curated Dispatch (2)',
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
        const TrackingDispatchItemCard(
          category: 'HAUTE HORLOGERIE',
          title: 'Aethel Chronograph 40...',
          subtitle: 'Brushed Titanium • Serial #AT-092-7489',
          qty: 'Qty: 01',
          price: '\$1,450.00',
          serialTag: 'N°04',
          imageUrl:
              'https://lh3.googleusercontent.com/aida-public/AB6AXuDD0sbnNVvsv33yBAnoqPB20Vs7jx_Bj8lrn6GPRWyjaiVPYFvMjgfhitJOdJa_e3iNRbQl4cxRWwt0yEj0sLuRq-yCgOIxFtwssw9ylmZNFpkGom4eQiQoQxdrnKt94SI5N-N3yNHthLaG9q0PzQWohNcVO_UcaRu7gqz066HwD0YLLELX7PCOtQL2HXflN219MVpetlDdx8hDSQd4XLoHLMIPXCT0rOP_8dMk6s31A7WaQsGiUdo8',
        ),
        const SizedBox(height: AppSpacing.spaceSm),
        const TrackingDispatchItemCard(
          category: 'MAISON LEATHER',
          title: 'Verona Nappa Handbag',
          subtitle: 'Forest Green • Hand-stitched Calfsuede',
          qty: 'Qty: 01',
          price: '\$890.00',
          serialTag: '08',
          imageUrl:
              'https://lh3.googleusercontent.com/aida-public/AB6AXuAC9S5sow3Mq93k0DT7B6_MTu4V_ZluO8KoBzdbylC-FlrceCygBoyXqVaLh6JfBU-pyeiwrmcJuYOUv33Qi-vxd64NW4Bb6qaWPDo5xb06Bsx87XLpj1n7zZ68m9dHzPSkRJZuhYQ9MrISpLwq4IAD3g4T6LcSFG3SLcnzkonYx-jpQBoI_z0j4K6-co3FpCTBnsB9Rkgu4nk89bsIcxRQ2ShVM3j1GIm2s3EwUY-qRLuXXR5OWgzz',
        ),
        const SizedBox(height: AppSpacing.spaceSm + 2),
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
