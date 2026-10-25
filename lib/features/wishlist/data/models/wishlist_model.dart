import 'package:aura/features/wishlist/domain/entities/wishlist_entity.dart';

import 'sub_models/sanctuary_summary_model.dart';
import 'sub_models/wishlist_item_model.dart';

class WishlistModel extends WishlistEntity {
  const WishlistModel({
    required SanctuarySummaryModel super.sanctuarySummary,
    required List<WishlistItemModel> super.items,
  });

  factory WishlistModel.fromJson(Map<String, dynamic> json) {
    final dataMap = json['data'] is Map<String, dynamic>
        ? json['data'] as Map<String, dynamic>
        : json;

    final rawItems = (dataMap['items'] ?? json['items'] ?? (json['data'] is List ? json['data'] : [])) as List<dynamic>? ?? [];
    final itemsList = rawItems
        .map((e) => WishlistItemModel.fromJson(e as Map<String, dynamic>))
        .toList();

    final totalAmount = itemsList.fold<double>(0.0, (sum, item) => sum + item.price);

    final summary = (json['sanctuary_summary'] ?? json['sanctuarySummary'] ?? dataMap['summary']) != null
        ? SanctuarySummaryModel.fromJson(
            (json['sanctuary_summary'] ?? json['sanctuarySummary'] ?? dataMap['summary'])
                as Map<String, dynamic>,
          )
        : SanctuarySummaryModel(
            totalAmount: totalAmount,
            itemCount: itemsList.length,
            description:
                'Complimentary bespoke packaging, temperature-controlled transit, and signature arrival handling included.',
          );

    return WishlistModel(
      sanctuarySummary: summary,
      items: itemsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sanctuary_summary': (sanctuarySummary as SanctuarySummaryModel).toJson(),
      'items': items.map((e) => (e as WishlistItemModel).toJson()).toList(),
    };
  }
}
