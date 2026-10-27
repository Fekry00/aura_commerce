import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class CategoriesAddressBottomSheet extends StatelessWidget {
  const CategoriesAddressBottomSheet({
    super.key,
    required this.currentAddress,
    required this.onAddressSelected,
  });

  final String currentAddress;
  final ValueChanged<String> onAddressSelected;

  static void show(
    BuildContext context, {
    required String currentAddress,
    required ValueChanged<String> onAddressSelected,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => CategoriesAddressBottomSheet(
        currentAddress: currentAddress,
        onAddressSelected: onAddressSelected,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.outlineVariant.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Select Delivery Residence',
            style: AppTypography.headlineSm.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 16),
          _buildAddressOption(
            title: 'New York, 10001',
            subtitle: '740 Park Avenue, Manhattan Suite 14B',
          ),
          const SizedBox(height: 10),
          _buildAddressOption(
            title: 'Beverly Hills, 90210',
            subtitle: '9641 Sunset Blvd, Beverly Hills Atelier',
          ),
          const SizedBox(height: 10),
          _buildAddressOption(
            title: 'Paris, 75008',
            subtitle: '22 Place Vendôme, Private Salon',
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildAddressOption({
    required String title,
    required String subtitle,
  }) {
    final isSelected = currentAddress == title;
    return GestureDetector(
      onTap: () => onAddressSelected(title),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFE9F0EC)
              : AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF006C49)
                : AppColors.outlineVariant.withValues(alpha: 0.4),
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.location_on,
              color: isSelected
                  ? const Color(0xFF006C49)
                  : AppColors.onSurfaceVariant,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.labelSm.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: AppTypography.bodySm.copyWith(
                      color: AppColors.slateBody,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle_rounded,
                color: Color(0xFF006C49),
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}
