import 'package:aura/core/routing/main_tab_controller.dart';
import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/widgets/app_cached_image.dart';
import 'package:flutter/material.dart';

class AtelierArchiveBanner extends StatelessWidget {
  final VoidCallback? onTap;

  const AtelierArchiveBanner({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => MainTabController.switchTab(1),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.grey.withValues(alpha: 0.2),
            width: 0.8,
          ),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: const AppCachedImage(
                imageUrl:
                    'https://images.unsplash.com/photo-1581092160607-ee22621dd758?q=80&w=200',
                width: 54,
                height: 54,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ATELIER ARCHIVE',
                    style: AppTypography.labelCaps.copyWith(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w700,
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'The Art of Pure Precision',
                    style: AppTypography.bodyLg.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    'Meet the master artisans behind Aura...',
                    style: AppTypography.bodySm.copyWith(
                      color: AppColors.slateBody,
                      fontSize: 11,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: Color(0xFFF1F3F5),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 12,
                color: AppColors.slateHeadline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}