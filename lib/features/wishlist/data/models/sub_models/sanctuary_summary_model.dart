import 'package:aura/features/wishlist/domain/entities/sub_entities/sanctuary_summary_entity.dart';

class SanctuarySummaryModel extends SanctuarySummaryEntity {
  const SanctuarySummaryModel({
    required super.totalAmount,
    required super.itemCount,
    required super.description,
  });

  factory SanctuarySummaryModel.fromJson(Map<String, dynamic> json) {
    return SanctuarySummaryModel(
      totalAmount: ((json['total_amount'] ?? json['totalAmount']) as num?)
              ?.toDouble() ??
          0.0,
      itemCount:
          ((json['item_count'] ?? json['itemCount']) as num?)?.toInt() ?? 0,
      description: json['description'] as String? ??
          'Complimentary bespoke packaging, temperature-controlled transit, and signature arrival handling included.',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_amount': totalAmount,
      'item_count': itemCount,
      'description': description,
    };
  }
}
