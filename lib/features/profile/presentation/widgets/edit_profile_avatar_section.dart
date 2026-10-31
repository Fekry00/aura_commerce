import 'dart:io';
import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/widgets/app_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileAvatarSection extends StatelessWidget {
  final String? avatarUrl;
  final bool isLoading;
  final ValueChanged<String>? onImageSelected;
  final VoidCallback? onRemovePhoto;

  const EditProfileAvatarSection({
    super.key,
    this.avatarUrl,
    this.isLoading = false,
    this.onImageSelected,
    this.onRemovePhoto,
  });

  Future<void> _showPickerOptions(BuildContext context) async {
    final picker = ImagePicker();

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surfaceContainerLowest,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSpacing.margin)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.margin,
              vertical: AppSpacing.spaceLg,
            ),
            child: Material(
              color: Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                Text(
                  'CHANGE PROFILE PICTURE',
                  style: AppTypography.labelCaps.copyWith(
                    color: AppColors.secondary,
                    letterSpacing: 1.4,
                  ),
                ),
                const SizedBox(height: AppSpacing.spaceMd),
                ListTile(
                  leading: const Icon(Icons.photo_camera_rounded, color: AppColors.primary),
                  title: Text(
                    'Take a Photo',
                    style: AppTypography.bodyLg.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.onSurface,
                    ),
                  ),
                  onTap: () async {
                    Navigator.pop(ctx);
                    final picked = await picker.pickImage(
                      source: ImageSource.camera,
                      maxWidth: 1024,
                      maxHeight: 1024,
                      imageQuality: 85,
                    );
                    if (picked != null) {
                      onImageSelected?.call(picked.path);
                    }
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library_rounded, color: AppColors.primary),
                  title: Text(
                    'Choose from Gallery',
                    style: AppTypography.bodyLg.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.onSurface,
                    ),
                  ),
                  onTap: () async {
                    Navigator.pop(ctx);
                    final picked = await picker.pickImage(
                      source: ImageSource.gallery,
                      maxWidth: 1024,
                      maxHeight: 1024,
                      imageQuality: 85,
                    );
                    if (picked != null) {
                      onImageSelected?.call(picked.path);
                    }
                  },
                ),
                if (avatarUrl != null && avatarUrl!.isNotEmpty) ...[
                  const Divider(height: AppSpacing.spaceMd),
                  ListTile(
                    leading: const Icon(Icons.delete_outline_rounded, color: AppColors.error),
                    title: Text(
                      'Remove Photo',
                      style: AppTypography.bodyLg.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.error,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(ctx);
                      onRemovePhoto?.call();
                    },
                  ),
                ],
              ],
            ),
          ),
        ),
      );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasValidUrl = avatarUrl != null &&
        avatarUrl!.isNotEmpty &&
        (avatarUrl!.startsWith('http://') || avatarUrl!.startsWith('https://'));

    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.secondary.withValues(alpha: 0.3),
                width: 3,
              ),
              color: AppColors.surfaceContainerLow,
            ),
            child: ClipOval(
              child: hasValidUrl
                  ? AppCachedImage(
                      imageUrl: avatarUrl!,
                      fit: BoxFit.cover,
                      fallbackIcon: Icons.person_rounded,
                    )
                  : (avatarUrl != null &&
                          avatarUrl!.isNotEmpty &&
                          File(avatarUrl!).existsSync())
                      ? Image.file(
                          File(avatarUrl!),
                          fit: BoxFit.cover,
                        )
                      : const Icon(
                          Icons.person_rounded,
                          size: 54,
                          color: AppColors.outline,
                        ),
            ),
          ),
          if (isLoading)
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withValues(alpha: 0.45),
              ),
              child: const Center(
                child: SizedBox(
                  width: 28,
                  height: 28,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: isLoading ? null : () => _showPickerOptions(context),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.spaceSm),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.surfaceContainerLowest,
                      width: 2.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.camera_alt_rounded,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
