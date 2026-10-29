import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class OrderReceiptActionsCard extends StatelessWidget {
  final VoidCallback onViewAllOrders;
  final VoidCallback onReturnHome;
  final VoidCallback? onTrackOrder;

  const OrderReceiptActionsCard({
    super.key,
    required this.onViewAllOrders,
    required this.onReturnHome,
    this.onTrackOrder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (onTrackOrder != null) ...[
          SizedBox(
            width: double.infinity,
            height: AppSpacing.space2Xl,
            child: ElevatedButton.icon(
              onPressed: onTrackOrder,
              icon: const Icon(Icons.local_shipping_outlined, size: 18),
              label: Text(
                'Track Courier Dispatch',
                style: AppTypography.bodyMd.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0B3B2C),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.space12),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.spaceSm),
        ],
        SizedBox(
          width: double.infinity,
          height: AppSpacing.space2Xl,
          child: ElevatedButton(
            onPressed: onViewAllOrders,
            style: ElevatedButton.styleFrom(
              backgroundColor: onTrackOrder != null
                  ? Colors.white
                  : const Color(0xFF0B3B2C),
              foregroundColor: onTrackOrder != null
                  ? const Color(0xFF0B3B2C)
                  : Colors.white,
              side: onTrackOrder != null
                  ? const BorderSide(color: Color(0xFF0B3B2C))
                  : null,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSpacing.space12),
              ),
            ),
            child: Text(
              'View All My Orders',
              style: AppTypography.bodyMd.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.spaceSm),
        SizedBox(
          width: double.infinity,
          height: AppSpacing.space2Xl,
          child: OutlinedButton(
            onPressed: onReturnHome,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFF0B3B2C)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSpacing.space12),
              ),
            ),
            child: Text(
              'Return to Home',
              style: AppTypography.bodyMd.copyWith(
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0B3B2C),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
