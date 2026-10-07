import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:flutter/material.dart';

class FastSignInButton extends StatelessWidget {
  const FastSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCustomSnackBar(
          context,
          message: 'Authenticating Face ID...',
          type: SnackBarType.info,
        );
      },
      child: Container(
        width: double.infinity,
        height: 44,
        decoration: BoxDecoration(
          color: const Color(0xFFF0FDF4),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.fingerprint_rounded, size: 16, color: Color(0xFF0B3B2C)),
            const SizedBox(width: 8),
            Text(
              'Fast sign in with Face ID',
              style: AppTypography.bodySm.copyWith(
                color: const Color(0xFF0B3B2C),
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}