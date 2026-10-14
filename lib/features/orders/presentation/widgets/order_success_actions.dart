import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class OrderSuccessActions extends StatelessWidget {
  final VoidCallback? onTrackCourier;
  final VoidCallback? onDownloadInvoice;
  final VoidCallback? onContactLiaison;

  const OrderSuccessActions({
    super.key,
    this.onTrackCourier,
    this.onDownloadInvoice,
    this.onContactLiaison,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 52,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onTrackCourier,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryContainer,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Track Courier Dispatch',
                  style: AppTypography.bodyLg.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: AppSpacing.spaceSm),
                const Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.spaceSm + 2),
        SizedBox(
          height: 48,
          width: double.infinity,
          child: OutlinedButton(
            onPressed: onDownloadInvoice,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.outlineVariant),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.file_download_outlined,
                  size: 18,
                  color: AppColors.onSurface,
                ),
                const SizedBox(width: AppSpacing.spaceSm),
                Text(
                  'Download Tax Invoice (PDF)',
                  style: AppTypography.bodyMd.copyWith(
                    color: AppColors.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.spaceMd),
        GestureDetector(
          onTap: onContactLiaison,
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Need immediate assistance?  ',
                  style: AppTypography.bodySm.copyWith(
                    color: AppColors.slateBody,
                  ),
                ),
                TextSpan(
                  text: 'Contact Liaison Marcus Vance ↗',
                  style: AppTypography.bodySm.copyWith(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
