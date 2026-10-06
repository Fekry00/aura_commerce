import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';


class CuratedHighlightsHeader extends StatefulWidget {
  final ValueChanged<int>? onTabChanged;

  const CuratedHighlightsHeader({
    super.key,
    this.onTabChanged,
  });

  @override
  State<CuratedHighlightsHeader> createState() => _CuratedHighlightsHeaderState();
}

class _CuratedHighlightsHeaderState extends State<CuratedHighlightsHeader> {
  int _selectedIndex = 0;

  void _handleTabSelect(int index) {
    if (_selectedIndex == index) return;
    setState(() => _selectedIndex = index);
    widget.onTabChanged?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ICONIC EDITIONS',
          style: AppTypography.labelCaps.copyWith(
            color: AppColors.secondary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Curated Highlights',
              style: AppTypography.headlineSm.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  _buildTab('All', 0),
                  _buildTab('Popular', 1),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTab(String title, int index) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _handleTabSelect(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryContainer : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          title,
          style: AppTypography.labelSm.copyWith(
            color: isSelected ? Colors.white : AppColors.onSurfaceVariant,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}