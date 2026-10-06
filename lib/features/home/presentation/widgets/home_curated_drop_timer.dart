import 'dart:async';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:flutter/material.dart';


class HomeCuratedDropTimer extends StatefulWidget {
  const HomeCuratedDropTimer({super.key});

  @override
  State<HomeCuratedDropTimer> createState() => _HomeCuratedDropTimerState();
}

class _HomeCuratedDropTimerState extends State<HomeCuratedDropTimer> {
  late Duration _remainingDuration;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remainingDuration = const Duration(hours: 8, minutes: 24, seconds: 11);
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingDuration.inSeconds <= 0) {
        timer.cancel();
      } else {
        setState(() {
          _remainingDuration = _remainingDuration - const Duration(seconds: 1);
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatNumber(int number) => number.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    final hours = _formatNumber(_remainingDuration.inHours);
    final minutes = _formatNumber(_remainingDuration.inMinutes.remainder(60));
    final seconds = _formatNumber(_remainingDuration.inSeconds.remainder(60));

    return GestureDetector(
      onTap: () {
        showCustomSnackBar(
          context,
          message: 'Drop 04 starts in $hours hours and $minutes minutes!',
          type: SnackBarType.info,
        );
      },
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