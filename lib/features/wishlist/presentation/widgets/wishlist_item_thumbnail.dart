import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/widgets/app_cached_image.dart';
import 'package:flutter/material.dart';

class WishlistItemThumbnail extends StatelessWidget {
  final String imageUrl;
  final String? badge;

  const WishlistItemThumbnail({
    super.key,
    required this.imageUrl,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 108,
          height: 126,
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(AppSpacing.spaceSm),
          ),
          child: AppCachedImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            borderRadius: BorderRadius.circular(AppSpacing.spaceSm),
          ),
        ),
        if (badge != null)
          Positioned(
            top: AppSpacing.spaceSm - 2,
            left: AppSpacing.spaceSm - 2,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.spaceXs + 2,
                vertical: AppSpacing.spaceXs / 2,
              ),
              decoration: BoxDecoration(
                color: badge!.startsWith('-')
                    ? AppColors.secondaryContainer
                    : AppColors.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(AppSpacing.spaceLg),
              ),
              child: Text(
                badge!,
                style: AppTypography.labelCaps.copyWith(
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  color: badge!.startsWith('-')
                      ? AppColors.primary
                      : AppColors.onSurface,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
