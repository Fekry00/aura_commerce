import 'package:aura/features/wishlist/domain/entities/wishlist_entity.dart';

import 'sub_models/sanctuary_summary_model.dart';
import 'sub_models/wishlist_item_model.dart';

class WishlistModel extends WishlistEntity {
  const WishlistModel({
    required SanctuarySummaryModel super.sanctuarySummary,
    required List<WishlistItemModel> super.items,
  });

  factory WishlistModel.fromJson(Map<String, dynamic> json) {
    return WishlistModel(
      sanctuarySummary: (json['sanctuary_summary'] ?? json['sanctuarySummary']) != null
          ? SanctuarySummaryModel.fromJson(
              (json['sanctuary_summary'] ?? json['sanctuarySummary'])
                  as Map<String, dynamic>,
            )
          : const SanctuarySummaryModel(
              totalAmount: 3659.00,
              itemCount: 4,
              description:
                  'Complimentary bespoke packaging, temperature-controlled transit, and signature arrival handling included.',
            ),
      items: (json['items'] as List<dynamic>? ?? [])
          .map((e) => WishlistItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sanctuary_summary': (sanctuarySummary as SanctuarySummaryModel).toJson(),
      'items': items.map((e) => (e as WishlistItemModel).toJson()).toList(),
    };
  }
}
