import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class ProductStickyBottomBar extends StatelessWidget {
  final int quantity;
  final String formattedTotalPrice;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onAddToBag;

  const ProductStickyBottomBar({
    super.key,
    required this.quantity,
    required this.formattedTotalPrice,
    required this.onIncrement,
    required this.onDecrement,
    required this.onAddToBag,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.spaceMd,
        AppSpacing.space12,
        AppSpacing.spaceMd,
        AppSpacing.spaceMd,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Row 1: Total Price & Quantity Stepper
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Text(
                            'TOTAL PAYABLE',
                            style: AppTypography.labelCaps.copyWith(
                              color: AppColors.slateBody,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.spaceSm),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.spaceXs,
                              vertical: AppSpacing.space2Xs,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8F5E9),
                              borderRadius:
                                  BorderRadius.circular(AppSpacing.spaceXs),
                            ),
                            child: Text(
                              'FREE SHIPPING',
                              style: AppTypography.labelCaps.copyWith(
                                fontSize: 9,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF2E7D32),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.space2Xs),
                      FittedBox(
                        alignment: Alignment.centerLeft,
                        fit: BoxFit.scaleDown,
                        child: Text(
                          '$formattedTotalPrice EGP',
                          style: AppTypography.headlineMd.copyWith(
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF0B3B2C),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.space12),
                // Stepper Container
                Container(
                  height: 38,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(AppSpacing.margin),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(AppSpacing.margin),
                          ),
                          onTap: onDecrement,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSpacing.spaceSm,
                              vertical: AppSpacing.spaceSm,
                            ),
                            child: Icon(
                              Icons.remove,
                              size: 16,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.spaceSm,
                        ),
                        child: Text(
                          '$quantity',
                          style: AppTypography.bodyMd.copyWith(
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: const BorderRadius.horizontal(
                            right: Radius.circular(AppSpacing.margin),
                          ),
                          onTap: onIncrement,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSpacing.spaceSm,
                              vertical: AppSpacing.spaceSm,
                            ),
                            child: Icon(
                              Icons.add,
                              size: 16,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.spaceSm),
            // Row 2: Full Width Add to Bag Button
            SizedBox(
              width: double.infinity,
              height: AppSpacing.space2Xl,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0B3B2C),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.spaceMd),
                  ),
                  elevation: 2,
                ),
                onPressed: onAddToBag,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.white,
                      size: AppSpacing.margin,
                    ),
                    const SizedBox(width: AppSpacing.spaceSm),
                    Text(
                      'Add to Bag',
                      style: AppTypography.bodyLg.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.spaceSm),
                    Text(
                      '•  $formattedTotalPrice EGP',
                      style: AppTypography.bodySm.copyWith(
                        color: const Color(0xFF86EFAC),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
