import 'package:flutter/material.dart';

class ProductUiHelper {
  const ProductUiHelper._();

  static String formatPrice(double price) {
    return '${price.toStringAsFixed(0)} EGP';
  }

  static String formatPriceDecimal(double price) {
    return '${price.toStringAsFixed(2)} EGP';
  }

  static String? formatComparePrice(num? compareAtPrice) {
    if (compareAtPrice == null) return null;
    return '${compareAtPrice.toStringAsFixed(0)} EGP';
  }

  static String formatReviewsHeader(int count) {
    if (count > 0) {
      return '$count Authenticated Opinion${count > 1 ? 's' : ''}';
    }
    return 'Reviews';
  }

  static String getStockBadgeText(bool inStock) {
    return inStock ? 'IN STOCK' : 'OUT OF STOCK';
  }

  static Color getStockBadgeColor(bool inStock) {
    return inStock ? const Color(0xFF2E7D32) : const Color(0xFFC62828);
  }

  static Color getStockBadgeBg(bool inStock) {
    return inStock ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE);
  }
}
