import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class HomeServerErrorBanner extends StatelessWidget {
  final VoidCallback onRetry;
  final String message;

  const HomeServerErrorBanner({
    super.key,
    required this.onRetry,
    this.message = 'Unable to connect to atelier server.',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.spaceMd, vertical: AppSpacing.space12),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppSpacing.spaceMd),
        border: Border.all(color: Colors.red.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.cloud_off_outlined, color: Colors.red, size: 20),
          const SizedBox(width: AppSpacing.space12),
          Expanded(
            child: Text(
              message,
              style: AppTypography.bodySm.copyWith(color: Colors.black87),
            ),
          ),
          TextButton(
            onPressed: onRetry,
            style: TextButton.styleFrom(
              visualDensity: VisualDensity.compact,
              foregroundColor: const Color(0xFF1E382B),
            ),
            child: Text(
              'Retry',
              style: AppTypography.labelCaps.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
