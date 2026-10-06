import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:flutter/material.dart';


class ProductVariantsSelector extends StatefulWidget {
  const ProductVariantsSelector({super.key});

  @override
  State<ProductVariantsSelector> createState() => _ProductVariantsSelectorState();
}

class _ProductVariantsSelectorState extends State<ProductVariantsSelector> {
  int _selectedColorIndex = 0;
  int _selectedSizeIndex = 1;

  final List<Color> _colors = const [
    Color(0xFF333333),
    Color(0xFFD6D6D6),
    Color(0xFFC5A07C),
  ];

  final List<String> _sizes = const ['38mm', '40mm', '42mm'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CASE & FINISHES',
          style: AppTypography.labelCaps.copyWith(color: AppColors.slateBody),
        ),
        const SizedBox(height: AppSpacing.spaceSm),
        Row(
          children: List.generate(_colors.length, (index) {
            final isSelected = _selectedColorIndex == index;
            return GestureDetector(
              onTap: () => setState(() => _selectedColorIndex = index),
              child: Container(
                margin: const EdgeInsets.only(right: AppSpacing.spaceSm + AppSpacing.spaceXs),
                padding: const EdgeInsets.all(AppSpacing.spaceXs - 1),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? AppColors.primaryContainer : Colors.transparent,
                    width: 1.5,
                  ),
                ),
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: _colors[index],
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: AppSpacing.margin),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'CASE DIMENSION',
              style: AppTypography.labelCaps.copyWith(color: AppColors.slateBody),
            ),
            GestureDetector(
              onTap: () {
                showCustomSnackBar(
                  context,
                  message: 'Opening Wrist Sizing Guide...',
                  type: SnackBarType.info,
                );
              },
              child: Row(
                children: [
                  const Icon(Icons.straighten_rounded, size: 14, color: AppColors.slateBody),
                  const SizedBox(width: AppSpacing.spaceXs),
                  Text(
                    'Wrist Sizing Guide',
                    style: AppTypography.labelSm.copyWith(
                      color: AppColors.slateBody,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.spaceSm),
        Row(
          children: List.generate(_sizes.length, (index) {
            final isSelected = _selectedSizeIndex == index;
            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _selectedSizeIndex = index),
                child: Container(
                  margin: EdgeInsets.only(
                    right: index == _sizes.length - 1 ? 0 : AppSpacing.spaceSm,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.spaceSm + AppSpacing.spaceXs),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primaryContainer : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? AppColors.primaryContainer : AppColors.outlineVariant,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    isSelected ? '${_sizes[index]} • Active' : _sizes[index],
                    style: AppTypography.bodySm.copyWith(
                      color: isSelected ? Colors.white : AppColors.onSurface,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}