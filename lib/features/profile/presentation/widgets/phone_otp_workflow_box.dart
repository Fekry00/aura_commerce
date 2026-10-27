import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneOtpWorkflowBox extends StatefulWidget {
  final Future<void> Function(String newPhone)? onSendOtp;
  final Future<void> Function(String newPhone, String otp)? onVerifyOtp;
  final ValueChanged<String>? onVerified;
  final bool isOtpSentInitially;

  const PhoneOtpWorkflowBox({
    super.key,
    this.onSendOtp,
    this.onVerifyOtp,
    this.onVerified,
    this.isOtpSentInitially = false,
  });

  @override
  State<PhoneOtpWorkflowBox> createState() => _PhoneOtpWorkflowBoxState();
}

class _PhoneOtpWorkflowBoxState extends State<PhoneOtpWorkflowBox> {
  final _phoneController = TextEditingController();
  late bool _isOtpSent = widget.isOtpSentInitially;
  bool _isLoading = false;
  final List<TextEditingController> _otpControllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    _phoneController.dispose();
    for (final c in _otpControllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  Future<void> _sendOtp() async {
    final phone = _phoneController.text.trim();
    if (phone.isEmpty) {
      showCustomSnackBar(
        context,
        message: 'يرجى إدخال رقم هاتف صحيح',
        type: SnackBarType.error,
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      if (widget.onSendOtp != null) {
        await widget.onSendOtp!(phone);
      }
      setState(() {
        _isOtpSent = true;
        _isLoading = false;
      });
      if (mounted && _focusNodes.isNotEmpty) {
        _focusNodes[0].requestFocus();
      }
    } catch (_) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _confirmPairing() async {
    final phone = _phoneController.text.trim();
    final otp = _otpControllers.map((c) => c.text.trim()).join();

    if (otp.length != 6) {
      showCustomSnackBar(
        context,
        message: 'يرجى إدخال رمز التحقق المكون من 6 أرقام',
        type: SnackBarType.error,
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      if (widget.onVerifyOtp != null) {
        await widget.onVerifyOtp!(phone, otp);
      }
      widget.onVerified?.call(phone);
      setState(() => _isLoading = false);
    } catch (_) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.spaceSm + AppSpacing.spaceXs),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppSpacing.spaceSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'NEW CELLULAR DESTINATION',
            style: AppTypography.labelCaps.copyWith(
              color: AppColors.onSurfaceVariant,
              fontSize: 10,
            ),
          ),
          const SizedBox(height: AppSpacing.spaceXs),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.spaceSm,
              vertical: AppSpacing.spaceXs / 2,
            ),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(AppSpacing.spaceSm),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.phone_outlined,
                  size: AppSpacing.spaceMd,
                  color: AppColors.outline,
                ),
                const SizedBox(width: AppSpacing.spaceSm),
                Expanded(
                  child: TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    style: AppTypography.bodyMd.copyWith(
                      color: AppColors.onSurface,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'e.g. 010XXXXXXXX',
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                InkWell(
                  onTap: _isLoading ? null : _sendOtp,
                  borderRadius: BorderRadius.circular(AppSpacing.margin),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.spaceMd,
                      vertical: AppSpacing.spaceXs + 1,
                    ),
                    decoration: BoxDecoration(
                      color: _isOtpSent ? AppColors.secondary : AppColors.primary,
                      borderRadius: BorderRadius.circular(AppSpacing.margin),
                    ),
                    child: _isLoading && !_isOtpSent
                        ? const SizedBox(
                            width: 14,
                            height: 14,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            _isOtpSent ? 'Resend' : 'Send OTP',
                            style: AppTypography.labelCaps.copyWith(
                              color: AppColors.onPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
          if (_isOtpSent) ...[
            const SizedBox(height: AppSpacing.spaceMd),
            Text(
              'ENTER 6-DIGIT VERIFICATION TOKEN',
              style: AppTypography.labelCaps.copyWith(
                color: AppColors.onSurfaceVariant,
                fontSize: 10,
              ),
            ),
            const SizedBox(height: AppSpacing.spaceXs),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (i) => _buildOtpBox(i)),
            ),
            const SizedBox(height: AppSpacing.spaceMd),
            InkWell(
              onTap: _isLoading ? null : _confirmPairing,
              borderRadius: BorderRadius.circular(AppSpacing.margin),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: AppSpacing.spaceMd - 2,
                ),
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(AppSpacing.margin),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_isLoading)
                      const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.onSecondary,
                        ),
                      )
                    else ...[
                      const Icon(
                        Icons.lock_open_rounded,
                        size: AppSpacing.spaceMd,
                        color: AppColors.onSecondary,
                      ),
                      const SizedBox(width: AppSpacing.spaceSm),
                      Text(
                        'Confirm Handset Pairing',
                        style: AppTypography.bodyMd.copyWith(
                          color: AppColors.onSecondary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.spaceSm),
          Text(
            'A 6-digit cryptographic verification code will be dispatched to your new handset.',
            style: AppTypography.bodySm.copyWith(
              color: AppColors.onSurfaceVariant,
              fontStyle: FontStyle.italic,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtpBox(int index) {
    return Container(
      width: 44,
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppSpacing.spaceSm),
        border: Border.all(
          color: _focusNodes[index].hasFocus
              ? AppColors.primary
              : AppColors.outlineVariant,
          width: _focusNodes[index].hasFocus ? 1.5 : 1.0,
        ),
      ),
      child: Center(
        child: TextField(
          controller: _otpControllers[index],
          focusNode: _focusNodes[index],
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: AppTypography.headlineSm.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: AppColors.onSurface,
          ),
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: const InputDecoration(
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.zero,
          ),
          onChanged: (val) {
            if (val.isNotEmpty && index < 5) {
              _focusNodes[index + 1].requestFocus();
            } else if (val.isEmpty && index > 0) {
              _focusNodes[index - 1].requestFocus();
            }
          },
        ),
      ),
    );
  }
}
