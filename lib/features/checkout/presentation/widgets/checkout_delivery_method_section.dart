import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class CheckoutDeliveryMethodSection extends StatefulWidget {
  const CheckoutDeliveryMethodSection({super.key});

  @override
  State<CheckoutDeliveryMethodSection> createState() =>
      _CheckoutDeliveryMethodSectionState();
}

class _CheckoutDeliveryMethodSectionState
    extends State<CheckoutDeliveryMethodSection> {
  int _selectedIndex = 0;

  static const _methods = [
    (
      title: 'White-Glove Armored Courier',
      vipPill: 'VIP FREE',
      desc: 'Discreet temperature-controlled security van',
      eta: 'Est. 1–2 Business Days • May 16 - 17',
      price: 'Free',
      originalPrice: '\$40.00',
      subPrice: null,
    ),
    (
      title: 'Standard Priority Delivery',
      vipPill: null,
      desc: 'Signature required air transit',
      eta: 'Est. 2–5 Business Days • May 18 - 21',
      price: 'Free',
      originalPrice: null,
      subPrice: '>\$1,000 Tier',
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
            Row(
              children: [
                const Icon(Icons.local_shipping_rounded, size: 20, color: AppColors.primaryContainer),
                const SizedBox(width: AppSpacing.spaceXs + 2),
                Text('Delivery Method', style: AppTypography.headlineSm.copyWith(fontWeight: FontWeight.w700)),
              ],
            ),
            Text(
              'INSURED TRANSIT',
              style: AppTypography.labelCaps.copyWith(color: AppColors.secondary, fontWeight: FontWeight.w800),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.spaceSm + AppSpacing.spaceXs),
        ...List.generate(_methods.length, (i) {
          final m = _methods[i];
          final isSelected = _selectedIndex == i;
          return Padding(
            padding: EdgeInsets.only(bottom: i == _methods.length - 1 ? 0 : AppSpacing.spaceSm + 2),
            child: InkWell(
              onTap: () => setState(() => _selectedIndex = i),
              borderRadius: BorderRadius.circular(AppSpacing.spaceMd),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(AppSpacing.spaceMd),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(AppSpacing.spaceMd),
                  border: Border.all(
                    color: isSelected ? AppColors.primaryContainer : AppColors.outlineVariant.withValues(alpha: 0.4),
                    width: isSelected ? 1.5 : 1.0,
                  ),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 8, offset: const Offset(0, 2)),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      isSelected ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
                      size: 18,
                      color: isSelected ? AppColors.primaryContainer : AppColors.outline,
                    ),
                    const SizedBox(width: AppSpacing.spaceSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(m.title, style: AppTypography.bodyMd.copyWith(fontWeight: FontWeight.w700)),
                              ),
                              if (m.vipPill != null) ...[
                                const SizedBox(width: AppSpacing.spaceSm),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppColors.secondaryContainer,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    m.vipPill!,
                                    style: AppTypography.labelCaps.copyWith(color: AppColors.primary, fontWeight: FontWeight.w800, fontSize: 9.5),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(m.desc, style: AppTypography.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
                          const SizedBox(height: AppSpacing.spaceSm),
                          Row(
                            children: [
                              const Icon(Icons.verified_rounded, size: 15, color: AppColors.secondary),
                              const SizedBox(width: 4),
                              Text(m.eta, style: AppTypography.labelSm.copyWith(color: AppColors.secondary, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(m.price, style: AppTypography.priceCatalog.copyWith(color: AppColors.secondary, fontWeight: FontWeight.w700)),
                        if (m.originalPrice != null)
                          Text(m.originalPrice!, style: AppTypography.bodySm.copyWith(color: AppColors.outline, decoration: TextDecoration.lineThrough)),
                        if (m.subPrice != null)
                          Text(m.subPrice!, style: AppTypography.bodySm.copyWith(color: AppColors.onSurfaceVariant, fontSize: 10.5)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
