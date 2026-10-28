import 'dart:convert';
import 'package:aura/core/databases/cache/cache_helper.dart';
import 'package:aura/features/checkout/data/models/sub_models/shipping_address_model.dart';

class UserAddressManager {
  static const String _storageKey = 'AURA_SAVED_ADDRESSES';

  /// Get list of all saved addresses
  static List<ShippingAddressModel> getSavedAddresses() {
    try {
      final jsonStr = CacheHelper.getDataString(key: _storageKey);
      if (jsonStr == null || jsonStr.trim().isEmpty) {
        return [];
      }
      final List<dynamic> decoded = jsonDecode(jsonStr);
      return decoded
          .map((item) => ShippingAddressModel.fromJson(Map<String, dynamic>.from(item)))
          .where((a) => a.address.trim().isNotEmpty)
          .toList();
    } catch (_) {
      return [];
    }
  }

  /// Get the default address, or the first saved address if any
  static ShippingAddressModel? getDefaultAddress() {
    final list = getSavedAddresses();
    if (list.isEmpty) return null;
    return list.firstWhere((a) => a.isDefault, orElse: () => list.first);
  }

  /// Save or update an address
  static Future<void> saveAddress(ShippingAddressModel newAddress) async {
    final list = getSavedAddresses();
    final index = list.indexWhere((a) => a.id == newAddress.id);
    
    // If set as default, clear default from others
    List<ShippingAddressModel> updated;
    if (newAddress.isDefault) {
      updated = list.map((a) => a.copyWith(isDefault: false)).toList();
    } else {
      updated = List.from(list);
    }

    if (index >= 0) {
      updated[index] = newAddress;
    } else {
      // If first address, make it default automatically
      final addressToAdd = updated.isEmpty ? newAddress.copyWith(isDefault: true) : newAddress;
      updated.add(addressToAdd);
    }

    await _persist(updated);
  }

  /// Delete an address by ID
  static Future<void> deleteAddress(String id) async {
    final list = getSavedAddresses();
    final updated = list.where((a) => a.id != id).toList();
    if (updated.isNotEmpty && !updated.any((a) => a.isDefault)) {
      updated[0] = updated[0].copyWith(isDefault: true);
    }
    await _persist(updated);
  }

  /// Set an address as default
  static Future<void> setDefaultAddress(String id) async {
    final list = getSavedAddresses();
    final updated = list.map((a) => a.copyWith(isDefault: a.id == id)).toList();
    await _persist(updated);
  }

  static Future<void> _persist(List<ShippingAddressModel> addresses) async {
    final listJson = addresses.map((a) => a.toJson()).toList();
    await CacheHelper.saveData(key: _storageKey, value: jsonEncode(listJson));
  }
}

extension ShippingAddressModelCopyWith on ShippingAddressModel {
  ShippingAddressModel copyWith({
    String? id,
    String? label,
    String? recipient,
    String? phone,
    String? address,
    bool? isDefault,
  }) {
    return ShippingAddressModel(
      id: id ?? this.id,
      label: label ?? this.label,
      recipient: recipient ?? this.recipient,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}
