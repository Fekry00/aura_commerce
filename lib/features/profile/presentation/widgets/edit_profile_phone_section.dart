import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/profile/presentation/widgets/phone_otp_workflow_box.dart';
import 'package:flutter/material.dart';

class EditProfilePhoneSection extends StatefulWidget {
  final String initialPhoneNumber;
  final ValueChanged<String>? onPhoneUpdated;

  const EditProfilePhoneSection({super.key, this.initialPhoneNumber = '+20 100 000 0000', this.onPhoneUpdated});

  @override
  State<EditProfilePhoneSection> createState() => _EditProfilePhoneSectionState();
}

class _EditProfilePhoneSectionState extends State<EditProfilePhoneSection> {
  late String _phoneNumber = widget.initialPhoneNumber;
  bool _isPanelOpen = false;

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
                  Text('CONCIERGE RELAY', style: AppTypography.labelCaps.copyWith(color: AppColors.secondary, letterSpacing: 1.2)),
                  Text('Security & Contact Link', style: AppTypography.headlineSm.copyWith(fontWeight: FontWeight.w700)),
                ],
              ),
              const Icon(Icons.phonelink_lock_rounded, color: AppColors.outline, size: AppSpacing.spaceLg),
            ],
          ),
          const SizedBox(height: AppSpacing.spaceMd),
          Container(
            padding: const EdgeInsets.all(AppSpacing.spaceSm + AppSpacing.spaceXs),
            decoration: BoxDecoration(color: AppColors.surfaceContainerLow, borderRadius: BorderRadius.circular(AppSpacing.spaceSm)),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.spaceSm),
                  decoration: BoxDecoration(color: AppColors.secondaryContainer.withValues(alpha: 0.2), shape: BoxShape.circle),
                  child: const Icon(Icons.smartphone_rounded, color: AppColors.secondary, size: AppSpacing.spaceMd),
                ),
                const SizedBox(width: AppSpacing.spaceSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_phoneNumber, style: AppTypography.headlineSm.copyWith(fontWeight: FontWeight.w700, fontSize: 16)),
                      const SizedBox(height: AppSpacing.spaceXs / 2),
                      Row(
                        children: [
                          Container(width: AppSpacing.spaceSm - 2, height: AppSpacing.spaceSm - 2, decoration: const BoxDecoration(color: AppColors.secondary, shape: BoxShape.circle)),
                          const SizedBox(width: AppSpacing.spaceXs),
                          Text('Protected by 2-Factor Escrow', style: AppTypography.labelCaps.copyWith(color: AppColors.onSurfaceVariant, fontSize: 10)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.spaceMd),
          InkWell(
            onTap: () => setState(() => _isPanelOpen = !_isPanelOpen),
            borderRadius: BorderRadius.circular(AppSpacing.margin),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.spaceSm + AppSpacing.spaceXs),
              decoration: BoxDecoration(color: AppColors.surfaceContainer, borderRadius: BorderRadius.circular(AppSpacing.margin)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.sync_alt_rounded, size: AppSpacing.spaceMd, color: AppColors.secondary),
                  const SizedBox(width: AppSpacing.spaceSm),
                  Text('Change Phone (via SMS OTP)', style: AppTypography.bodyMd.copyWith(fontWeight: FontWeight.w600, color: AppColors.onSurface)),
                ],
              ),
            ),
          ),
          if (_isPanelOpen) ...[
            const SizedBox(height: AppSpacing.spaceMd),
            PhoneOtpWorkflowBox(
              onVerified: (newPhone) {
                setState(() {
                  _phoneNumber = newPhone;
                  _isPanelOpen = false;
                });
                widget.onPhoneUpdated?.call(newPhone);
              },
            ),
          ],
        ],
      ),
    );
  }
}
