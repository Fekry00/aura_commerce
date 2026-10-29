import 'package:aura/features/cart/domain/entities/sub_entities/voucher_entity.dart';

class VoucherModel extends VoucherEntity {
  const VoucherModel({
    required super.code,
    required super.discountRate,
    required super.label,
    super.type = 'percentage',
    super.value = 0.0,
  });

  factory VoucherModel.fromJson(Map<String, dynamic> json) {
    final code = (json['code'] as String?)?.toUpperCase().trim() ?? '';
    final type = (json['type'] as String?)?.toLowerCase() ?? 'percentage';
    final rawValue = (json['value'] as num?)?.toDouble() ??
        ((json['discount_rate'] ?? json['discountRate']) as num?)?.toDouble() ??
        0.0;

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
      code: code,
      discountRate: discountRate,
      label: (json['label'] as String?) ?? label,
      type: type,
      value: value,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'discount_rate': discountRate,
      'label': label,
      'type': type,
      'value': value,
    };
  }
}
