import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/orders/presentation/widgets/tracking_map_courier_overlay.dart';
import 'package:aura/features/orders/presentation/widgets/tracking_route_map_painter.dart';
import 'package:flutter/material.dart';

class TrackingLiveMapCard extends StatelessWidget {
  const TrackingLiveMapCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFEDF2EE),
        borderRadius: BorderRadius.circular(AppSpacing.spaceMd),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.6),
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSpacing.spaceMd),
              child: const CustomPaint(painter: TrackingRouteMapPainter()),
            ),
          ),
          Positioned(
            top: AppSpacing.spaceSm + 2,
            left: AppSpacing.spaceSm + 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(AppSpacing.margin),
              ),
              child: Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: AppColors.secondary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'Live GPS Active',
                    style: AppTypography.labelCaps.copyWith(
                      color: AppColors.slateHeadline,
                      fontWeight: FontWeight.w700,
                      fontSize: 9.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: AppSpacing.spaceSm + 2,
            right: AppSpacing.spaceSm + 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primaryContainer,
                borderRadius: BorderRadius.circular(AppSpacing.margin),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.shield_rounded,
                    size: 11,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Armored Transit',
                    style: AppTypography.labelCaps.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 9.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            left: AppSpacing.spaceSm + 2,
            right: AppSpacing.spaceSm + 2,
            bottom: AppSpacing.spaceSm + 2,
            child: TrackingMapCourierOverlay(),
          ),
        ],
      ),
    );
  }
}
