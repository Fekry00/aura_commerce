import 'package:aura/features/category/domain/entities/category_entity.dart';
import 'package:flutter/material.dart';

class CategoryUiHelper {
  static IconData getCategoryIcon(String name, String? slug) {
    final key = '${name.toLowerCase()} ${(slug ?? '').toLowerCase()}';
    if (key.contains('electron') ||
        key.contains('device') ||
        key.contains('phone') ||
        key.contains('tech')) {
      return Icons.devices_outlined;
    } else if (key.contains('cloth') ||
        key.contains('fashion') ||
        key.contains('wear') ||
        key.contains('apparel')) {
      return Icons.checkroom_outlined;
    } else if (key.contains('beaut') ||
        key.contains('skin') ||
        key.contains('care') ||
        key.contains('cosmetic')) {
      return Icons.spa_outlined;
    } else if (key.contains('watch') ||
        key.contains('horolog') ||
        key.contains('time')) {
      return Icons.watch_outlined;
    } else if (key.contains('bag') ||
        key.contains('leather') ||
        key.contains('trunk')) {
      return Icons.shopping_bag_outlined;
    } else if (key.contains('jewel') ||
        key.contains('diamond') ||
        key.contains('gem')) {
      return Icons.diamond_outlined;
    } else if (key.contains('perfume') ||
        key.contains('fragrance') ||
        key.contains('parfum') ||
        key.contains('scent')) {
      return Icons.sanitizer_outlined;
    }
    return Icons.category_outlined;
  }

  static String? getCategoryCoverImage(CategoryEntity cat) {
    if (cat.image != null && cat.image!.trim().isNotEmpty) {
      return cat.image!.trim();
    }
    return null;
  }

  static List<SubDepartmentEntity> getEffectiveSubDepartments(CategoryEntity cat) {
    return cat.subDepartments;
  }

  static SpotlightInfo getCategorySpotlightInfo(CategoryEntity? cat) {
    if (cat == null) {
      return const SpotlightInfo(
        tag: 'AURA COLLECTION',
        season: 'SEASON 2026',
        title: 'Master Curations &\nPrivate Reserves',
        subtitle:
            'Handcrafted luxury collections across master categories and private reserves.',
        reservedCount: 'All Categories',
        image: null,
      );
    }

    return SpotlightInfo(
      tag: 'FEATURED • ${cat.name.toUpperCase()}',
      season: 'SEASON 2026',
      title: '${cat.name} Collection',
      subtitle: cat.description ??
          'Explore authentic luxury creations directly from our private catalogue.',
      reservedCount: cat.creationsCount ?? '${cat.name} Editions',
      image: getCategoryCoverImage(cat),
      targetCategory: cat,
    );
  }
}

class SpotlightInfo {
  final String tag;
  final String season;
  final String title;
  final String subtitle;
  final String reservedCount;
  final String? image;
  final CategoryEntity? targetCategory;

  const SpotlightInfo({
    required this.tag,
    required this.season,
    required this.title,
    required this.subtitle,
    required this.reservedCount,
    this.image,
    this.targetCategory,
  });
}
