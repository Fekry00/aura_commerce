import 'package:aura/features/cart/domain/entities/sub_entities/voucher_entity.dart';

class VoucherModel extends VoucherEntity {
  const VoucherModel({
    required super.code,
    required super.discountRate,
    required super.label,
  });

  factory VoucherModel.fromJson(Map<String, dynamic> json) {
    return VoucherModel(
      code: json['code'] as String? ?? '',
      discountRate:
          ((json['discount_rate'] ?? json['discountRate']) as num?)
              ?.toDouble() ??
          0.10,
      label: json['label'] as String? ?? '-10% VIP Privilege',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'discount_rate': discountRate,
      'label': label,
    };
  }
}
