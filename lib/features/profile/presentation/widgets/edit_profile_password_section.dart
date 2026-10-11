import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:flutter/material.dart';

class EditProfilePasswordSection extends StatefulWidget {
  final Future<void> Function(String curPass, String newPass)? onUpdatePassword;

  const EditProfilePasswordSection({super.key, this.onUpdatePassword});

  @override
  State<EditProfilePasswordSection> createState() => _EditProfilePasswordSectionState();
}

class _EditProfilePasswordSectionState extends State<EditProfilePasswordSection> {
  final _currentPassCtrl = TextEditingController(text: 'secretpass123');
  final _newPassCtrl = TextEditingController();
  final _confirmPassCtrl = TextEditingController();
  bool _obscureCurrent = true, _obscureNew = true, _obscureConfirm = true, _isHovered = false;

  @override
  void dispose() {
    _currentPassCtrl.dispose();
    _newPassCtrl.dispose();
    _confirmPassCtrl.dispose();
    super.dispose();
  }

  void _handleUpdate() {
    if (_currentPassCtrl.text.isEmpty || _newPassCtrl.text.isEmpty || _confirmPassCtrl.text.isEmpty) {
      showCustomSnackBar(context, message: 'Please fill all passkey fields', type: SnackBarType.error);
      return;
    }
    if (_newPassCtrl.text != _confirmPassCtrl.text) {
      showCustomSnackBar(context, message: 'Passkey confirmations do not match', type: SnackBarType.error);
      return;
    }
    widget.onUpdatePassword?.call(_currentPassCtrl.text, _newPassCtrl.text);
    showCustomSnackBar(context, message: 'Passkey updated • POST /auth/change-password', type: SnackBarType.success);
    _newPassCtrl.clear();
    _confirmPassCtrl.clear();
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
          Text('AUTHENTICATION', style: AppTypography.labelCaps.copyWith(color: AppColors.secondary, letterSpacing: 1.2)),
          const SizedBox(height: AppSpacing.spaceXs / 2),
          Text('Access Key & Password', style: AppTypography.headlineSm.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: AppSpacing.spaceXs / 2),
          Text('Update master passkey for atelier security', style: AppTypography.bodySm.copyWith(color: AppColors.slateBody)),
          const SizedBox(height: AppSpacing.spaceMd),
          _buildField('CURRENT PASSWORD', _currentPassCtrl, Icons.vpn_key_outlined, _obscureCurrent, null, () => setState(() => _obscureCurrent = !_obscureCurrent)),
          const SizedBox(height: AppSpacing.spaceSm + AppSpacing.spaceXs),
          _buildField('NEW PASSWORD', _newPassCtrl, Icons.lock_outline_rounded, _obscureNew, 'Minimum 8 characters', () => setState(() => _obscureNew = !_obscureNew)),
          const SizedBox(height: AppSpacing.spaceSm + AppSpacing.spaceXs),
          _buildField('CONFIRM NEW PASSWORD', _confirmPassCtrl, Icons.verified_user_outlined, _obscureConfirm, 'Re-enter new password', () => setState(() => _obscureConfirm = !_obscureConfirm)),
          const SizedBox(height: AppSpacing.spaceMd + AppSpacing.spaceXs),
          InkWell(
            onTap: _handleUpdate,
            onHover: (val) => setState(() => _isHovered = val),
            borderRadius: BorderRadius.circular(AppSpacing.margin),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.spaceMd - 2),
              decoration: BoxDecoration(color: _isHovered ? AppColors.primaryContainer : const Color(0xFFC0C8C3), borderRadius: BorderRadius.circular(AppSpacing.margin)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.key_rounded, size: AppSpacing.spaceMd + 2, color: _isHovered ? AppColors.onPrimary : AppColors.slateHeadline),
                  const SizedBox(width: AppSpacing.spaceSm),
                  Text('Update Passkey', style: AppTypography.bodyMd.copyWith(color: _isHovered ? AppColors.onPrimary : AppColors.slateHeadline, fontWeight: FontWeight.w700)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField(String label, TextEditingController ctrl, IconData icon, bool obscure, String? hint, VoidCallback onToggle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTypography.labelCaps.copyWith(color: AppColors.onSurfaceVariant, fontSize: 10)),
        const SizedBox(height: AppSpacing.spaceXs),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.spaceSm + AppSpacing.spaceXs, vertical: AppSpacing.spaceSm - 1),
          decoration: BoxDecoration(color: AppColors.surfaceContainerLow, borderRadius: BorderRadius.circular(AppSpacing.spaceSm)),
          child: Row(
            children: [
              Icon(icon, size: AppSpacing.spaceMd + 2, color: AppColors.onSurfaceVariant),
              const SizedBox(width: AppSpacing.spaceSm),
              Expanded(
                child: TextField(
                  controller: ctrl,
                  obscureText: obscure,
                  style: AppTypography.bodyMd.copyWith(color: AppColors.onSurface, fontWeight: FontWeight.w500),
                  decoration: InputDecoration(hintText: hint, hintStyle: AppTypography.bodyMd.copyWith(color: AppColors.slateBody, fontSize: 13), border: InputBorder.none, isDense: true, contentPadding: EdgeInsets.zero),
                ),
              ),
              InkWell(onTap: onToggle, child: Icon(obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined, size: AppSpacing.spaceMd + 2, color: AppColors.onSurfaceVariant)),
            ],
          ),
        ),
      ],
    );
  }
}
