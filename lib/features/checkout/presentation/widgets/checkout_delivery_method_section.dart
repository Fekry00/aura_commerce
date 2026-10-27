import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class CheckoutDeliveryMethodSection extends StatelessWidget {
  const CheckoutDeliveryMethodSection({
    super.key,
    required this.selectedIndex,
    required this.onMethodSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onMethodSelected;

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
                const Icon(
                  Icons.local_shipping_rounded,
                  size: 20,
                  color: Color(0xFF0B3B2C),
                ),
                const SizedBox(width: 8),
                Text(
                  'Delivery Method',
                  style: AppTypography.headlineSm.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            Text(
              'INSURED TRANSIT',
              style: AppTypography.labelCaps.copyWith(
                color: AppColors.secondary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...List.generate(_methods.length, (i) {
          final m = _methods[i];
          final isSelected = selectedIndex == i;
          return Padding(
            padding: EdgeInsets.only(
              bottom: i == _methods.length - 1 ? 0 : 10,
            ),
            child: InkWell(
              onTap: () => onMethodSelected(i),
              borderRadius: BorderRadius.circular(16),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF0B3B2C)
                        : const Color(0xFFE2E8F0),
                    width: isSelected ? 1.5 : 1.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      isSelected
                          ? Icons.radio_button_checked_rounded
                          : Icons.radio_button_off_rounded,
                      size: 18,
                      color: isSelected
                          ? const Color(0xFF0B3B2C)
                          : AppColors.outline,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  m.title,
                                  style: AppTypography.bodyMd.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              if (m.vipPill != null) ...[
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.secondaryContainer,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    m.vipPill!,
                                    style: AppTypography.labelCaps.copyWith(
                                      color: const Color(0xFF002419),
                                      fontWeight: FontWeight.w800,
                                      fontSize: 9.5,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            m.desc,
                            style: AppTypography.bodySm.copyWith(
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.verified_rounded,
                                size: 15,
                                color: AppColors.secondary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                m.eta,
                                style: AppTypography.labelSm.copyWith(
                                  color: AppColors.secondary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          m.price,
                          style: AppTypography.priceCatalog.copyWith(
                            color: AppColors.secondary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        if (m.originalPrice != null)
                          Text(
                            m.originalPrice!,
                            style: AppTypography.bodySm.copyWith(
                              color: AppColors.outline,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        if (m.subPrice != null)
                          Text(
                            m.subPrice!,
                            style: AppTypography.bodySm.copyWith(
                              color: AppColors.onSurfaceVariant,
                              fontSize: 10.5,
                            ),
                          ),
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
