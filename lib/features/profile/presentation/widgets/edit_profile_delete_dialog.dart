import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class EditProfileDeleteDialog extends StatefulWidget {
  final ValueChanged<String> onConfirmDelete;

  const EditProfileDeleteDialog({
    super.key,
    required this.onConfirmDelete,
  });

  static Future<void> show(
    BuildContext context, {
    required ValueChanged<String> onConfirmDelete,
  }) {
    return showDialog<void>(
      context: context,
      builder: (dialogCtx) => EditProfileDeleteDialog(
        onConfirmDelete: onConfirmDelete,
      ),
    );
  }

  @override
  State<EditProfileDeleteDialog> createState() =>
      _EditProfileDeleteDialogState();
}

class _EditProfileDeleteDialogState extends State<EditProfileDeleteDialog> {
  late final TextEditingController _passwordController;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _onConfirm() {
    if (_formKey.currentState?.validate() ?? false) {
      final pwd = _passwordController.text;
      Navigator.pop(context);
      widget.onConfirmDelete(pwd);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.surfaceContainerLowest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.margin),
      ),
      title: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, color: AppColors.error),
          const SizedBox(width: AppSpacing.spaceSm),
          Text(
            'Delete Account',
            style: AppTypography.headlineSm.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.error,
            ),
          ),
        ],
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'This action is irreversible. All your concierge records, active orders, and membership points will be permanently erased.',
              style: AppTypography.bodySm.copyWith(
                color: AppColors.slateBody,
              ),
            ),
            const SizedBox(height: AppSpacing.spaceMd),
            Text(
              'CONFIRM WITH PASSWORD',
              style: AppTypography.labelCaps.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.spaceXs),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              style: AppTypography.bodySm,
              decoration: InputDecoration(
                hintText: 'Enter your password',
                filled: true,
                fillColor: AppColors.surfaceContainerLow,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.spaceSm),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Password is required to delete account';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancel',
            style: AppTypography.bodyMd.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: _onConfirm,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.error,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpacing.spaceSm),
            ),
          ),
          child: const Text('Confirm Delete'),
        ),
      ],
    );
  }
}
