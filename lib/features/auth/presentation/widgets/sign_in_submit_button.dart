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
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0B3B2C),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          elevation: 0,
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: AppSpacing.spaceMd,
                    height: AppSpacing.spaceMd,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: AppSpacing.spaceSm + 2),
                  Text(
                    'Connecting to Concierge...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              )
            : const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sign In to Aura',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(width: AppSpacing.spaceSm),
                  Icon(Icons.arrow_forward, color: Colors.white, size: AppSpacing.spaceMd),
                ],
              ),
      ),
    );
  }
}