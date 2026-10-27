import 'dart:convert';
import 'package:aura/core/databases/cache/cache_helper.dart';

class SavedCardModel {
  final String id;
  final String last4;
  final String holderName;
  final String expiry;
  final String cardBrand; // 'visa', 'mastercard', 'amex'
  final bool isDefault;

  const SavedCardModel({
    required this.id,
    required this.last4,
    required this.holderName,
    required this.expiry,
    this.cardBrand = 'visa',
    this.isDefault = false,
  });

  SavedCardModel copyWith({
    String? id,
    String? last4,
    String? holderName,
    String? expiry,
    String? cardBrand,
    bool? isDefault,
  }) {
    return SavedCardModel(
      id: id ?? this.id,
      last4: last4 ?? this.last4,
      holderName: holderName ?? this.holderName,
      expiry: expiry ?? this.expiry,
      cardBrand: cardBrand ?? this.cardBrand,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  factory SavedCardModel.fromJson(Map<String, dynamic> json) {
    return SavedCardModel(
      id: json['id']?.toString() ?? '',
      last4: json['last4'] as String? ?? '4242',
      holderName: json['holder_name'] as String? ?? 'Aura Client',
      expiry: json['expiry'] as String? ?? '12/28',
      cardBrand: json['card_brand'] as String? ?? 'visa',
      isDefault: json['is_default'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'last4': last4,
      'holder_name': holderName,
      'expiry': expiry,
      'card_brand': cardBrand,
      'is_default': isDefault,
    };
  }
}

class UserPaymentManager {
  static const String _preferredMethodKey = 'AURA_PREFERRED_PAYMENT_METHOD';
  static const String _savedCardsKey = 'AURA_SAVED_PAYMENT_CARDS';

  /// Get preferred payment method: 'cod', 'card', or 'wallet'
  static String getPreferredPaymentMethod() {
    final method = CacheHelper.getDataString(key: _preferredMethodKey);
    if (method != null && method.isNotEmpty) {
      return method;
    }
    return 'cod';
  }

  /// Set preferred payment method
  static Future<void> setPreferredPaymentMethod(String method) async {
    await CacheHelper.saveData(key: _preferredMethodKey, value: method);
  }

  /// Get human-readable subtitle for Vault Pay tile
  static String getPreferredPaymentSubtitle() {
    final method = getPreferredPaymentMethod();
    if (method == 'cod') {
      return 'Preferred: COD';
    } else if (method == 'wallet') {
      return 'Preferred: Vault Wallet';
    } else {
      final defaultCard = getDefaultCard();
      if (defaultCard != null) {
        final brand = defaultCard.cardBrand.toUpperCase();
        return 'Preferred: $brand •• ${defaultCard.last4}';
      }
      return 'Preferred: Cards';
    }
  }

  /// Get all saved cards
  static List<SavedCardModel> getSavedCards() {
    try {
      final jsonStr = CacheHelper.getDataString(key: _savedCardsKey);
      if (jsonStr == null || jsonStr.trim().isEmpty) {
        return [];
      }
      final List<dynamic> decoded = jsonDecode(jsonStr);
      return decoded
          .map((item) => SavedCardModel.fromJson(Map<String, dynamic>.from(item)))
          .toList();
    } catch (_) {
      return [];
    }
  }

  /// Get default card
  static SavedCardModel? getDefaultCard() {
    final list = getSavedCards();
    if (list.isEmpty) return null;
    return list.firstWhere((c) => c.isDefault, orElse: () => list.first);
  }

  /// Save or update a card
  static Future<void> saveCard(SavedCardModel newCard) async {
    final list = getSavedCards();
    final index = list.indexWhere((c) => c.id == newCard.id);

    List<SavedCardModel> updated;
    if (newCard.isDefault) {
      updated = list.map((c) => c.copyWith(isDefault: false)).toList();
    } else {
      updated = List.from(list);
    }

    if (index >= 0) {
      updated[index] = newCard;
    } else {
      final cardToAdd =
          updated.isEmpty ? newCard.copyWith(isDefault: true) : newCard;
      updated.add(cardToAdd);
    }

    await _persistCards(updated);
  }

  /// Delete card
  static Future<void> deleteCard(String id) async {
    final list = getSavedCards();
    final updated = list.where((c) => c.id != id).toList();
    if (updated.isNotEmpty && !updated.any((c) => c.isDefault)) {
      updated[0] = updated[0].copyWith(isDefault: true);
    }
    await _persistCards(updated);
  }

  /// Set card as default
  static Future<void> setDefaultCard(String id) async {
    final list = getSavedCards();
    final updated = list.map((c) => c.copyWith(isDefault: c.id == id)).toList();
    await _persistCards(updated);
  }

  static Future<void> _persistCards(List<SavedCardModel> cards) async {
    final jsonStr = jsonEncode(cards.map((c) => c.toJson()).toList());
    await CacheHelper.saveData(key: _savedCardsKey, value: jsonStr);
  }
}
