import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:flutter/material.dart';

class EditProfileCredentialsSection extends StatefulWidget {
  final String initialName, initialEmail;
  final void Function(String name, String email)? onSave;

  const EditProfileCredentialsSection({super.key, this.initialName = 'Ahmed Mohamed', this.initialEmail = 'ahmed.m@auraluxe.com', this.onSave});

  @override
  State<EditProfileCredentialsSection> createState() => _EditProfileCredentialsSectionState();
}

class _EditProfileCredentialsSectionState extends State<EditProfileCredentialsSection> {
  late final TextEditingController _nameController = TextEditingController(text: widget.initialName);
  late final TextEditingController _emailController = TextEditingController(text: widget.initialEmail);

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('IDENTITY', style: AppTypography.labelCaps.copyWith(color: AppColors.secondary, letterSpacing: 1.2)),
                  Text('Personal Credentials', style: AppTypography.headlineSm.copyWith(fontWeight: FontWeight.w700)),
                ],
              ),
              const Icon(Icons.badge_outlined, color: AppColors.outline, size: AppSpacing.spaceLg),
            ],
          ),
          const SizedBox(height: AppSpacing.spaceMd),
          _buildField('FULL NAME', _nameController, Icons.person_outline_rounded),
          const SizedBox(height: AppSpacing.spaceMd),
          _buildField('EMAIL ADDRESS', _emailController, Icons.mail_outline_rounded, badge: _buildVerifiedBadge()),
          const SizedBox(height: AppSpacing.spaceMd),
          InkWell(
            onTap: () {
              widget.onSave?.call(_nameController.text, _emailController.text);
              showCustomSnackBar(context, message: 'Profile credentials saved • PUT /profile', type: SnackBarType.success);
            },
            borderRadius: BorderRadius.circular(AppSpacing.margin),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.spaceMd - 2),
              decoration: BoxDecoration(color: AppColors.primaryContainer, borderRadius: BorderRadius.circular(AppSpacing.margin)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.save_outlined, size: AppSpacing.spaceMd + 2, color: AppColors.onPrimary),
                  const SizedBox(width: AppSpacing.spaceSm),
                  Text('Update Credentials', style: AppTypography.bodyMd.copyWith(color: AppColors.onPrimary, fontWeight: FontWeight.w700)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller, IconData icon, {Widget? badge}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: AppTypography.labelCaps.copyWith(color: AppColors.onSurfaceVariant, fontSize: 10)),
            ?badge,
          ],
        ),
        const SizedBox(height: AppSpacing.spaceXs / 2),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.spaceSm + AppSpacing.spaceXs, vertical: AppSpacing.spaceXs),
          decoration: BoxDecoration(color: AppColors.surfaceContainerLow, borderRadius: BorderRadius.circular(AppSpacing.spaceSm)),
          child: Row(
            children: [
              Icon(icon, size: AppSpacing.spaceMd, color: AppColors.outline),
              const SizedBox(width: AppSpacing.spaceSm),
              Expanded(
                child: TextField(
                  controller: controller,
                  style: AppTypography.bodyMd.copyWith(color: AppColors.onSurface, fontWeight: FontWeight.w500),
                  decoration: const InputDecoration(border: InputBorder.none, isDense: true, contentPadding: EdgeInsets.zero),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVerifiedBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.spaceSm, vertical: AppSpacing.spaceXs / 2),
      decoration: BoxDecoration(color: const Color(0xFFD1FADF), borderRadius: BorderRadius.circular(AppSpacing.margin)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle_rounded, size: AppSpacing.spaceSm + AppSpacing.spaceXs, color: Color(0xFF027A48)),
          const SizedBox(width: AppSpacing.spaceXs / 2),
          Text('Verified', style: AppTypography.labelCaps.copyWith(color: const Color(0xFF027A48), fontSize: 9, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
