import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class TrackingActionButtons extends StatelessWidget {
  final VoidCallback? onDownloadInvoice;
  final VoidCallback? onConciergeAssist;

  const TrackingActionButtons({
    super.key,
    this.onDownloadInvoice,
    this.onConciergeAssist,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 48,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onDownloadInvoice,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.surfaceContainerHigh,
              elevation: 0,
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
                  color: AppColors.slateHeadline,
                ),
                const SizedBox(width: AppSpacing.spaceSm),
                Text(
                  'Download Digital Tax Invoice (PDF)',
                  style: AppTypography.bodyMd.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.slateHeadline,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.spaceSm + 2),
        SizedBox(
          height: 52,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onConciergeAssist,
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
                const Icon(
                  Icons.support_agent_rounded,
                  color: Colors.white,
                  size: 18,
                ),
                const SizedBox(width: AppSpacing.spaceSm),
                Text(
                  'Need Concierge Assistance?',
                  style: AppTypography.bodyLg.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
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
