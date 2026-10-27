import 'package:aura/features/orders/domain/entities/order_entity.dart';
import 'package:aura/features/profile/data/services/user_address_manager.dart';
import 'package:aura/features/profile/data/services/user_payment_manager.dart';
import 'package:aura/features/wishlist/domain/entities/sub_entities/wishlist_item_entity.dart';

class ProfileMetricsData {
  final String deliveredCount;
  final int activeOrdersCount;
  final String activeOrdersSubtitle;
  final int curationsCount;
  final String wishlistSubtitle;
  final String totalOrdersCount;
  final List<String> allUniqueAddresses;
  final String addressesCountText;
  final String addressesSubtitle;
  final String vaultPayStatus;
  final String vaultPaySubtitle;

  const ProfileMetricsData({
    required this.deliveredCount,
    required this.activeOrdersCount,
    required this.activeOrdersSubtitle,
    required this.curationsCount,
    required this.wishlistSubtitle,
    required this.totalOrdersCount,
    required this.allUniqueAddresses,
    required this.addressesCountText,
    required this.addressesSubtitle,
    required this.vaultPayStatus,
    required this.vaultPaySubtitle,
  });

  factory ProfileMetricsData.calculate({
    required List<OrderEntity> orders,
    required List<WishlistItemEntity> wishlistItems,
  }) {
    final deliveredOrders = orders
        .where((o) => o.status.toLowerCase() == 'delivered')
        .toList();
    final deliveredCount = deliveredOrders.length.toString();

    final activeOrders = orders.where((o) {
      final st = o.status.toLowerCase();
      return st == 'pending' || st == 'shipped' || st == 'processing';
    }).toList();
    final activeCount = activeOrders.length;

    final String activeOrdersSubtitle;
    if (activeCount > 0) {
      activeOrdersSubtitle = activeCount == 1
          ? '1 active order in progress'
          : '$activeCount active orders in progress';
    } else {
      activeOrdersSubtitle = orders.isEmpty
          ? 'No orders placed yet'
          : '${orders.length} completed • History';
    }

    final curationsCount = wishlistItems.length;

    final dropCount = wishlistItems
        .where((i) =>
            i.originalPrice != null && i.originalPrice! > i.price)
        .length;

    final String wishlistSubtitle;
    if (dropCount > 0) {
      wishlistSubtitle =
          '$dropCount Price Drop Alert${dropCount > 1 ? 's' : ''}';
    } else if (curationsCount > 0) {
      wishlistSubtitle =
          '$curationsCount item${curationsCount > 1 ? 's' : ''} curated';
    } else {
      wishlistSubtitle = 'No items saved yet';
    }

    final totalOrdersCount = orders.length.toString();

    final savedAddresses = UserAddressManager.getSavedAddresses();
    final allUniqueAddresses = savedAddresses.isNotEmpty
        ? savedAddresses.map((a) => a.address).toSet().toList()
        : orders
            .map((o) => o.shippingAddress.trim())
            .where((a) => a.isNotEmpty && a != 'Nasr City, Cairo, Egypt')
            .toSet()
            .toList();

    final addressesCountText = allUniqueAddresses.isNotEmpty
        ? '${allUniqueAddresses.length} Saved'
        : '0 Saved';
    final addressesSubtitle = allUniqueAddresses.isNotEmpty
        ? 'Manage delivery locations'
        : 'Add delivery address';

    const vaultPayStatus = 'Verified';
    final vaultPaySubtitle =
        UserPaymentManager.getPreferredPaymentSubtitle();

    return ProfileMetricsData(
      deliveredCount: deliveredCount,
      activeOrdersCount: activeCount,
      activeOrdersSubtitle: activeOrdersSubtitle,
      curationsCount: curationsCount,
      wishlistSubtitle: wishlistSubtitle,
      totalOrdersCount: totalOrdersCount,
      allUniqueAddresses: allUniqueAddresses,
      addressesCountText: addressesCountText,
      addressesSubtitle: addressesSubtitle,
      vaultPayStatus: vaultPayStatus,
      vaultPaySubtitle: vaultPaySubtitle,
    );
  }
}
