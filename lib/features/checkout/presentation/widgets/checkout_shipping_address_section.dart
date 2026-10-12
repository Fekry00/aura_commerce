import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:flutter/material.dart';

class CheckoutShippingAddressSection extends StatefulWidget {
  const CheckoutShippingAddressSection({super.key});

  @override
  State<CheckoutShippingAddressSection> createState() =>
      _CheckoutShippingAddressSectionState();
}

class _CheckoutShippingAddressSectionState
    extends State<CheckoutShippingAddressSection> {
  int _selectedIndex = 0;

  static const _addresses = [
    (
      label: 'Home',
      isDefault: true,
      recipient: 'Ahmed Mohamed',
      phone: '+20 100 000 0000',
      address: '123 Main St, Gihan, Mansoura, Dakahlia, Egypt',
    ),
    (
      label: 'Office / Atelier',
      isDefault: false,
      recipient: 'Claire Daniels',
      phone: '+1 (555) 249-8100',
      address: '742 Evergreen St, Penthouse B, Manhattan, NY, United States',
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
                const Icon(Icons.location_on_rounded, size: 20, color: AppColors.primaryContainer),
                const SizedBox(width: AppSpacing.spaceXs + 2),
                Text('Shipping Address', style: AppTypography.headlineSm.copyWith(fontWeight: FontWeight.w700)),
              ],
            ),
            InkWell(
              onTap: () => showCustomSnackBar(context, message: 'Opening new address sheet...', type: SnackBarType.info),
              borderRadius: BorderRadius.circular(AppSpacing.margin),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.secondaryContainer.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(AppSpacing.margin),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.add_rounded, size: 16, color: AppColors.secondary),
                    const SizedBox(width: 2),
                    Text('Add New', style: AppTypography.labelSm.copyWith(color: AppColors.secondary, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.spaceSm + AppSpacing.spaceXs),
        ...List.generate(_addresses.length, (i) {
          final a = _addresses[i];
          final isSelected = _selectedIndex == i;
          return Padding(
            padding: EdgeInsets.only(bottom: i == _addresses.length - 1 ? 0 : AppSpacing.spaceSm + 2),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              isSelected ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
                              size: 18,
                              color: isSelected ? AppColors.primaryContainer : AppColors.outline,
                            ),
                            const SizedBox(width: AppSpacing.spaceSm),
                            Text(a.label, style: AppTypography.bodyMd.copyWith(fontWeight: FontWeight.w700)),
                            if (a.isDefault) ...[
                              const SizedBox(width: AppSpacing.spaceSm),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFBDEDD7),
                                  borderRadius: BorderRadius.circular(AppSpacing.margin),
                                ),
                                child: Text(
                                  'DEFAULT',
                                  style: AppTypography.labelCaps.copyWith(color: const Color(0xFF002116), fontWeight: FontWeight.w800, fontSize: 9.5),
                                ),
                              ),
                            ],
                          ],
                        ),
                        InkWell(
                          onTap: () => showCustomSnackBar(context, message: 'Editing ${a.label}...', type: SnackBarType.info),
                          borderRadius: BorderRadius.circular(6),
                          child: const Icon(Icons.edit_outlined, size: 18, color: AppColors.onSurfaceVariant),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 26, top: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(a.recipient, style: AppTypography.bodyMd.copyWith(fontWeight: FontWeight.w500)),
                              const SizedBox(width: 4),
                              const Text('•', style: TextStyle(color: AppColors.outlineVariant)),
                              const SizedBox(width: 4),
                              Text(a.phone, style: AppTypography.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(a.address, style: AppTypography.bodySm.copyWith(color: AppColors.onSurfaceVariant, height: 1.35)),
                        ],
                      ),
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
