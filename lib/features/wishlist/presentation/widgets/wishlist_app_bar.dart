import 'package:aura/core/routing/main_tab_controller.dart';
import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class WishlistAppBar extends StatelessWidget implements PreferredSizeWidget {
  const WishlistAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.margin,
          vertical: AppSpacing.spaceXs,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [_buildBrand(), const SizedBox(width: AppSpacing.spaceSm), Flexible(child: _buildDeliveryChip()), const SizedBox(width: AppSpacing.spaceSm), _buildActions()],
        ),
      ),
    );
  }

  Widget _buildBrand() => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'AURA',
            style: AppTypography.headlineSm.copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: AppSpacing.spaceXs / 2),
          Container(
            width: AppSpacing.spaceSm - 2,
            height: AppSpacing.spaceSm - 2,
            decoration: const BoxDecoration(color: AppColors.mintHighlight, shape: BoxShape.circle),
          ),
        ],
      );

  Widget _buildDeliveryChip() => Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.spaceSm, vertical: AppSpacing.spaceXs),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(AppSpacing.spaceLg),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.location_on, size: AppSpacing.spaceMd, color: AppColors.secondary),
            const SizedBox(width: AppSpacing.spaceXs / 2),
            Flexible(
              child: Text(
                'Deliver to: New York, 10001',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.labelSm.copyWith(color: AppColors.onSurface, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(width: AppSpacing.spaceXs / 2),
            const Icon(Icons.expand_more, size: AppSpacing.spaceMd, color: AppColors.outline),
          ],
        ),
      );

  Widget _buildActions() => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Badge(
            backgroundColor: AppColors.error,
            smallSize: AppSpacing.spaceSm,
            child: Icon(Icons.notifications_none_rounded, size: AppSpacing.spaceLg, color: AppColors.onSurface),
          ),
          const SizedBox(width: AppSpacing.spaceSm),
          GestureDetector(
            onTap: () => MainTabController.switchTab(3),
            child: const CircleAvatar(
              radius: AppSpacing.spaceMd - 2,
              backgroundImage: NetworkImage(
                'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=300',
              ),
            ),
          ),
        ],
      );
}
