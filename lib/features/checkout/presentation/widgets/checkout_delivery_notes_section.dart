import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class CheckoutDeliveryNotesSection extends StatefulWidget {
  const CheckoutDeliveryNotesSection({super.key});

  @override
  State<CheckoutDeliveryNotesSection> createState() =>
      _CheckoutDeliveryNotesSectionState();
}

class _CheckoutDeliveryNotesSectionState
    extends State<CheckoutDeliveryNotesSection> {
  final TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.notes_rounded,
                  size: AppSpacing.spaceMd + 2,
                  color: AppColors.primaryContainer,
                ),
                const SizedBox(width: AppSpacing.spaceXs + 2),
                Text(
                  'Delivery Notes & Access',
                  style: AppTypography.headlineSm.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.onSurface,
                  ),
                ),
              ],
            ),
            Text(
              'Optional',
              style: AppTypography.bodySm.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.spaceSm),
        Container(
          padding: const EdgeInsets.all(AppSpacing.spaceSm + AppSpacing.spaceXs),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(AppSpacing.spaceSm + AppSpacing.spaceXs),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: AppSpacing.spaceSm,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: _notesController,
            maxLines: 2,
            style: AppTypography.bodyMd.copyWith(
              color: AppColors.onSurface,
            ),
            decoration: InputDecoration(
              hintText:
                  'e.g. Leave with private elevator concierge, call upon arrival...',
              hintStyle: AppTypography.bodyMd.copyWith(
                color: AppColors.outline,
                fontSize: 13,
              ),
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }
}
