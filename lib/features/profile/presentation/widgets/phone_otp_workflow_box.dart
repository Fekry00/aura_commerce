import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:flutter/material.dart';

class PhoneOtpWorkflowBox extends StatefulWidget {
  final ValueChanged<String> onVerified;

  const PhoneOtpWorkflowBox({super.key, required this.onVerified});

  @override
  State<PhoneOtpWorkflowBox> createState() => _PhoneOtpWorkflowBoxState();
}

class _PhoneOtpWorkflowBoxState extends State<PhoneOtpWorkflowBox> {
  final _phoneController = TextEditingController(text: '100000000000000000');
  bool _isOtpSent = false;
  final List<TextEditingController> _otpControllers = List.generate(6, (_) => TextEditingController());

  @override
  void dispose() {
    _phoneController.dispose();
    for (final c in _otpControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _sendOtp() {
    if (_phoneController.text.trim().isEmpty) {
      showCustomSnackBar(context, message: 'Please insert valid handset number', type: SnackBarType.error);
      return;
    }
    setState(() => _isOtpSent = true);
    showCustomSnackBar(context, message: 'OTP code dispatched • POST /phone/send-otp');
  }

  void _confirmPairing() {
    widget.onVerified(_phoneController.text.trim());
    showCustomSnackBar(context, message: 'Handset verified • POST /phone/verify-otp', type: SnackBarType.success);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.spaceSm + AppSpacing.spaceXs),
      decoration: BoxDecoration(color: AppColors.surfaceContainerLow, borderRadius: BorderRadius.circular(AppSpacing.spaceSm)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('NEW CELLULAR DESTINATION', style: AppTypography.labelCaps.copyWith(color: AppColors.onSurfaceVariant, fontSize: 10)),
          const SizedBox(height: AppSpacing.spaceXs),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.spaceSm, vertical: AppSpacing.spaceXs / 2),
            decoration: BoxDecoration(color: AppColors.surfaceContainerLowest, borderRadius: BorderRadius.circular(AppSpacing.spaceSm)),
            child: Row(
              children: [
                const Icon(Icons.phone_outlined, size: AppSpacing.spaceMd, color: AppColors.outline),
                const SizedBox(width: AppSpacing.spaceSm),
                Expanded(
                  child: TextField(
                    controller: _phoneController,
                    style: AppTypography.bodyMd.copyWith(color: AppColors.onSurface, fontWeight: FontWeight.w500),
                    decoration: const InputDecoration(border: InputBorder.none, isDense: true, contentPadding: EdgeInsets.zero),
                  ),
                ),
                InkWell(
                  onTap: _isOtpSent ? null : _sendOtp,
                  borderRadius: BorderRadius.circular(AppSpacing.margin),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.spaceMd, vertical: AppSpacing.spaceXs + 1),
                    decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(AppSpacing.margin)),
                    child: Text(_isOtpSent ? 'Sent' : 'Send OTP', style: AppTypography.labelCaps.copyWith(color: AppColors.onPrimary, fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
          ),
          if (_isOtpSent) ...[
            const SizedBox(height: AppSpacing.spaceMd),
            Text('ENTER 6-DIGIT VERIFICATION TOKEN', style: AppTypography.labelCaps.copyWith(color: AppColors.onSurfaceVariant, fontSize: 10)),
            const SizedBox(height: AppSpacing.spaceXs),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (i) => _buildOtpBox(i)),
            ),
            const SizedBox(height: AppSpacing.spaceMd),
            InkWell(
              onTap: _confirmPairing,
              borderRadius: BorderRadius.circular(AppSpacing.margin),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.spaceMd - 2),
                decoration: BoxDecoration(color: AppColors.secondary, borderRadius: BorderRadius.circular(AppSpacing.margin)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.lock_open_rounded, size: AppSpacing.spaceMd, color: AppColors.onSecondary),
                    const SizedBox(width: AppSpacing.spaceSm),
                    Text('Confirm Handset Pairing', style: AppTypography.bodyMd.copyWith(color: AppColors.onSecondary, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.spaceSm),
          Text(
            'A 6-digit cryptographic verification code will be dispatched to your new handset.',
            style: AppTypography.bodySm.copyWith(color: AppColors.onSurfaceVariant, fontStyle: FontStyle.italic, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _buildOtpBox(int index) {
    return Container(
      width: AppSpacing.spaceXl,
      height: AppSpacing.spaceXl + AppSpacing.spaceXs,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppSpacing.spaceSm),
        border: Border.all(color: index == 0 ? AppColors.primary : Colors.transparent, width: index == 0 ? 1.5 : 1.0),
      ),
    );
  }
}
