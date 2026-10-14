import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class TrackingNftCertificateSheet extends StatelessWidget {
  const TrackingNftCertificateSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surfaceContainerLowest,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => const TrackingNftCertificateSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.margin,
        AppSpacing.spaceSm,
        AppSpacing.margin,
        AppSpacing.spaceXl,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.outlineVariant,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: AppSpacing.spaceMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.verified_outlined,
                size: 20,
                color: AppColors.secondary,
              ),
              const SizedBox(width: AppSpacing.spaceSm),
              Text(
                'Digital Authenticity Certificate',
                style: AppTypography.headlineSm.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.spaceSm),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.secondaryContainer.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(AppSpacing.margin),
            ),
            child: Text(
              'CRYPTOGRAPHIC NFT PROVENANCE • IMMUTABLE',
              style: AppTypography.labelCaps.copyWith(
                color: AppColors.secondary,
                fontWeight: FontWeight.w800,
                fontSize: 9.5,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.spaceMd),
          _infoRow('Asset Name', 'Aethel Chronograph 40mm'),
          const SizedBox(height: AppSpacing.spaceSm),
          _infoRow('Serial Number', '#AT-092-7489'),
          const SizedBox(height: AppSpacing.spaceSm),
          _infoRow('Ledger Contract', '0x9842...NYE7'),
          const SizedBox(height: AppSpacing.spaceSm),
          _infoRow('Vault Custodian', 'Aura Manhattan Atelier Reserve'),
          const SizedBox(height: AppSpacing.spaceLg),
          SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryContainer,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: Text(
                'Close Certificate',
                style: AppTypography.bodyMd.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTypography.bodySm.copyWith(color: AppColors.slateBody),
        ),
        Text(
          value,
          style: AppTypography.bodySm.copyWith(
            color: AppColors.slateHeadline,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
