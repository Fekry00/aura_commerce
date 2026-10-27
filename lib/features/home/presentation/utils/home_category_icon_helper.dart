import 'package:flutter/material.dart';

class HomeCategoryIconHelper {
  const HomeCategoryIconHelper._();

  static IconData getCategoryIcon(String name, String? slug) {
    final key = '${name.toLowerCase()} ${(slug ?? '').toLowerCase()}';
    if (key.contains('electron') ||
        key.contains('device') ||
        key.contains('phone')) {
      return Icons.devices_outlined;
    } else if (key.contains('cloth') ||
        key.contains('fashion') ||
        key.contains('wear')) {
      return Icons.checkroom_outlined;
    } else if (key.contains('beaut') ||
        key.contains('skin') ||
        key.contains('care')) {
      return Icons.spa_outlined;
    } else if (key.contains('watch') || key.contains('time')) {
      return Icons.watch_outlined;
    } else if (key.contains('bag') || key.contains('leather')) {
      return Icons.shopping_bag_outlined;
    } else if (key.contains('jewel') || key.contains('diamond')) {
      return Icons.diamond_outlined;
    } else if (key.contains('perfume') || key.contains('fragrance')) {
      return Icons.sanitizer_outlined;
    }
    return Icons.category_outlined;
  }
}
