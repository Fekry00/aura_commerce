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
  static const String _legacySavedCardsKey = 'AURA_SAVED_PAYMENT_CARDS';
  static bool _legacyWiped = false;

  /// In-memory mock storage for payment cards (Gateway Tokens).
  /// PCI-DSS Compliance: Sensitive card details or plain JSON arrays are never
  /// persisted to SharedPreferences / plain local storage. In production,
  /// card data is tokenized by the payment gateway (e.g., Stripe / Paymob) and
  /// only non-sensitive gateway customer IDs / tokens are retained.
  static final List<SavedCardModel> _inMemoryCards = [
    const SavedCardModel(
      id: 'tok_aura_default_4242',
      last4: '4242',
      holderName: 'Aura Client',
      expiry: '12/28',
      cardBrand: 'visa',
      isDefault: true,
    ),
  ];

  static void _wipeLegacyPlainStorageIfNeeded() {
    if (!_legacyWiped) {
      _legacyWiped = true;
      try {
        CacheHelper.removeData(key: _legacySavedCardsKey);
      } catch (_) {}
    }
  }

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

  /// Get all saved cards from in-memory token store (PCI-DSS compliant)
  static List<SavedCardModel> getSavedCards() {
    _wipeLegacyPlainStorageIfNeeded();
    return List<SavedCardModel>.from(_inMemoryCards);
  }

  /// Get default card
  static SavedCardModel? getDefaultCard() {
    final list = getSavedCards();
    if (list.isEmpty) return null;
    return list.firstWhere((c) => c.isDefault, orElse: () => list.first);
  }

  /// Save or update a card in memory
  static Future<void> saveCard(SavedCardModel newCard) async {
    _wipeLegacyPlainStorageIfNeeded();
    final index = _inMemoryCards.indexWhere((c) => c.id == newCard.id);

    if (newCard.isDefault) {
      for (int i = 0; i < _inMemoryCards.length; i++) {
        _inMemoryCards[i] = _inMemoryCards[i].copyWith(isDefault: false);
      }
    }

    if (index >= 0) {
      _inMemoryCards[index] = newCard;
    } else {
      final cardToAdd = _inMemoryCards.isEmpty
          ? newCard.copyWith(isDefault: true)
          : newCard;
      _inMemoryCards.add(cardToAdd);
    }
  }

  /// Delete card
  static Future<void> deleteCard(String id) async {
    _wipeLegacyPlainStorageIfNeeded();
    _inMemoryCards.removeWhere((c) => c.id == id);
    if (_inMemoryCards.isNotEmpty && !_inMemoryCards.any((c) => c.isDefault)) {
      _inMemoryCards[0] = _inMemoryCards[0].copyWith(isDefault: true);
    }
  }

  /// Set card as default
  static Future<void> setDefaultCard(String id) async {
    _wipeLegacyPlainStorageIfNeeded();
    for (int i = 0; i < _inMemoryCards.length; i++) {
      _inMemoryCards[i] =
          _inMemoryCards[i].copyWith(isDefault: _inMemoryCards[i].id == id);
    }
  }
}
