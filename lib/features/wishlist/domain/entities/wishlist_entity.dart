import 'sub_entities/sanctuary_summary_entity.dart';
import 'sub_entities/wishlist_item_entity.dart';

class WishlistEntity {
  const WishlistEntity({
    required this.sanctuarySummary,
    required this.items,
  });

  final SanctuarySummaryEntity sanctuarySummary;
  final List<WishlistItemEntity> items;
}
