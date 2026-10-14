import 'package:flutter/foundation.dart';

class MainTabController {
  static final ValueNotifier<int> currentIndex = ValueNotifier<int>(0);

  static void switchTab(int index) {
    if (currentIndex.value != index) {
      currentIndex.value = index;
    }
  }

  static void reset() {
    currentIndex.value = 0;
  }
}
