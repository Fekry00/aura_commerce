import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/orders/presentation/widgets/order_insured_transit_badge.dart';
import 'package:aura/features/orders/presentation/widgets/order_manifest_item_tile.dart';
import 'package:flutter/material.dart';

class OrderVaultManifestSection extends StatelessWidget {
  const OrderVaultManifestSection({super.key});

  static const _items = [
    (
      name: 'Aethel Minimalist ...',
      subtitle: '40mm – Brushed Titanium',
      quantity: 1,
      price: '\$1,450.00',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDD0sbnNVvsv33yBAnoqPB20Vs7jx_Bj8lrn6GPRWyjaiVPYFvMjgfhitJOdJa_e3iNRbQl4cxRWwt0yEj0sLuRq-yCgOIxFtwssw9ylmZNFpkGom4eQiQoQxdrnKt94SI5N-N3yNHthLaG9q0PzQWohNcVO_UcaRu7gqz066HwD0YLLELX7PCOtQL2HXflN219MVpetlDdx8hDSQd4XLoHLMIPXCT0rOP_8dMk6s31A7WaQsGiUdo8',
    ),
    (
      name: 'Verona Nappa Hand...',
      subtitle: 'Structured – Forest Green',
      quantity: 1,
      price: '\$890.00',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAC9S5sow3Mq93k0DT7B6_MTu4V_ZluO8KoBzdbylC-FlrceCygBoyXqVaLh6JfBU-pyeiwrmcJuYOUv33Qi-vxd64NW4Bb6qaWPDo5xb06Bsx87XLpj1n7zZ68m9dHzPSkRJZuhYQ9MrISpLwq4IAD3g4T6LcSFG3SLcnzkonYx-jpQBoI_z0j4K6-co3FpCTBnsB9Rkgu4nk89bsIcxRQ2ShVM3j1GIm2s3EwUY-qRLuXXR5OWgzz',
    ),
    (
      name: 'Oud & Bergamot Ext...',
      subtitle: 'Flacon – 100ml Pure Essence',
      quantity: 1,
      price: '\$320.00',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAqtKu1r4CebpmbxvF1DkyXyGNKfTabhgzCOJg8lk4E7dL1IS8X6mFcEZU1leREKXX0yqU6Ub3Bsc8ZosCVRhIHPL9yltAz9ddZn00ISNYsCflqb45H-LFn728wZD5bsTXf-DGCA5jqZqVTsJgq7psnSRBCbl9F-tW6hNC5j0j4Mx4gPaI9NmjQCBkMX3nuNndZnGV2j0UwPvsXHkwOcG9Pr5ox-5OxNqyrK4m9jirzKXKfGXKmaNvG',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'VAULT MANIFEST (03 ITEMS)',
              style: AppTypography.labelCaps.copyWith(
                color: AppColors.slateBody,
                fontSize: 10,
                letterSpacing: 0.9,
                fontWeight: FontWeight.w700,
              ),
            ),
            const OrderInsuredTransitBadge(),
          ],
        ),
        const SizedBox(height: AppSpacing.spaceSm + 2),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(AppSpacing.spaceMd),
            border: Border.all(
              color: AppColors.outlineVariant.withValues(alpha: 0.5),
            ),
          ),
          child: Column(
            children: List.generate(_items.length, (i) {
              final item = _items[i];
              return Column(
                children: [
                  OrderManifestItemTile(
                    name: item.name,
                    subtitle: item.subtitle,
                    quantity: item.quantity,
                    price: item.price,
                    imageUrl: item.imageUrl,
                  ),
                  if (i < _items.length - 1)
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: AppColors.outlineVariant.withValues(alpha: 0.4),
                      indent: AppSpacing.spaceMd,
                      endIndent: AppSpacing.spaceMd,
                    ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}
