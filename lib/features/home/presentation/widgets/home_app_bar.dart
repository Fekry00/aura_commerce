import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/widgets/app_bar_user_avatar.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  final String? deliveryText;
  final VoidCallback? onLocationTap;
  final VoidCallback? onNotificationsTap;

  const HomeAppBar({
    super.key,
    this.deliveryText,
    this.onLocationTap,
    this.onNotificationsTap,
  });

  @override
  Widget build(BuildContext context) {
    final displayText = deliveryText ?? 'Manage delivery';

    return Row(
      children: [
        Text(
          'AURA',
          style: AppTypography.headlineSm.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: 2.0,
            color: AppColors.primaryContainer,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: onLocationTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 16,
                  color: AppColors.primaryContainer,
                ),
                const SizedBox(width: 4),
                Text(
                  'Deliver: $displayText',
                  style: AppTypography.bodySm.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  size: 16,
                  color: AppColors.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
        const Spacer(),
        Stack(
          children: [
            IconButton(
              icon: const Icon(
                Icons.notifications_none_rounded,
                color: AppColors.onSurface,
              ),
              onPressed: onNotificationsTap,
            ),
            Positioned(
              right: 12,
              top: 12,
              child: Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: AppColors.error,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
        const AppBarUserAvatar(radius: 18),
      ],
    );
  }
}
