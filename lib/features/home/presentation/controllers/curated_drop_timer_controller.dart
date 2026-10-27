import 'dart:async';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:flutter/material.dart';

class CuratedDropTimerController extends ChangeNotifier {
  CuratedDropTimerController({
    Duration initialDuration = const Duration(hours: 8, minutes: 24, seconds: 11),
  }) : _remainingDuration = initialDuration;

  Duration _remainingDuration;
  Timer? _timer;

  Duration get remainingDuration => _remainingDuration;
  String get formattedHours => _formatNumber(_remainingDuration.inHours);
  String get formattedMinutes =>
      _formatNumber(_remainingDuration.inMinutes.remainder(60));
  String get formattedSeconds =>
      _formatNumber(_remainingDuration.inSeconds.remainder(60));

  void startCountdown() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingDuration.inSeconds <= 0) {
        timer.cancel();
      } else {
        _remainingDuration = _remainingDuration - const Duration(seconds: 1);
        notifyListeners();
      }
    });
  }

  void onDropTap(BuildContext context) {
    showCustomSnackBar(
      context,
      message:
          'Drop 04 starts in $formattedHours hours and $formattedMinutes minutes!',
      type: SnackBarType.info,
    );
  }

  String _formatNumber(int number) => number.toString().padLeft(2, '0');

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
