import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/auth/presentation/widgets/verify_password_strength_meter.dart';
import 'package:aura/features/auth/presentation/widgets/verify_password_text_field.dart';
import 'package:flutter/material.dart';

class VerifyNewPasswordSection extends StatefulWidget {
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  const VerifyNewPasswordSection({super.key, required this.passwordController, required this.confirmPasswordController});

  @override
  State<VerifyNewPasswordSection> createState() => _VerifyNewPasswordSectionState();
}

class _VerifyNewPasswordSectionState extends State<VerifyNewPasswordSection> {
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void initState() {
    super.initState();
    widget.passwordController.addListener(_onChanged);
    widget.confirmPasswordController.addListener(_onChanged);
  }

  void _onChanged() => setState(() {});

  @override
  void dispose() {
    widget.passwordController.removeListener(_onChanged);
    widget.confirmPasswordController.removeListener(_onChanged);
    super.dispose();
  }

  int get _strengthScore {
    final t = widget.passwordController.text;
    if (t.isEmpty) return 0;
    return (t.length >= 6 ? 1 : 0) + (t.length >= 8 ? 1 : 0) + (t.contains(RegExp(r'[0-9]')) ? 1 : 0) + ((t.contains(RegExp(r'[!@#\$&*~%^()_\-+=<>?]')) || t.contains(RegExp(r'[A-Z]'))) ? 1 : 0);
  }

  String get _strengthLabel => ['REQUIRED', 'WEAK', 'FAIR', 'GOOD', 'STRONG'][_strengthScore.clamp(0, 4)];

  @override
  Widget build(BuildContext context) {
    final isMatching = widget.confirmPasswordController.text.isNotEmpty && widget.confirmPasswordController.text == widget.passwordController.text;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.vpn_key_outlined, size: 18, color: AppColors.primary),
            const SizedBox(width: AppSpacing.spaceSm),
            Text('Set New Security Password', style: AppTypography.headlineSm.copyWith(color: AppColors.primary, fontWeight: FontWeight.w700)),
          ],
        ),
        const SizedBox(height: AppSpacing.spaceMd),
        Text('NEW PASSWORD', style: AppTypography.labelCaps.copyWith(color: AppColors.onSurfaceVariant)),
        const SizedBox(height: AppSpacing.spaceXs),
        VerifyPasswordTextField(
          controller: widget.passwordController,
          hint: 'Min. 8 characters',
          obscure: _obscurePassword,
          suffix: IconButton(
            icon: Icon(_obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined, size: 20, color: AppColors.onSurfaceVariant),
            onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
          ),
        ),
        const SizedBox(height: AppSpacing.spaceSm),
        VerifyPasswordStrengthMeter(score: _strengthScore, label: _strengthLabel),
        const SizedBox(height: AppSpacing.spaceMd),
        Text('CONFIRM NEW PASSWORD', style: AppTypography.labelCaps.copyWith(color: AppColors.onSurfaceVariant)),
        const SizedBox(height: AppSpacing.spaceXs),
        VerifyPasswordTextField(
          controller: widget.confirmPasswordController,
          hint: 'Re-enter password',
          obscure: _obscureConfirm,
          suffix: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isMatching)
                const Padding(
                  padding: EdgeInsets.only(right: AppSpacing.spaceXs),
                  child: Icon(Icons.check_circle, size: 18, color: AppColors.secondary),
                ),
              IconButton(
                icon: Icon(_obscureConfirm ? Icons.visibility_outlined : Icons.visibility_off_outlined, size: 20, color: AppColors.onSurfaceVariant),
                onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
