import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:flutter/material.dart';

class DeleteAccountBottomSheet extends StatefulWidget {
  final Future<void> Function(String password)? onConfirmDelete;

  const DeleteAccountBottomSheet({super.key, this.onConfirmDelete});

  static Future<void> show(BuildContext context, {Future<void> Function(String password)? onConfirmDelete}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DeleteAccountBottomSheet(onConfirmDelete: onConfirmDelete),
    );
  }

  @override
  State<DeleteAccountBottomSheet> createState() => _DeleteAccountBottomSheetState();
}

class _DeleteAccountBottomSheetState extends State<DeleteAccountBottomSheet> {
  final _passwordCtrl = TextEditingController();

  @override
  void dispose() {
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _handleConfirm() {
    if (_passwordCtrl.text.isEmpty) {
      showCustomSnackBar(context, message: 'Password required to authorize purge', type: SnackBarType.error);
      return;
    }
    Navigator.pop(context);
    widget.onConfirmDelete?.call(_passwordCtrl.text);
    showCustomSnackBar(context, message: 'Account vault decommissioned • DELETE /profile', type: SnackBarType.error);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(AppSpacing.margin, AppSpacing.margin, AppSpacing.margin, MediaQuery.of(context).viewInsets.bottom + AppSpacing.margin),
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSpacing.margin)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: AppSpacing.spaceXl, height: AppSpacing.spaceXs, decoration: BoxDecoration(color: AppColors.outlineVariant, borderRadius: BorderRadius.circular(AppSpacing.spaceXs))),
          const SizedBox(height: AppSpacing.spaceMd),
          Container(
            padding: const EdgeInsets.all(AppSpacing.spaceSm + AppSpacing.spaceXs),
            decoration: BoxDecoration(color: AppColors.error.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: const Icon(Icons.gavel_rounded, size: AppSpacing.spaceLg, color: AppColors.error),
          ),
          const SizedBox(height: AppSpacing.spaceSm),
          Text('Confirm Vault Deletion', style: AppTypography.headlineSm.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: AppSpacing.spaceXs),
          Text('Enter your patron master password to authorize irreversible profile purge (DELETE /api/v1/profile).', textAlign: TextAlign.center, style: AppTypography.bodySm.copyWith(color: AppColors.slateBody)),
          const SizedBox(height: AppSpacing.spaceMd),
          Align(alignment: Alignment.centerLeft, child: Text('MASTER PASSWORD', style: AppTypography.labelCaps.copyWith(color: AppColors.onSurfaceVariant, fontSize: 10))),
          const SizedBox(height: AppSpacing.spaceXs / 2),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.spaceSm + AppSpacing.spaceXs, vertical: AppSpacing.spaceXs / 2),
            decoration: BoxDecoration(color: AppColors.surfaceContainerLow, borderRadius: BorderRadius.circular(AppSpacing.spaceSm)),
            child: Row(
              children: [
                const Icon(Icons.lock_outline_rounded, size: AppSpacing.spaceMd, color: AppColors.outline),
                const SizedBox(width: AppSpacing.spaceSm),
                Expanded(
                  child: TextField(
                    controller: _passwordCtrl,
                    obscureText: true,
                    style: AppTypography.bodyMd.copyWith(color: AppColors.onSurface),
                    decoration: const InputDecoration(hintText: 'Confirm your password', border: InputBorder.none, isDense: true, contentPadding: EdgeInsets.zero),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.spaceMd),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  borderRadius: BorderRadius.circular(AppSpacing.margin),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: AppSpacing.spaceMd - 2),
                    decoration: BoxDecoration(color: AppColors.surfaceContainer, borderRadius: BorderRadius.circular(AppSpacing.margin)),
                    child: Center(child: Text('Cancel', style: AppTypography.bodyMd.copyWith(color: AppColors.onSurface, fontWeight: FontWeight.w600))),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.spaceSm),
              Expanded(
                child: InkWell(
                  onTap: _handleConfirm,
                  borderRadius: BorderRadius.circular(AppSpacing.margin),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: AppSpacing.spaceMd - 2),
                    decoration: BoxDecoration(color: AppColors.error, borderRadius: BorderRadius.circular(AppSpacing.margin)),
                    child: Center(child: Text('Confirm Purge', style: AppTypography.bodyMd.copyWith(color: AppColors.onError, fontWeight: FontWeight.w700))),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
