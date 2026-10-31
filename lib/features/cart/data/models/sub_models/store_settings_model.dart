import 'package:aura/features/cart/domain/entities/sub_entities/store_settings_entity.dart';

class StoreSettingsModel extends StoreSettingsEntity {
  const StoreSettingsModel({
    super.deliveryFee = 50.0,
    super.vatPercentage = 14.0,
    super.storeName = 'My Awesome Store',
  });

  factory StoreSettingsModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] is Map<String, dynamic>
        ? json['data'] as Map<String, dynamic>
        : json;

    final rawFee = data['delivery_fee'] ?? data['deliveryFee'];
    final fee = rawFee is num
        ? rawFee.toDouble()
        : (double.tryParse(rawFee?.toString() ?? '') ?? 50.0);

    final rawVat = data['vat_percentage'] ?? data['vatPercentage'];
    final vat = rawVat is num
        ? rawVat.toDouble()
        : (double.tryParse(rawVat?.toString() ?? '') ?? 14.0);

    final name = (data['store_name'] ?? data['storeName']) as String? ??
        'My Awesome Store';

    return StoreSettingsModel(
      deliveryFee: fee,
      vatPercentage: vat,
      storeName: name,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'delivery_fee': deliveryFee.toStringAsFixed(0),
      'vat_percentage': vatPercentage.toStringAsFixed(0),
      'store_name': storeName,
    };
  }
}
