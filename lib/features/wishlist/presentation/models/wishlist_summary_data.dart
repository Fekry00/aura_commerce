import 'package:aura/features/wishlist/presentation/widgets/wishlist_item_data.dart';

class WishlistSummaryData {
  final double totalAmount;
  final int itemCount;
  final String formattedPrice;
  final String formattedCount;
  final int availableCount;

  const WishlistSummaryData({
    required this.totalAmount,
    required this.itemCount,
    required this.formattedPrice,
    required this.formattedCount,
    required this.availableCount,
  });

  factory WishlistSummaryData.fromItems(List<WishlistItemData> items) {
    final total = items.fold<double>(0.0, (sum, item) => sum + item.price);
    final count = items.length;
    final formattedPrice =
        '${total.toStringAsFixed(total % 1 == 0 ? 0 : 2)} EGP';
    final formattedCount = '$count ${count == 1 ? 'curation' : 'curations'}';
    final available = items
        .where((i) => !i.stockStatus.toLowerCase().contains('out of stock'))
        .length;

    return WishlistSummaryData(
      totalAmount: total,
      itemCount: count,
      formattedPrice: formattedPrice,
      formattedCount: formattedCount,
      availableCount: available,
    );
  }

  static const empty = WishlistSummaryData(
    totalAmount: 0.0,
    itemCount: 0,
    formattedPrice: '0 EGP',
    formattedCount: '0 curations',
    availableCount: 0,
  );
}
