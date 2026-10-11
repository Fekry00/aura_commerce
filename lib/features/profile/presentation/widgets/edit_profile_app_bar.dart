import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:flutter/material.dart';

class EditProfileAppBar extends StatelessWidget {
  final String avatarUrl;

  const EditProfileAppBar({
    super.key,
    this.avatarUrl = 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=300',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.margin,
        vertical: AppSpacing.spaceSm,
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () => Navigator.of(context).maybePop(),
            borderRadius: BorderRadius.circular(AppSpacing.margin),
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.spaceSm),
              decoration: const BoxDecoration(
                color: AppColors.surfaceContainerLowest,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: AppSpacing.spaceMd,
                color: AppColors.slateHeadline,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.spaceSm),
          Expanded(
            child: Text(
              'Edit Profile & Account Information',
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.headlineSm.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.slateHeadline,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.spaceSm),
          InkWell(
            onTap: () => showCustomSnackBar(context, message: 'Current Active Patron: Ahmed Mohamed'),
            borderRadius: BorderRadius.circular(AppSpacing.margin),
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.spaceXs / 2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.outlineVariant, width: 1.0),
              ),
              child: CircleAvatar(
                radius: AppSpacing.spaceMd - 4,
                backgroundImage: NetworkImage(avatarUrl),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
