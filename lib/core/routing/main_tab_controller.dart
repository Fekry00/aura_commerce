import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

class MainTabController {
  static final ValueNotifier<int> currentIndex = ValueNotifier<int>(0);

  static void switchTab(int index) {
    if (currentIndex.value == index) return;

    final phase = SchedulerBinding.instance.schedulerPhase;
    if (phase == SchedulerPhase.persistentCallbacks) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (currentIndex.value != index) {
          currentIndex.value = index;
        }
      });
    } else {
      currentIndex.value = index;
    }
  }

  static void reset() {
    switchTab(0);
  }
}
