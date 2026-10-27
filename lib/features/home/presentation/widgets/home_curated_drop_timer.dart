import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class HomeCuratedDropTimer extends StatelessWidget {
  final String hours;
  final String minutes;
  final String seconds;
  final VoidCallback? onTap;

  const HomeCuratedDropTimer({
    super.key,
    required this.hours,
    required this.minutes,
    required this.seconds,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.spaceMd,
          vertical: AppSpacing.spaceSm + 3,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF072118),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Color(0xFF25D366),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: AppSpacing.spaceSm),
            Text(
              'CURATED DROP 04',
              style: AppTypography.labelCaps.copyWith(
                color: const Color(0xFF25D366),
                fontWeight: FontWeight.w700,
                fontSize: 11,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.timer_outlined,
              color: Color(0xFF25D366),
              size: 16,
            ),
            const SizedBox(width: AppSpacing.spaceXs + 2),
            Text(
              '${hours}h : ${minutes}m : ${seconds}s',
              style: AppTypography.bodySm.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}