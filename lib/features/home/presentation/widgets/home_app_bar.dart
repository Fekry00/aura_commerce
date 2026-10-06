import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:flutter/material.dart';


class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
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
          onTap: () {
            showCustomSnackBar(
              context,
              message: 'Address selector coming soon!',
              type: SnackBarType.info,
            );
          },
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
                  'Deliver to: New York...',
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
              onPressed: () {
                showCustomSnackBar(
                  context,
                  message: 'No new notifications right now',
                  type: SnackBarType.info,
                );
              },
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
        GestureDetector(
          onTap: () {
            showCustomSnackBar(
              context,
              message: 'Opening profile...',
              type: SnackBarType.info,
            );
          },
          child: const CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage(
              'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=200',
            ),
          ),
        ),
      ],
    );
  }
}
