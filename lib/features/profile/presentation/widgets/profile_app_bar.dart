import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:flutter/material.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.margin, vertical: AppSpacing.spaceSm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildBrandLogo(),
          _buildAddressCapsule(context),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildNotificationBell(context),
              const SizedBox(width: AppSpacing.spaceSm),
              _buildAvatar(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBrandLogo() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'AURA',
          style: AppTypography.labelCaps.copyWith(fontWeight: FontWeight.w900, letterSpacing: 2.0, color: AppColors.primary),
        ),
        const SizedBox(width: AppSpacing.spaceXs / 2),
        Container(
          width: AppSpacing.spaceXs,
          height: AppSpacing.spaceXs,
          decoration: const BoxDecoration(color: AppColors.mintHighlight, shape: BoxShape.circle),
        ),
      ],
    );
  }

  Widget _buildAddressCapsule(BuildContext context) {
    return InkWell(
      onTap: () => showCustomSnackBar(context, message: 'Selecting delivery address...', type: SnackBarType.info),
      borderRadius: BorderRadius.circular(AppSpacing.margin),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.spaceSm + AppSpacing.spaceXs / 2, vertical: AppSpacing.spaceXs),
        decoration: BoxDecoration(color: AppColors.surfaceContainerLow, borderRadius: BorderRadius.circular(AppSpacing.margin)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.location_on_outlined, size: AppSpacing.spaceMd, color: AppColors.secondary),
            const SizedBox(width: AppSpacing.spaceXs),
            Text(
              'Deliver to: New York...',
              style: AppTypography.bodySm.copyWith(fontWeight: FontWeight.w500, color: AppColors.onSurface, fontSize: 11),
            ),
            const SizedBox(width: AppSpacing.spaceXs / 2),
            const Icon(Icons.keyboard_arrow_down_rounded, size: AppSpacing.spaceMd, color: AppColors.slateBody),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationBell(BuildContext context) {
    return InkWell(
      onTap: () => showCustomSnackBar(context, message: 'Notifications up to date', type: SnackBarType.info),
      borderRadius: BorderRadius.circular(AppSpacing.margin),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const Icon(Icons.notifications_none_rounded, size: AppSpacing.spaceLg, color: AppColors.slateHeadline),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: AppSpacing.spaceSm,
              height: AppSpacing.spaceSm,
              decoration: const BoxDecoration(color: AppColors.error, shape: BoxShape.circle),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(Routes.editProfileView),
      borderRadius: BorderRadius.circular(AppSpacing.margin),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.spaceXs / 2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.outlineVariant, width: 1.5),
        ),
        child: const CircleAvatar(
          radius: AppSpacing.spaceMd - 2,
          backgroundImage: NetworkImage('https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=300'),
        ),
      ),
    );
  }
}
