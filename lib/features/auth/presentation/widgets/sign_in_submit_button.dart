import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class SignInSubmitButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const SignInSubmitButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSpacing.space2Xl,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0B3B2C),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.spaceLg)),
          elevation: 0,
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: AppSpacing.spaceMd,
                    height: AppSpacing.spaceMd,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.spaceSm),
                  Text(
                    'Connecting to Concierge...',
                    style: AppTypography.labelCaps.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sign In to Aura',
                    style: AppTypography.labelCaps.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.spaceSm),
                  const Icon(Icons.arrow_forward, color: Colors.white, size: AppSpacing.spaceMd),
                ],
              ),
      ),
    );
  }
}