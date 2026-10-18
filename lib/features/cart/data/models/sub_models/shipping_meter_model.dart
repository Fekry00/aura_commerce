import 'package:aura/features/cart/domain/entities/sub_entities/shipping_meter_entity.dart';

class ShippingMeterModel extends ShippingMeterEntity {
  const ShippingMeterModel({
    required super.remainingAmount,
    required super.threshold,
    required super.progressRatio,
    required super.progressPercent,
    required super.message,
    required super.isComplimentary,
  });

  factory ShippingMeterModel.fromJson(Map<String, dynamic> json) {
    return ShippingMeterModel(
      remainingAmount: ((json['remaining_amount'] ?? json['remainingAmount'])
              as num?)
          ?.toDouble() ??
          50.0,
      threshold:
          ((json['threshold'] ?? json['shipping_threshold']) as num?)
              ?.toDouble() ??
          2710.0,
      progressRatio: ((json['progress_ratio'] ?? json['progressRatio'])
              as num?)
          ?.toDouble() ??
          0.85,
      progressPercent:
          ((json['progress_percent'] ?? json['progressPercent']) as num?)
              ?.toInt() ??
          85,
      message: (json['message'] as String?) ??
          'Add \$50.00 more for Complimentary Express Courier',
      isComplimentary: ((json['is_complimentary'] ?? json['isComplimentary'])
              as bool?) ??
          false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'remaining_amount': remainingAmount,
      'threshold': threshold,
      'progress_ratio': progressRatio,
      'progress_percent': progressPercent,
      'message': message,
      'is_complimentary': isComplimentary,
    };
  }
}
