import 'package:aura/features/cart/domain/entities/sub_entities/voucher_entity.dart';

class VoucherModel extends VoucherEntity {
  const VoucherModel({
    super.id,
    required super.code,
    required super.discountRate,
    required super.label,
    super.type = 'percentage',
    super.value = 0.0,
    super.expiryDate,
  });

  factory VoucherModel.fromJson(Map<String, dynamic> json) {
    final id = (json['id'] as num?)?.toInt();
    final code = (json['code'] as String?)?.toUpperCase().trim() ?? '';
    final type = (json['type'] as String?)?.toLowerCase() ?? 'percentage';
    final expiryDate = (json['expiryDate'] ?? json['expiry_date']) as String?;

    final dynamic raw = json['value'] ?? json['discount_rate'] ?? json['discountRate'];
    final double rawValue = raw is num
        ? raw.toDouble()
        : (double.tryParse(raw?.toString() ?? '') ?? 0.0);

    double discountRate;
    double value;
    String label;

    if (type == 'fixed') {
      value = rawValue;
      discountRate = 0.0;
      label = '-${value.toStringAsFixed(0)} EGP Off';
    } else {
      if (rawValue > 1.0) {
        discountRate = rawValue / 100.0;
        value = rawValue;
      } else if (rawValue > 0.0) {
        discountRate = rawValue;
        value = rawValue * 100.0;
      } else {
        discountRate = 0.0;
        value = 0.0;
      }
      final pctString = (discountRate * 100).round();
      label = '-$pctString% Privilege';
    }

    return VoucherModel(
      id: id,
      code: code,
      discountRate: discountRate,
      label: (json['label'] as String?) ?? label,
      type: type,
      value: value,
      expiryDate: expiryDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'code': code,
      'discount_rate': discountRate,
      'label': label,
      'type': type,
      'value': value,
      if (expiryDate != null) 'expiryDate': expiryDate,
    };
  }
}
