import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:flutter/material.dart';

class ProductStickyBottomBar extends StatefulWidget {
  final double basePrice;

  const ProductStickyBottomBar({super.key, this.basePrice = 1450.00});

  @override
  State<ProductStickyBottomBar> createState() => _ProductStickyBottomBarState();
}

class _ProductStickyBottomBarState extends State<ProductStickyBottomBar> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final totalPrice = (widget.basePrice * _quantity).toStringAsFixed(2);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TOTAL',
                  style: AppTypography.labelCaps.copyWith(
                    color: AppColors.slateBody,
                    fontSize: 9,
                  ),
                ),
                Text(
                  '\$$totalPrice',
                  style: AppTypography.headlineSm.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
                Text(
                  'Free Insured Air',
                  style: AppTypography.bodySm.copyWith(
                    color: const Color(0xFF2E7D32),
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 14),

            Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.outlineVariant),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove, size: 14),
                    onPressed: () {
                      if (_quantity > 1) setState(() => _quantity--);
                    },
                  ),
                  Text(
                    '$_quantity',
                    style: AppTypography.bodySm.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, size: 14),
                    onPressed: () => setState(() => _quantity++),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),

            Expanded(
              child: SizedBox(
                height: 44,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E382B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    showCustomSnackBar(
                      context,
                      message: 'Added $_quantity item(s) to Bag!',
                      type: SnackBarType.success,
                    );
                  },
                  icon: const Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.white,
                    size: 18,
                  ),
                  label: Text(
                    'Add to Bag',
                    style: AppTypography.bodySm.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
