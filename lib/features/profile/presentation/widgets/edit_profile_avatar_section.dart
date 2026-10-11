import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:flutter/material.dart';

class EditProfileAvatarSection extends StatelessWidget {
  final String userName, patronDetails, avatarUrl;
  final VoidCallback? onChangePhoto, onRemovePhoto;

  const EditProfileAvatarSection({
    super.key,
    this.userName = 'Ahmed Mohamed',
    this.patronDetails = 'Client Privé • Patron since Aug 2026',
    this.avatarUrl =
        'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=300',
    this.onChangePhoto,
    this.onRemovePhoto,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.margin),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppSpacing.margin),
        border: Border.all(color: AppColors.outlineVariant, width: 1.0),
      ),
      child: Column(
        children: [
          _buildAvatarWithCamera(context),
          const SizedBox(height: AppSpacing.spaceSm),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                userName,
                style: AppTypography.headlineSm.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: AppSpacing.spaceXs),
              const Icon(
                Icons.verified,
                size: AppSpacing.spaceMd,
                color: AppColors.secondary,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.spaceXs / 2),
          Text(
            patronDetails.toUpperCase(),
            style: AppTypography.labelCaps.copyWith(
              color: AppColors.slateBody,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: AppSpacing.spaceMd),
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildAvatarWithCamera(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.spaceXs),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                AppColors.primary,
                AppColors.secondary,
                AppColors.secondaryContainer,
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: CircleAvatar(
            radius: AppSpacing.spaceXl + AppSpacing.spaceSm,
            backgroundImage: NetworkImage(avatarUrl),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: InkWell(
            onTap:
                onChangePhoto ??
                () => showCustomSnackBar(
                  context,
                  message: 'Opening camera & photo gallery...',
                ),
            borderRadius: BorderRadius.circular(AppSpacing.margin),
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.spaceSm),
              decoration: const BoxDecoration(
                color: AppColors.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.photo_camera,
                size: AppSpacing.spaceMd,
                color: AppColors.secondaryContainer,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: InkWell(
            onTap:
                onChangePhoto ??
                () => showCustomSnackBar(
                  context,
                  message: 'Flacon portrait updated • POST /profile/avatar',
                ),
            borderRadius: BorderRadius.circular(AppSpacing.margin),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.spaceSm),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainer,
                borderRadius: BorderRadius.circular(AppSpacing.margin),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.cloud_upload_outlined,
                    size: AppSpacing.spaceMd,
                    color: AppColors.secondary,
                  ),
                  const SizedBox(width: AppSpacing.spaceXs),
                  Text(
                    'Change Photo',
                    style: AppTypography.labelSm.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.spaceSm),
        InkWell(
          onTap:
              onRemovePhoto ??
              () => showCustomSnackBar(
                context,
                message: 'Avatar removed • DELETE /profile/avatar',
                type: SnackBarType.error,
              ),
          borderRadius: BorderRadius.circular(AppSpacing.margin),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.spaceMd,
              vertical: AppSpacing.spaceSm,
            ),
            decoration: BoxDecoration(
              color: AppColors.error.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppSpacing.margin),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.delete_outline_rounded,
                  size: AppSpacing.spaceMd,
                  color: AppColors.error,
                ),
                const SizedBox(width: AppSpacing.spaceXs),
                Text(
                  'Remove',
                  style: AppTypography.labelSm.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.error,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
