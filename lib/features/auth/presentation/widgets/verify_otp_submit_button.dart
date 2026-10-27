import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class VerifyOtpSubmitButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const VerifyOtpSubmitButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0B3B2C),
          foregroundColor: Colors.white,
          disabledBackgroundColor:
              const Color(0xFF0B3B2C).withValues(alpha: 0.6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Text(
                'Verify & Proceed',
                style: AppTypography.labelCaps.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  letterSpacing: 1.0,
                ),
              ),
      ),
    );
  }
}
