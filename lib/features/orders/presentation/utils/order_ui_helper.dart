import 'package:flutter/material.dart';

class OrderUiHelper {
  const OrderUiHelper._();

  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return const Color(0xFFB45309);
      case 'shipped':
      case 'processing':
        return const Color(0xFF1D4ED8);
      case 'delivered':
        return const Color(0xFF065F46);
      case 'cancelled':
        return const Color(0xFF991B1B);
      default:
        return const Color(0xFF0B3B2C);
    }
  }

  static Color getStatusBgColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return const Color(0xFFFEF3C7);
      case 'shipped':
      case 'processing':
        return const Color(0xFFDBEAFE);
      case 'delivered':
        return const Color(0xFFD1FAE5);
      case 'cancelled':
        return const Color(0xFFFEE2E2);
      default:
        return const Color(0xFFE2E8F0);
    }
  }

  static String formatDate(String? rawDate) {
    if (rawDate != null && rawDate.length >= 10) {
      return rawDate.substring(0, 10);
    }
    return 'Recent';
  }

  static String formatPrice(double amount) {
    return '${amount.toStringAsFixed(0)} EGP';
  }

  static String formatPriceDecimal(double amount) {
    return '${amount.toStringAsFixed(2)} EGP';
  }

  static String formatItemsCount(int count) {
    return '$count ${count == 1 ? 'item' : 'items'}';
  }

  static String formatOrderId(int id) {
    return 'Order #AUR-$id';
  }

  static String formatOrderRef(int id) {
    return '#AUR-$id';
  }
}
