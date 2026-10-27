import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/widgets/app_bar_user_avatar.dart';
import 'package:flutter/material.dart';

class CategoriesTopBar extends StatelessWidget {
  const CategoriesTopBar({
    super.key,
    required this.deliverTo,
    required this.onBackTap,
    required this.onDeliverToTap,
    required this.onNotificationsTap,
  });

  final String deliverTo;
  final VoidCallback onBackTap;
  final VoidCallback onDeliverToTap;
  final VoidCallback onNotificationsTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 2),
      child: Row(
        children: [
          // Back Button & Brand Title
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: onBackTap,
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(
                      color: AppColors.outlineVariant.withValues(alpha: 0.5),
                    ),
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 15,
                    color: Color(0xFF002419),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'A U R A',
                style: AppTypography.headlineSm.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2.5,
                  color: const Color(0xFF002419),
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),

          // Deliver to pill - Flexible with ellipsis to avoid overflow
          Expanded(
            child: Center(
              child: GestureDetector(
                onTap: onDeliverToTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerHigh.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 13,
                        color: AppColors.secondary,
                      ),
                      const SizedBox(width: 3),
                      Flexible(
                        child: Text(
                          'Deliver to: $deliverTo',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.labelSm.copyWith(
                            color: AppColors.onSurface,
                            fontSize: 10.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.expand_more,
                        size: 13,
                        color: AppColors.outline,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Notification & Profile
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: onNotificationsTap,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const Icon(
                        Icons.notifications_outlined,
                        size: 18,
                        color: AppColors.onSurface,
                      ),
                    ),
                    Positioned(
                      top: 3,
                      right: 3,
                      child: Container(
                        width: 7,
                        height: 7,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.error,
                          border: Border.all(
                            color: Colors.white,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              const AppBarUserAvatar(radius: 16),
            ],
          ),
        ],
      ),
    );
  }
}
